/*
 * Оверлей TITLE: заставка (CAT.EXE 0x5CB0, музыка 0x53B0, кот 0x5DD4,
 * мигание 0x5E3B) и меню (0x5EE5). Текст меню переписан под клавиатуру БК
 * и 32 знакоместа шрифта ПЗУ; проверки адаптера джойстика (0x5FE5) нет.
 */
#include "alley.h"
#include "cat.h"
#include "dog.h"
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "ovl.h"
#include "score.h"
#include "snd.h"
#include "data_kernel.h"
#include "data_title.h"

extern uint8_t g_menu_done;   /* [041A] */
extern uint8_t g_joy;         /* [069B] выбран джойстик */

/* 0x5E3B */
static uint16_t blink_i;      /* [6A8D] */
static void blink(void)
{
    blink_i += 2;
    blit(POS(0x1D38), SZ(12, 20), d_title_blink + ((blink_i & 2) ? 240 : 0), BM_COPY);
}

/* 0x53B0 */
static uint16_t mu_t, mu_i;   /* [5322], [5320] */
static void music(void)
{
    if (!g_sound) return;
    uint16_t t = ticks();
    if (t == mu_t) return;
    mu_t = t;
    uint8_t bl = t_title_notes[mu_i];
    if (bl == 0x66)
    {
        snd_off();
        return;
    }
    ++mu_i;
    if (bl == 0)
    {
        snd_off();
        return;
    }
    snd_tone(t_title_div[bl >> 1]);
}

/* 0x5DD4: кот бродит по забору */
static uint16_t demo_t;       /* [6A88] */
static void demo_cat(void)
{
    if (cat_x <= 0x20) in_dx = 1;
    else if (cat_x >= 0x120) in_dx = 0xFF;
    else
    {
        uint16_t t = ticks();
        if ((uint16_t)(t - demo_t) >= 0x12)
        {
            demo_t = t;
            uint8_t dl = (uint8_t)rand16();
            in_dx = 0;
            if (dl <= 0xA0) in_dx = (dl & 1) ? 1 : 0xFF;
        }
    }
    if (retrace())
    {
        cat_speed = 4;
        cat_update();
    }
}

static void title_run(void)
{
    g_state = 0;
    item_y = 0;          /* 0x1830: окна; остальное состояние двора — в его оверлее */
    g_item_thrown = 0;
    alley_draw_title();
    blit(POS(0x00BD), SZ(29, 22), d_title1, BM_COPY);
    blit(POS(0x069E), SZ(22, 28), d_title2, BM_COPY);
    blit(POS(0x0A78), SZ(12, 6), d_title3, BM_COPY);
    blit(POS(0x0CA8), SZ(8, 28), d_title4, BM_COPY);
    blit(POS(0x1D6E), SZ(11, 24), d_title5, BM_COPY);
    blit(POS(0x1DEC), SZ(8, 8), d_title6, BM_COPY);
    blink_i = 0;
    blink();
    cat_x = 0;
    cat_init_alley();
    cat_y = 0x60;
    cat_ry = 0x92;
    hiscore_draw();
    score_draw();
    g_lives = 9;
    blit(POS(0x1260), SZ(8, 2), d_digits + 9 * 16, BM_COPY);   /* 0x26B3 */
    dog_reset();
    in_dx = 0;
    in_dy = 0;
    uint8_t btn = 0;     /* [6A8A] */
    input_poll();
    uint16_t presses = key_presses;
    for (;;)
    {
        uint16_t t0 = ticks(), tb = t0;
        mu_t = t0;
        demo_t = t0 - 0x30;
        mu_i = 0;
        for (;;)
        {
            uint16_t t = ticks();
            if ((uint16_t)(t - tb) >= 0x24)
            {
                tb = t;
                blink();
            }
            uint16_t dx = (uint16_t)(t - t0);
            if (g_menu_done)
            {
                if (dx >= t_title_len[0] + 0x48) break;
            }
            else if (dx > t_title_len[0] + 6)
                return;
            music();
            demo_cat();
            snd_idle(48);
            input_poll();
            if (g_joy)
            {
                if (joy_button()) btn = 1;
                else if (btn) return;
            }
            if (key_presses != presses) return;
        }
    }
}

/* ------------------------------------------------------------------ меню */

struct line { uint8_t row; const char *s; };

static const struct line m_joy[] = { { 0, "Use a joystick (Y/N)?" }, { 0, 0 } };
static const struct line m_skill[] =
{
    { 2, "Please select your skill level:" },
    { 4, "   (K)itten" },
    { 5, "   (H)ouse Cat" },
    { 6, "   (T)omcat" },
    { 7, "   (A)lley Cat" },
    { 0, 0 }
};
static const struct line m_play[] =
{
    { 9, "During play:" },
    { 10, "   CTRL-S  sound on/off" },
    { 11, "   CTRL-R  restart the game" },
    { 12, "   CTRL-M  back to this menu" },
    { 13, "   P       paws mode" },
    { 0, 0 }
};
static const struct line m_keys[] =
{
    { 15, "Arrows (and Q,E,Z,C for" },
    { 16, "diagonals) control the cat." },
    { 17, "SPACE performs special actions." },
    { 20, "Press any key to start." },
    { 0, 0 }
};
static const struct line m_joys[] =
{
    { 15, "Use the joystick to control" },
    { 16, "the cat. The button performs" },
    { 17, "special actions." },
    { 19, "Center your joystick and press" },
    { 20, "the button to start." },
    { 0, 0 }
};

static void print(const struct line *l)
{
    for (; l->s; ++l) text_at((uint8_t)(l->row << 3), 0, l->s, 3);
}

/* ждать нажатия, вернуть код клавиши */
static uint8_t get_key(void)
{
    input_poll();
    uint16_t p = key_presses;
    do
    {
        wait_tick();
        input_poll();
    }
    while (key_presses == p);
    return key_code();
}

static void menu(void)
{
    snd_off();
    gfx_fill_rows(0, 200, 0);
    print(m_joy);
    for (;;)
    {
        uint8_t k = get_key();
        if (k == 'Y') { g_joy = 1; break; }
        if (k == 'N') { g_joy = 0; break; }
    }
    print(m_skill);
    for (;;)
    {
        uint8_t k = get_key();
        if (k == 'K') { g_skill = 0; break; }
        if (k == 'H') { g_skill = 1; break; }
        if (k == 'T') { g_skill = 2; break; }
        if (k == 'A') { g_skill = 3; break; }
    }
    print(m_play);
    print(g_joy ? m_joys : m_keys);
    /* 0x5F97 */
    if (g_joy)
    {
        while (!joy_button()) wait_tick();
    }
    else
        get_key();
}

void ovl_entry(void)
{
    ovl.run = title_run;
    ovl.menu = menu;
    hooks.items_hit = 0;
    hooks.land = alley_land;
    hooks.can_mouse = 0;
    hooks.busy = 0;
    hooks.swim = 0;
    hooks.floor_step = 0;
}
