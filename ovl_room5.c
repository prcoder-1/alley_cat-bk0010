/*
 * Оверлей ROOM5: птичник (CAT.EXE 0x02FE..0x0346, 0x4340..0x47A5).
 * Столкнуть клетку со стола и поймать вылетевшую птицу.
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
#include "data_room5.h"

uint8_t kennel_drinking, cheese_jump;
uint8_t (*room_extra_land)(void);

static uint16_t cage_spos;    /* [40A6] */
static uint16_t cage_x;       /* [40A8] */
static uint8_t cage_y;        /* [40AA] */
static uint16_t cage_pos;     /* [40AB] */
static uint16_t cage_t;       /* [40AD] */
static uint8_t cage_push;     /* [40AF] */
static uint8_t cage_pdir;     /* [40B0] */
static uint8_t cage_fall;     /* [40B1] */
static uint16_t bird_x;       /* [40B2] */
static uint8_t bird_y;        /* [40B4] */
static uint16_t bird_t;       /* [40B5] */
static uint8_t bird_dx;       /* [40B7] */
static uint8_t bird_dy;       /* [40B8] */
static uint8_t bird_hidden;   /* [40B9] */
static uint16_t bird_spos;    /* [40BA] */
static uint16_t bird_pos;     /* [40BC] */
static uint16_t bird_frame;   /* [40BE] */
static uint16_t bird_goal;    /* [40C8] */
static uint8_t bird_fdx;      /* [40CA] */
static uint8_t bird_fdy;      /* [40CB] */
static uint16_t bird_dist;    /* [40CC] */
static uint8_t bird_n;        /* [40FF] */
static uint8_t cage_save[SAVE_SIZE(17, 8)];   /* [401E] */
static uint8_t bird_save[SAVE_SIZE(5, 2)];    /* [3F2C] */

/* 0x4759 / 0x4773 */
static void cage_draw(void)
{
    cage_spos = cage_pos;
    gfx_blit(cage_pos, SZ(16, 6), d_cage, cage_save, BM_AND, 0);
}

static void cage_erase(void)
{
    gfx_restore(cage_spos, SZ(16, 6), cage_save);
}

/* 0x473E */
static uint8_t cage_cat(void)
{
    return rect_hit(cage_x, cage_y, 0x18, 0x10, cat_x, cat_y, 0x18, 0x0E);
}

/* 0x4786: метла у стола */
static uint8_t broom_table(void)
{
    if (broom_y < 0x66) return 0;
    uint16_t ax = cage_x - 0x14;
    if (ax > broom_x) return 0;
    return (uint16_t)(ax + 0x30) >= broom_x;
}

/* 0x44E7: кот стоит на столе */
static uint8_t cat_on_table(void)
{
    return cat_vdir == 0 && (cat_y & 0xF8) == 0x88;
}

/* 0x44FB */
static void bird_vs_cat(void)
{
    uint16_t ax = bird_x - cat_x;
    uint8_t dl = 1;
    if (bird_x < cat_x)
    {
        ax = (uint16_t)~ax;
        dl = 0xFF;
    }
    bird_fdx = dl;
    bird_dist = ax;
    uint8_t al = (uint8_t)(bird_y - cat_y);
    dl = 1;
    if (bird_y < cat_y)
    {
        al = (uint8_t)~al;
        dl = 0xFF;
    }
    bird_fdy = dl;
    bird_dist += (uint16_t)al << 1;
}

/* 0x452D / 0x4557 */
static void bird_catch(void)
{
    if (rect_hit(bird_x, bird_y, 8, 5, cat_x, cat_y, 0x18, 0x0E) && !cat_failed) cat_won = 1;
}

static uint8_t bird_broom(void)
{
    if (!rect_hit(bird_x, bird_y, 8, 5, broom_x, broom_y, 0x10, 0x1E)) return 0;
    bird_dy = 0xFF;
    return 1;
}

/* 0x45AB: кот толкает клетку; у края стола она падает */
static void cage_update(void)
{
    uint16_t t = ticks();
    if (t == cage_t) return;
    cage_t = t;
    if (cage_y >= 0xA4) return;
    if (broom_table())
    {
        if (cat_on_table())
        {
            cat_vdir = 1;
            cat_stun = 0x10;
        }
        return;
    }
    if (cage_cat())
    {
        if (!cage_push)
        {
            uint8_t al = cat_dir;
            if (al == 0) al = cage_x > cat_x ? 1 : 0xFF;
            cage_pdir = al;
        }
        cage_push = 1;
        for (uint8_t n = 0x20; n; --n)
        {
            if (cage_pdir == 1)
            {
                cat_x -= 8;
                cat_dir = 0xFF;
            }
            else
            {
                cat_x += 8;
                cat_dir = 1;
            }
            if (cat_vdir == 1) cat_y -= 3;
            else if (cat_vdir == 0xFF) cat_y += 3;
            cat_ry = (uint8_t)(cat_y + 0x32);
            if (!cage_cat()) break;
        }
        cat_erase();
        cat_redraw();
        return;
    }
    if (!cage_fall)
    {
        if (!cage_push) return;
        cage_x += cage_pdir == 1 ? 8 : -8;
        if (cage_cat()) return;
        snd_beep(0xC00, 0xB54);
        cage_push = 0;
        cage_pos = POS_XY(cage_x, cage_y);
        cage_erase();
        cage_draw();
        if (cage_x >= 0x78 && cage_x <= 0xA8) return;
    }
    cage_fall = 1;
    if (dog_active)
    {
        if (cat_on_table())
        {
            cat_vdir = 1;
            cat_stun = 0x10;
        }
        return;
    }
    /* падение: игра ждёт, клетка летит по 5 строк за тик */
    for (;;)
    {
        while (ticks() == cage_t) snd_idle(8);
        cage_t = ticks();
        if (g_sound) snd_tone((uint16_t)cage_y << 2);
        if (cage_y >= 0xA4) break;
        cage_y += 5;
        cage_pos = POS_XY(cage_x, cage_y);
        cage_erase();
        cage_draw();
    }
    snd_off();
    cage_erase();
    --cage_spos;
    gfx_blit(cage_spos, SZ(17, 8), d_cage_br, cage_save, BM_AND, 0);
    bird_x = cage_x;
    bird_y = cage_y;
    bird_vs_cat();
    bird_dx = bird_fdx;
}

