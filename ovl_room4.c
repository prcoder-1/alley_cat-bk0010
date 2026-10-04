/*
 * Оверлей ROOM4: кладовая с сыром (CAT.EXE 0x0349..0x0391, 0x3E90..0x433F).
 * Поймать 4 мыши, пока они выглядывают из дырок; кот ныряет из дырки в дырку.
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
#include "data_room4.h"

uint8_t kennel_drinking, cheese_jump;   /* [39E1] */
uint8_t (*room_extra_land)(void);

static uint16_t jump_src;     /* [39E2] */
static uint16_t jump_srcv;    /* [39E4] */
static uint16_t jump_dst;     /* [39E6] */
static uint16_t jump_dstv;    /* [39E8] */
static uint16_t jump_x;       /* [3D03] */
static uint8_t jump_y;        /* [3D05] */
static uint16_t jump_t;       /* [3D16] */
static uint16_t jump_t0;      /* [3D18] */
static uint8_t hole_link[16]; /* [3CE3] */

static uint16_t m_pos[4];     /* [3EA6] */
static uint8_t m_hidden[4];   /* [3EAE] */
static uint8_t m_caught[4];   /* [3EB2] */
static uint8_t m_timer[4];    /* [3EB6] */
static uint16_t m_hole[4];    /* [3EBA] */
static uint16_t m_spr;        /* [3ECA] */
static uint16_t m_x[4];       /* [3ECC] */
static uint8_t m_y[4];        /* [3ED4] */
static uint8_t m_left;        /* [3ED8] */
static uint8_t m_tries;       /* [3ED9] */
static uint16_t m_i;          /* [3EDA] */
static uint16_t m_t;          /* [3EDC] */
static uint16_t m_npos;       /* [3DE4] */
static uint8_t m_save[4][SAVE_SIZE(12, 4)];   /* [3EC2] */

#define HOLE_POS(i) (*(const uint16_t *)(d_cheese + (0x3C5A - CHEESE_GFX) + ((i) << 2)))

/* 0x4065: кот у метлы */
static uint8_t cat_broom(void)
{
    return rect_hit(broom_x, broom_y, 0x10, 0x1E, cat_x, cat_y, 0x18, 0x0E);
}

/* 0x3E90: прыжок в дырку (кнопка) */
static void jump_update(void)
{
    if (cheese_jump)
    {
        if (ticks() == jump_t) return;
    }
    else
    {
        if (cat_thrown || in_btn != 0 || cheese_hole == 0) return;
        if (cat_broom()) return;
        uint16_t t = ticks();
        if ((uint16_t)(t - jump_t0) < 0x0C) return;
        jump_t0 = t;
        cat_onrope = 0;
        uint8_t bl = (uint8_t)(cheese_hole - 1);
        jump_src = HOLE_POS(bl);
        jump_srcv = bl < 3 ? 0x80 : 0;
        bl = hole_link[bl];
        jump_dst = HOLE_POS(bl);
        jump_dstv = bl < 3 ? 0x80 : 0;
        jump_y = t_hole_y[bl];
        jump_x = t_hole_x[bl] + 8;
        cat_erase();
        cheese_jump = 0x0E;
        in_btn = 0x10;
    }
    if (!dog_active) broom_erase();
    cheese_jump -= 2;
    uint8_t bl = cheese_jump;
    uint16_t di, ax;
    if (bl >= 8)
    {
        di = jump_src;
        ax = jump_srcv;
    }
    else
    {
        di = jump_dst;
        cat_y = jump_y;
        cat_ry = (uint8_t)(jump_y + 0x32);
        cat_x = jump_x;
        ax = jump_dstv;
    }
    uint16_t si = ax + t_hole_frm[bl >> 1];
    blit(pos_of(di), SZ(16, 4), d_cheese + (si - CHEESE_GFX), BM_COPY);
    if (!dog_active) broom_draw();
    jump_t = ticks();
    if (cheese_jump == 0) cat_redraw();
}

/* 0x42B4 */
static void mouse_place(uint8_t bx)
{
    uint16_t di = m_hole[bx];
    uint8_t dl = di < 3 ? 0 : 0x0A;
    m_y[bx] = (uint8_t)(t_hole_y[di] - dl + 3);
    m_x[bx] = t_hole_x[di] + 8;
}

/* 0x431C: кот ближе bp? */
static uint8_t mouse_near(uint8_t bx, uint16_t bp)
{
    uint16_t ax = m_x[bx] >= cat_x ? m_x[bx] - cat_x : (uint16_t)~(m_x[bx] - cat_x);
    uint8_t dl = m_y[bx] >= cat_y ? (uint8_t)(m_y[bx] - cat_y) : (uint8_t)~(uint8_t)(m_y[bx] - cat_y);
    return (uint16_t)(ax + dl) < bp;
}

/* 0x4277: новая дырка — свободная и не рядом с котом */
static void mouse_hole(uint8_t bx)
{
    m_tries = 0x20;
again:
    {
        uint16_t dx = rand16() & 0x0F;
        for (uint8_t k = 0; k < 4; ++k)
            if (k != bx && dx == m_hole[k]) goto again;
        m_hole[bx] = dx;
    }
    mouse_place(bx);
    if (m_tries && mouse_near(bx, 0x32))
    {
        --m_tries;
        goto again;
    }
}

/* 0x42DB / 0x42FC */
static uint8_t mouse_cat(uint8_t bx)
{
    return rect_hit(m_x[bx], m_y[bx], 0x10, 0x0C, cat_x, cat_y, 0x18, 0x0E);
}

static uint8_t mouse_broom(uint8_t bx)
{
    return rect_hit(m_x[bx], m_y[bx], 0x10, 0x0C, broom_x, broom_y, 0x10, 0x1E);
}

