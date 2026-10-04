/*
 * Игровой поток: перевод CAT.EXE 0x0000..0x0260 (главный цикл, двор, выбор
 * комнаты) и 0x0427 (возврат во двор). Сцены — оверлеи (ovl.h).
 */
#include "game.h"
#include "cat.h"
#include "dog.h"
#include "gfx.h"
#include "hw.h"
#include "ovl.h"
#include "score.h"
#include "snd.h"
#include "memory.h"
#include "tools.h"
#include "data_kernel.h"

uint16_t g_alley_t;      /* [0410] тик ухода со двора (бонус комнаты) */
uint16_t g_felicia_t;    /* [0412] тик начала круга (бонус Фелиции) */
uint16_t g_felicia_n;    /* [0414] пройдено комнат за круг */
uint8_t g_back;          /* [0419] кот возвращается из комнаты */
uint8_t g_menu_done;        /* [041A] */
static uint16_t hist0 = 0xFFFF, hist1 = 0xFFFF;   /* [041D], [041F] */

/* 0x01E5: выбор комнаты — матрица 3x4 по уровню либо плоская таблица,
 * без повтора двух последних подряд */
static uint8_t room_select(void)
{
    uint8_t al;
    do
    {
        uint16_t r = rand16();
        if ((r & 0xA0) && (g_level & 3) != 3)
            al = t_room_matrix[((g_level & 3) << 2) | (r & 3)];
        else
        {
            do r = rand16(); while ((r & 7) >= 5);
            al = t_room_flat[r & 7];
        }
    } while (al == hist0 && al == hist1);
    hist1 = hist0;
    hist0 = al;
    return al;
}

/* залить прямоугольник x,y,w,h за вычетом уже залитого px,py,pw,ph (pw = 0 — нет) */
static void fill_ring(uint16_t x, uint8_t y, uint16_t w, uint8_t h,
                      uint16_t px, uint8_t py, uint16_t pw, uint8_t ph, uint8_t pattern)
{
    if (!pw)
    {
        gfx_fill(POS_XY(x, y), SZ(h, w >> 2), pattern);
        return;
    }
    if (py > y) gfx_fill(POS_XY(x, y), SZ(py - y, w >> 2), pattern);
    uint8_t pb = (uint8_t)(py + ph), b = (uint8_t)(y + h);
    if (b > pb) gfx_fill(POS_XY(x, pb), SZ(b - pb, w >> 2), pattern);
    if (px > x) gfx_fill(POS_XY(x, py), SZ(ph, (px - x) >> 2), pattern);
    uint16_t pr = px + pw, r = x + w;
    if (r > pr) gfx_fill(POS_XY(pr, py), SZ(ph, (r - pr) >> 2), pattern);
}

/*
 * 0x1C67: «шторка» — растущие прямоугольники от кота. Оригинал на каждом шаге
 * заново заливает весь прямоугольник; здесь заливается только прирост, а шаг
 * длится столько же, сколько на PC (~30 тактов 8088 на слово + 90 на строку).
 */
void wipe(uint8_t pattern)
{
    uint16_t w = 1;          /* [1835] ширина, пикселей */
    uint8_t h = 8;           /* [1837] */
    uint16_t cx = (cat_x + 0x0C) & 0xFFF0;
    uint8_t dl = (uint8_t)(cat_y + 8);
    uint8_t edges = 0;       /* [1838] */
    uint16_t px = 0, pw = 0;
    uint8_t py = 0, ph = 0;
    for (;;)
    {
        snd_wipe();
        uint16_t words = w >> 3;
        if (words)
        {
            fill_ring(cx, dl, words << 3, h, px, py, pw, ph, pattern);
            px = cx;
            py = dl;
            pw = words << 3;
            ph = h;
        }
        snd_wait((uint16_t)((((words * h) >> 2) * 19 >> 5) + ((h * 7) >> 4)));
        if (edges == 0x0F) return;
        w += 0x20;
        h += 0x10;
        if (cx >= 0x10) cx -= 0x10;
        else
        {
            cx = 0;
            edges |= 1;
        }
        if (w + cx >= 0x140)
        {
            w = 0x140 - cx;
            edges |= 2;
        }
        if (dl >= 8) dl -= 8;
        else
        {
            dl = 0;
            edges |= 4;
        }
        if ((uint16_t)h + dl >= 0xC8)
        {
            h = (uint8_t)(0xC8 - dl);
            edges |= 8;
        }
    }
}