/* 0x4340 */
static void bird_update(void)
{
    uint16_t t = ticks();
    if (t == bird_t) return;
    if (++bird_n & 3) bird_t = t;
    if (cage_y < 0xA4) return;
    bird_catch();
    if (bird_broom()) return;
    uint8_t dl = (uint8_t)rand16();
    if (dl <= 0x30)
    {
        bird_vs_cat();
        if (bird_dist <= t_bird_near[g_level])
        {
            snd_bird();
            bird_goal = 0xFF;
            bird_dx = bird_fdx;
            bird_dy = bird_fdy;
            goto move;
        }
    }
    if (bird_goal <= 0x0A)
    {
        if ((uint8_t)rand16() > 6)
        {
            uint16_t bx = bird_goal;
            uint8_t d = 0;
            uint16_t ax = bird_x & 0x0FFC;
            if (ax != t_bird_tx[bx]) d = ax < t_bird_tx[bx] ? 1 : 0xFF;
            bird_dx = d;
            d = 0;
            uint8_t al = bird_y & 0xFE;
            if (al != t_bird_ty[bx]) d = al < t_bird_ty[bx] ? 1 : 0xFF;
            bird_dy = d;
            if (bird_dx | bird_dy) goto move;
            if ((uint8_t)rand16() > 0x10) goto move;
            bird_goal = 0xFF;
            snd_bird();
        }
        else
            bird_goal = 0xFF;
    }
    if ((uint8_t)rand16() <= 0x30)
    {
        bird_dx = (rand16() & 1) ? 1 : 0xFF;
        bird_dy = (rand16() & 1) ? 1 : 0xFF;
    }
    bird_goal = rand16() & 0xFF;
move:
    {
        uint8_t al = bird_y;
        if (bird_dy == 1)
        {
            al += 2;
            if (al >= 0xA8)
            {
                al = 0xA7;
                bird_dy = 0xFF;
            }
        }
        else if (bird_dy != 0)
        {
            al -= 2;
            if (al < 0x30)
            {
                al = 0x30;
                bird_dy = 1;
            }
        }
        bird_y = al;
        uint16_t ax = bird_x;
        if (bird_dx == 1)
        {
            ax += 4;
            if (ax >= 0x136)
            {
                ax = 0x135;
                bird_dx = 0xFF;
            }
        }
        else if (bird_dx != 0)
        {
            if (ax >= 4) ax -= 4;
            else
            {
                ax = 0;
                bird_dx = 1;
            }
        }
        bird_x = ax;
    }
    bird_catch();
    bird_pos = POS_XY(bird_x, bird_y);
    if (!bird_hidden) gfx_restore(bird_spos, SZ(5, 2), bird_save);
    if (bird_broom()) return;
    bird_hidden = 0;
    bird_frame += 2;
    static const uint16_t frames[4] = { 0x3EF0, 0x3EFA, 0x3F04, 0x3EFA };   /* [40C0] */
    uint16_t si = frames[(bird_frame & 6) >> 1];
    if (bird_dx == 0xFF) si += 0x1E;
    bird_spos = bird_pos;
    gfx_blit(bird_pos, SZ(5, 2), d_bird + (si - 0x3EF0), bird_save, BM_KEY, 0);
}

static void draw(void)
{
    room_frame(0x640);
    room_list(0x2570, 0xCB6);
    room_win_x = 0xF8;
    room_win_y = 0x60;
    room_chairs(0x140E);
    room_lamp(0x1434);
    room_lamp(0x143E);
    room_table(0x16A0);
    room_list(0x2344, 0x1184);
    room_picture(0x1FE0, POS(0xDD6));
}

static void run(void)
{
    g_state = 5;
    transition();
    draw();
    cage_x = 0x90;
    cage_y = 0x86;
    cage_pos = POS_XY(cage_x, cage_y);
    cage_draw();
    cage_push = 0;
    cage_fall = 0;
    bird_hidden = 1;
    bird_dy = 0;
    bird_goal = 0xFF;
    cat_init_room();
    broom_init();
    dog_reset();
    snd_rhythm_reset();
    for (;;)
    {
        g_passes = loop_passes();
        hotkeys();
        input_update();
        snd_rhythm();
        cage_update();
        bird_update();
        cat_update();
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
    room_extra_land = 0;
}
