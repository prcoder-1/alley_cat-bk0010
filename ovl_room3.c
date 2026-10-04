/*
 * Оверлей ROOM3: библиотека (CAT.EXE 0x0394..0x03DF, 0x3B30..0x3E6E).
 * Цель — сбить три горшка с цветами наверху шкафа; паук ловит кота.
 */
#include "cat.h"
#include "dog.h"
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "ovl.h"
#include "room.h"
#include "score.h"
#include "snd.h"
#include "data_room3.h"

uint8_t kennel_drinking, cheese_jump;
uint8_t (*room_extra_land)(void);

static const uint16_t pot_x[3] = { 0xC0, 0xE0, 0x100 };          /* [37A3] */
static const uint16_t pot_pos[3] = { POS(0x3F0), POS(0x3F8), POS(0x400) };  /* [37A9] */
static uint8_t pots_left;      /* [37AF] */
static uint16_t pot_on[3];     /* [37B0] слова */
static uint16_t pots_t;        /* [37B8] */

static uint16_t sp_x;          /* [3964] */
static uint8_t sp_y;           /* [3966] */
static uint8_t sp_dir;         /* [3967] 1 вниз, 0xFF вверх, 0 стоит */
static uint16_t sp_spos;       /* [3968] */
static uint8_t sp_hidden;      /* [396A] */
static uint16_t sp_frame;      /* [396B] 0 или 0x54 */
static uint8_t sp_anim;        /* [396D] */
static uint8_t sp_n;           /* [396E] */
static uint16_t sp_t;          /* [39C8] */
static uint16_t sp_pos;        /* [39CA] */
static uint8_t sp_save[SAVE_SIZE(14, 6)];   /* [396F] */
static uint8_t byte_save[SAVE_SIZE(21, 12)];

/* 0x3E14 / 0x3E38 */
static void spider_draw(void)
{
    sp_spos = sp_pos;
    sp_hidden = 0;
    gfx_blit(sp_pos, SZ(14, 6), d_spider + sp_frame, sp_save, BM_KEY, 0);
}

static void spider_erase(void)
{
    if (sp_hidden) return;
    gfx_restore(sp_spos, SZ(14, 6), sp_save);
}

/* 0x3E52 / 0x3E6E */
static uint8_t spider_broom(void)
{
    return rect_hit(sp_x, sp_y, 0x18, 0x0E, broom_x, broom_y, 0x10, 0x1E);
}

static uint8_t spider_cat(void)
{
    return rect_hit(sp_x, sp_y, 0x18, 0x0E, cat_x, cat_y, 0x18, 0x0E);
}

/* 0x3C43: полки шкафа */
static uint8_t shelf_land(void)
{
    uint16_t ax = cat_x & 0xFFFC;
    if (ax < 0xA4 || ax > 0x118) return 0;
    uint8_t dl = (uint8_t)((cat_y - 2) & 0xF8);
    if (!(dl & 8) || dl < 0x28 || dl > 0xA0) return 0;
    cat_x = ax;
    cat_y = (uint8_t)(dl + 2);
    cat_ry = (uint8_t)(dl + 0x34);
    cat_onrope = 1;
    return 1;
}

/* 0x3BA3: горшок упал */
static void pot_remove(uint8_t i)
{
    pot_on[i] = 0;
    gfx_fill(pot_pos[i], SZ(16, 4), SWAPC(0xAA));
    if (--pots_left == 0 && !cat_failed) cat_won = 1;
}

/* 0x3B42 */
static void pots_update(void)
{
    uint16_t t = ticks();
    if (t == pots_t) return;
    pots_t = t;
    for (int8_t i = 2; i >= 0; --i)
    {
        if (!pot_on[i]) continue;
        if (!rect_hit(pot_x[i], 0x18, 0x10, 0x10, cat_x, cat_y, 0x18, 0x0E)) continue;
        snd_beep(0xC00, 0x8FD);
        cat_erase();
        spider_erase();
        pot_remove((uint8_t)i);
        cat_save_bg();
        spider_draw();
        return;
    }
}

/* 0x3D90: паук поймал кота */
static void spider_catch(void)
{
    if (cat_won) return;
    uint16_t cx = cat_x >= 0x0C ? cat_x - 0x0C : 0;
    if (cx >= 0x10F) cx = 0x10E;
    uint8_t dl = cat_y >= 4 ? (uint8_t)(cat_y - 4) : 0;
    gfx_blit(POS_XY(cx, dl), SZ(21, 12), d_byte, byte_save, BM_KEY, 0);
    snd_spider_init();
    sp_t = ticks();
    while ((uint16_t)(ticks() - sp_t) < 9) snd_spider();
    cat_failed = 1;
}