/* 0x1BF0: переход между сценами. Возврат во двор (картинки, бонус) — в оверлее INTER */
void transition(void)
{
    if (g_state == 0)
    {
        ovl_load(OVL_INTER);
        ovl.run();
        return;
    }
    wipe(0);
    snd_off();
    wipe(g_state == 7 || g_state == 2 ? 0x55 : 0xAA);
    snd_off();
}

/* Двор: 0x00F3..0x01E2. Возвращает 0 — в комнату, 1 — титры, 2 — заново, 3 — меню */
static uint8_t alley(void)
{
    snd_off();
    if (g_lives == 0) return 1;
    if (g_restart) return 2;
    if (g_menu) return 3;
    ovl_load(OVL_ALLEYBG);
    ovl.run();
    snd_off();
    g_state = 0;
    if (g_back)
    {
        cat_init_room();
        cat_fence = 2;
        cat_vy = 1;
        cat_dec = 0x20;
    }
    else
    {
        cat_x = 0;
        cat_init_alley();
    }
    ovl_load(OVL_ALLEY);
    ovl.run();
    if (g_restart) return 2;
    if (g_menu) return 3;
    if (g_lives == 0) return 1;
    g_alley_t = ticks();
    g_alley_x = cat_x;
    g_alley_y = cat_y;
    g_back = 1;
    return 0;
}

void main(void)
{
    set_PSW(1 << PSW_I);
    ((union KEY_STATE *)REG_KEY_STATE)->bits.INT_MASK = 1;
    hw_init();
    ovl_init();
    g_skill = 0;
    pause_presses = (uint16_t)(key_presses + 0x240);
    g_state = 0;
    rand_seed(*(volatile uint16_t *)REG_TVE_COUNT);
    digits_clear(g_hiscore);
    digits_clear(g_score);
    g_sound = 0xFF;
title:
    hiscore_update();
    g_level = 0;
    g_state = 0;
    snd_off();
    ovl_load(OVL_TITLE);
    ovl.run();
    snd_off();
    if (g_menu_done) goto newgame;
menu:
    snd_off();
    ovl_load(OVL_TITLE);
    ovl.menu();
    g_menu_done = 1;
newgame:
    g_level = g_skill;
    g_lives = 3;
    digits_clear(g_score);
    g_state = 0;
    snd_off();
    g_fail_pic = 0;
    g_felicia_t = ticks();
    g_felicia_n = 0;
    g_felicia_next = 0;
    g_back = 0;
    g_menu = 0;
    g_restart = 0;
    for (;;)
    {
        switch (alley())
        {
        case 1: goto title;
        case 2: goto newgame;
        case 3: goto menu;
        }
        if (g_felicia_next)
        {
            g_felicia_next = 0;
            g_state = 7;
        }
        else
            g_state = room_select();
        g_prev_state = 0;
        /* комната; из гостиной (1) можно нырнуть в аквариум (2) */
        for (;;)
        {
            ovl_load((uint8_t)(OVL_ROOM0 + g_state));
            ovl.run();
            if (g_state == 1 && cat_to_aqua && !g_restart && !g_menu)
            {
                g_state = 2;
                continue;
            }
            break;
        }
        /* 0x0427 */
        if (g_restart) goto newgame;
        if (g_menu) goto menu;
        if (cat_failed) g_back = 0;
        g_prev_state = g_state;
        g_state = 0;
        transition();
    }
}