/* 0x4254 */
static void mouse_erase(uint8_t bx)
{
    if (m_hidden[bx]) return;
    gfx_restore(m_pos[bx], SZ(12, 4), m_save[bx]);
}

/* 0x4124: поймать (если мышь видна) */
static void mouse_catch(uint8_t bx)
{
    if (m_hidden[bx] || m_timer[bx] >= 0x14) return;
    cat_erase();
    mouse_erase(bx);
    m_caught[bx] = 1;
    cat_save_bg();
    cat_onrope = 0;
    if (--m_left == 0) cat_won = 1;
    /* трофей вверху слева */
    blit(POS(0x51 + ((4 - m_left) << 2)), SZ(12, 4), d_mouse4, BM_AND);
    snd_beep(0x3E8, 0x2EE);
}

/* 0x40C2 */
static void mice_update(void)
{
    uint16_t t = ticks();
    if (t == m_t) return;
    uint16_t i = ++m_i;
    if (i >= 4)
    {
        i = 0;
        m_i = 0;
        m_t = t;
    }
    else if (i <= 2)
        m_t = t;
    uint8_t bx = (uint8_t)i;
    if (m_caught[bx]) return;
    if (mouse_cat(bx))
    {
        mouse_catch(bx);
        return;
    }
    if (mouse_broom(bx)) return;
    if (m_timer[bx] == 0)
    {
        mouse_hole(bx);
        m_timer[bx] = (uint8_t)((rand16() & 7) + 0x14);
    }
    --m_timer[bx];
    if (mouse_cat(bx))
    {
        mouse_catch(bx);
        return;
    }
    /* 0x4181 */
    mouse_place(bx);
    if (mouse_near(bx, t_mouse_near[g_level]) && m_timer[bx] >= 2)
    {
        if (m_timer[bx] <= 0x11) m_timer[bx] = 1;
        else if (m_timer[bx] < 0x14) m_timer[bx] = 0;
    }
    uint8_t al = m_timer[bx];
    uint8_t dy = m_hole[bx] < 3 ? 3 : 1;
    if (al <= 1)
    {
        m_y[bx] += dy;
        m_spr = al >= 1 ? 0x3D80 : 0x3DB0;
    }
    else if (al >= 0x12)
    {
        m_y[bx] += dy;
        m_spr = al < 0x13 ? 0x3D80 : al == 0x13 ? 0x3DB0 : 0;
    }
    else
        m_spr = (al & 1) ? 0x3D50 : 0x3D20;
    m_npos = POS_XY(m_x[bx], m_y[bx]);
    mouse_erase(bx);
    if (mouse_broom(bx)) return;
    if (m_spr == 0)
    {
        m_hidden[bx] = 1;
        return;
    }
    m_hidden[bx] = 0;
    m_pos[bx] = m_npos;
    gfx_blit(m_npos, SZ(12, 4), d_mouse4 + (m_spr - 0x3D20), m_save[bx], BM_AND, 0);
}

/* 0x4090 */
static void mice_init(void)
{
    for (int8_t bx = 3; bx >= 0; --bx)
    {
        m_hidden[bx] = 1;
        m_caught[bx] = 0;
        mouse_hole((uint8_t)bx);
        m_timer[bx] = (uint8_t)((rand16() & 0x0F) + 0x14);
    }
    m_i = 0;
    m_left = 4;
}

static void cheese_list(uint16_t lst)
{
    draw_list((const uint16_t *)(d_cheese + (lst - CHEESE_GFX)), 0, d_cheese, CHEESE_GFX);
}

/* 0x3F9E: клин сыра из случайных плиток, дырки, связи дырок по уровню */
static void cheese_draw(void)
{
    cheese_jump = 0;
    cheese_hole = 0;
    uint16_t row = POS(0x506);
    for (uint8_t r = 0; r < 0x11; ++r, row += 8 << 8)
    {
        for (uint8_t i = 0, n = t_cheese_row[r]; i < n; ++i)
        {
            uint16_t si = 0x3AEA;
            uint8_t dl = (uint8_t)rand16();
            if (dl <= 0x30) si = (dl & 4) ? 0x3AF8 : 0x3B02;
            blit((uint16_t)(row + (i << 1)), SZ(8, 2), d_cheese + (si - CHEESE_GFX), BM_COPY);
        }
    }
    cheese_list(0x3C22);
    cheese_list(0x3C3E);
    cheese_list(0x3C9A);
    cheese_list(0x3C56);
    blit(POS(0x8EC), SZ(1, 4), d_crumb, BM_AND);
    const uint8_t *p = t_hole_link + ((g_level & 3) << 3);
    for (uint8_t i = 0; i < 16; i += 2, ++p)
    {
        hole_link[i] = *p >> 4;
        hole_link[i + 1] = *p & 0x0F;
    }
}

static void draw(void)
{
    room_frame(0x640);
    room_list(0x2570, 0xCBA);
    room_win_x = 0x108;
    room_win_y = 0x60;
    room_chairs(0x1439);
    room_stand(0x16C0);
    cheese_draw();
}

static uint8_t busy(void)
{
    return cheese_jump;
}

static void run(void)
{
    g_state = 4;
    transition();
    draw();
    cat_init_room();
    broom_init();
    dog_reset();
    mice_init();
    snd_rhythm_reset();
    for (;;)
    {
        g_passes = loop_passes();
        hotkeys();
        input_update();
        snd_rhythm();
        cat_update();
        jump_update();
        mice_update();
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
    hooks.busy = busy;
    hooks.swim = 0;
    hooks.floor_step = room_floor_step;
    room_extra_land = 0;
}