/* 0x3CB1 */
static void spider_update(void)
{
    uint16_t t = ticks();
    if ((uint16_t)(t - sp_t) < 2) return;
    sp_t = t;
    if (spider_broom()) return;
    if (spider_cat())
    {
        spider_catch();
        return;
    }
    uint16_t v = t_spider_v[g_level];
    uint16_t px = sp_x;
    uint8_t py = sp_y;
    if (sp_y == 8)
    {
        if ((sp_x & 0xFFF8) == (cat_x & 0xFFF8))
        {
            sp_dir = 1;
            sp_n = 1;
        }
        else
        {
            if ((sp_x & 0xFFF8) > (cat_x & 0xFFF8))
                sp_x = sp_x >= v ? sp_x - v : 0;
            else
                sp_x += v;
            goto moved;
        }
    }
    {
        uint8_t al = sp_y;
        ++sp_n;
        uint8_t dl = (uint8_t)(((sp_n >> 2) & 3) + 2);
        if (sp_dir != 1)
        {
            if (al < dl || (al -= dl) < 9)
            {
                al = 8;
                sp_dir = 0;
            }
        }
        else
        {
            al += dl;
            uint16_t d = sp_x >= cat_x ? sp_x - cat_x : (uint16_t)~(sp_x - cat_x);
            if (al > cat_y || d > 0x30)
                sp_dir = 0xFF;
            else if (al >= 0xA0)
            {
                al = 0x9F;
                sp_dir = 0xFF;
            }
        }
        sp_y = al;
    }
moved:
    if (spider_broom())
    {
        sp_x = px;
        sp_y = py;
        return;
    }
    if (spider_cat())
    {
        spider_catch();
        return;
    }
    sp_pos = POS_XY(sp_x, sp_y);
    spider_erase();
    if (--sp_anim == 0)
    {
        sp_anim = 2;
        sp_frame ^= 0x54;
    }
    spider_draw();
}

/* 0x3BDB: шкаф — случайные книги */
static void books_draw(void)
{
    uint16_t row = POS(0x66A);
    for (uint8_t cl = 0x10; cl; --cl, row += 8 << 8)
    {
        uint8_t al = 0;
        for (uint8_t bx = 0; ; )
        {
            uint8_t prev = al;
            blit((uint16_t)(row + bx), SZ(8, 2), d_books + al, BM_COPY);
            bx += 2;
            if (bx > 0x1E) break;
            if (bx == 0x1E)
            {
                al = 0x20;
                continue;
            }
            if (prev != 0x50 && !(cl & 1) && (uint8_t)rand16() >= 0x40)
            {
                al = 0x10;
                continue;
            }
            al = (uint8_t)((((uint8_t)rand16() - bx) & 0x30) + 0x30);
        }
    }
}

static void draw(void)
{
    room_frame(0x640);
    room_list(0x2570, 0xC90);
    room_win_x = 0x60;
    room_win_y = 0x60;
    room_chairs(0x140C);
    room_lamp(0x1418);
    room_list(0x2344, 0x1184);
    room_list(0x2344, 0x11A2);
    room_list(0x2624, 0);
    books_draw();
}

/* 0x3B30 */
static void pots_init(void)
{
    pots_left = 3;
    pot_on[0] = pot_on[1] = pot_on[2] = 1;
}

/* 0x3C90 */
static void spider_init(void)
{
    sp_y = 8;
    sp_hidden = 1;
    sp_dir = 0;
    sp_anim = 2;
    sp_x = 0x118;
    sp_frame = 0;
}

static void run(void)
{
    g_state = 3;
    transition();
    draw();
    cat_init_room();
    broom_init();
    dog_reset();
    pots_init();
    spider_init();
    snd_rhythm_reset();
    for (;;)
    {
        g_passes = loop_passes();
        hotkeys();
        input_update();
        snd_rhythm();
        cat_update();
        spider_update();
        pots_update();
        broom_update();
        dog_update();
        if (cat_failed | cat_won | cat_exit | g_menu | g_restart) return;
        snd_idle(48);
    }
}

void ovl_entry(void)
{
    ovl.run = run;
    hooks.items_hit = 0;
    hooks.land = room_land;
    hooks.can_mouse = 0;
    hooks.busy = 0;
    hooks.swim = 0;
    hooks.floor_step = room_floor_step;
    room_extra_land = shelf_land;
}
