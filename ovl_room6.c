/*
 * Оверлей ROOM6: псарня (CAT.EXE 0x02AA..0x02FB, 0x4943..0x4BF7, 0x47D6..0x4942).
 * Выпить все миски, не разбудив собак.
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
#include "data_room6.h"

uint8_t kennel_drinking;      /* [44BD] */
uint8_t cheese_jump;
uint8_t (*room_extra_land)(void);

static uint16_t dk_npos;      /* [43DC] */
static uint16_t dk_spos;      /* [43DE] */
static uint8_t dk_hidden;     /* [43E0] */
static uint16_t dog_on[12];   /* [4441] */
static uint16_t dog_wake[12]; /* [4459] */
static uint8_t dk_walk;       /* [44BE] */
static uint16_t dk_best;      /* [44BF] */
static uint16_t dk_bowl;      /* [44C1] */
static uint8_t dk_dir;        /* [44C3] */
static uint8_t bowl_fill[12]; /* [44C4] */
static uint8_t dk_lap;        /* [44D0] */
static uint16_t dk_spr;       /* [44D1] */
static uint16_t dk_t;         /* [44D3] */
static uint8_t dk_sip;        /* [44D5] */
static uint8_t bowls_left;    /* [44D6] */
static uint16_t dogs_t;       /* [44D7] */
static uint8_t cat_hidden;    /* [44D9] */
static uint16_t dog_kill_pos; /* [44DA] */
static uint8_t woke;          /* [44FC] */
static uint8_t dk_save[SAVE_SIZE(10, 6)];   /* [43A0] */

/* 0x4BC8 */
static void bowl_draw(uint8_t bx)
{
    blit(POS_XY(t_bowl_x[bx], t_bowl_y[bx]), SZ(8, 4), d_bowls + (bowl_fill[bx] << 5), BM_COPY);
}

/* 0x4B03 / 0x4B1D */
static void drink_erase(void)
{
    if (dk_hidden) return;
    gfx_restore(dk_spos, SZ(10, 6), dk_save);
}

static void drink_draw(void)
{
    dk_hidden = 0;
    dk_spos = dk_npos;
    uint16_t si = dk_spr;
    if (dk_lap >= 0x80) si += 0x3C;
    gfx_blit(dk_npos, SZ(10, 6), d_drink + (si - 0x410C), dk_save, BM_AND, 0);
}

/* 0x49F9 */
static void drink_stop(void)
{
    if (kennel_drinking)
    {
        drink_erase();
        cat_draw();
        in_btn = 0x10;
    }
    kennel_drinking = 0;
    dk_hidden = 1;
    dk_lap = 0;
    dk_walk = 0;
}

/* 0x4943: кот подходит к миске и пьёт (кнопка) */
static void drink_update(void)
{
    if (dog_fight) return;
    if (dk_walk)
    {
        in_dx = dk_walk;
        in_dy = 0;
    }
    uint16_t t = ticks();
    if (t == dk_t) return;
    dk_t = t;
    if (cat_thrown)
    {
        if (kennel_drinking)
        {
            drink_erase();
            broom_erase();
            cat_save_bg();
            broom_draw();
            kennel_drinking = 0;
            dk_hidden = 1;
            dk_walk = 0;
        }
        return;
    }
    if (in_btn != 0)
    {
        drink_stop();
        return;
    }
    dk_bowl = 0xFFFF;
    dk_best = 0xFFFF;
    uint8_t dl = (uint8_t)(cat_y + 8);
    for (int8_t bx = 11; bx >= 0; --bx)
    {
        if (bowl_fill[bx] < 1 || dl != t_bowl_y[bx]) continue;
        uint16_t ax = cat_x - t_bowl_x[bx];
        uint8_t dh = 0xFF;
        if (cat_x < t_bowl_x[bx])
        {
            ax = (uint16_t)~ax;
            dh = 1;
        }
        if (ax > dk_best) continue;
        dk_best = ax;
        dk_spr = t_drink_spr[bx];
        dk_bowl = (uint16_t)bx;
        dk_dir = dh;
    }
    if (dk_bowl >= 12)
    {
        drink_stop();
        return;
    }
    if (dk_best >= 4)
    {
        /* идти к миске */
        if (dk_best <= 8) cat_speed = (cat_speed & 0xFF00) | 4;
        in_dx = dk_dir;
        cat_dir = dk_dir;
        dk_walk = dk_dir;
        in_dy = 0;
        cat_vdir = 0;
        drink_stop();
        return;
    }
    /* у миски: лакать */
    dk_walk = 0;
    if (!kennel_drinking)
    {
        cat_erase();
        cat_save_bg();
    }
    kennel_drinking = 1;
    uint8_t old = dk_lap;
    dk_lap += 0x30;
    dk_sip = dk_lap < old;
    uint16_t cx = cat_x & 0x0FFC;
    if (dk_spr == 0x410C)
        cx = cx >= 8 ? cx - 8 : 0;
    else
    {
        cx += 8;
        if (cx >= 0x127) cx = 0x126;
    }
    dk_npos = POS_XY(cx, (uint8_t)(cat_y + 3));
    drink_erase();
    if (dk_sip)
    {
        uint8_t bx = (uint8_t)dk_bowl;
        if (bowl_fill[bx])
        {
            if (--bowl_fill[bx] == 0)
            {
                snd_beep(0x8FD, 0x723);
                in_dx = 0;
                dk_walk = 0;
                in_btn = 0x10;
                if (--bowls_left == 0) cat_won = 1;
            }
            if (rect_hit(broom_x, broom_y, 0x10, 0x1E, cat_x >= 8 ? cat_x - 8 : 0,
                         (uint8_t)(cat_y + 3), 0x28, 0x0E))
            {
                broom_erase();
                bowl_draw(bx);
                broom_draw();
            }
            else
                bowl_draw(bx);
        }
    }
    drink_draw();
}

/* 0x4916: глаза собаки по стадии пробуждения */
static void eyes_draw(uint8_t bx)
{
    uint16_t p = (uint16_t)(t_dog_pos[bx] + 0xA7);
    uint16_t si = (uint16_t)(dog_wake[bx] << 1);
    if (t_kdog_spr[bx] != 0x429C)
    {
        p -= 6;
        si += 6;
    }
    blit(pos_of(p), SZ(1, 2), d_eyes + si, BM_COPY);
}

/* 0x48D7 / 0x48C1: кот поверх собаки — стереть и нарисовать заново */
static void cat_hide(uint8_t bx)
{
    cat_hidden = 0;
    if (!rect_hit(t_dog_x[bx] - 0x14, (uint8_t)t_dog_y[bx], 0x28, 6, cat_x, cat_y, 0x18, 0x0E)) return;
    cat_hidden = 1;
    if (kennel_drinking) drink_erase();
    else cat_erase();
}

static void cat_show(void)
{
    if (!cat_hidden) return;
    if (kennel_drinking) drink_draw();
    else cat_draw();
}

/* 0x47D6: собаки просыпаются рядом с котом */
static void dogs_update(void)
{
    uint16_t t = ticks();
    if ((uint16_t)(t - dogs_t) <= t_wake_t[g_level]) return;
    dogs_t = t;
    if (dog_fight) return;
    woke = 0;
    for (int8_t i = 11; i >= 0; --i)
    {
        uint8_t bx = (uint8_t)i;
        if (!dog_on[bx]) continue;
        uint16_t d = t_dog_x[bx] >= cat_x ? t_dog_x[bx] - cat_x : (uint16_t)~(t_dog_x[bx] - cat_x);
        if ((uint8_t)t_dog_y[bx] == cat_y && d <= t_wake_d[g_level])
        {
            if (dog_wake[bx] >= 2)
            {
                /* собака бросается на кота */
                dog_kill_pos = t_dog_pos[bx];
                if (kennel_drinking)
                {
                    drink_erase();
                    kennel_drinking = 0;
                }
                else
                    cat_erase();
                gfx_fill(pos_of(dog_kill_pos), SZ(13, 10), SWAPC(0xAA));
                broom_draw();
                cat_draw();
                dog_hit_force();
                return;
            }
            if (++dog_wake[bx] >= 2) ++woke;
        }
        else
        {
            if (dog_wake[bx] == 0) continue;
            if ((uint8_t)rand16() <= 0x38) --dog_wake[bx];
        }
        cat_hide(bx);
        eyes_draw(bx);
        cat_show();
    }
    if (woke) snd_wake();
}

/* 0x4B47 */
static void dogs_init(void)
{
    for (uint8_t i = 0; i < 12; ++i) dog_on[i] = 0;
    for (uint8_t n = t_dogs_n[g_level]; n; --n)
    {
        uint8_t bx;
        do bx = (uint8_t)(rand16() & 0x1E); while (bx >= 0x18 || dog_on[bx >> 1]);
        bx >>= 1;
        dog_wake[bx] = 0;
        dog_on[bx] = 1;
        blit(pos_of(t_dog_pos[bx]), SZ(13, 10), d_sleepdog + (t_kdog_spr[bx] - 0x429C), BM_COPY);
    }
    for (int8_t bx = 11; bx >= 0; --bx)
    {
        bowl_fill[bx] = t_bowl_fill[g_level];
        bowl_draw((uint8_t)bx);
    }
    dk_lap = 0;
    kennel_drinking = 0;
    dk_hidden = 1;
    bowls_left = 12;
    dk_walk = 0;
}

static void draw(void)
{
    room_frame(0);
    room_list(0x2570, 0x64A);
    room_win_x = 0x48;
    room_win_y = 0x38;
    room_chairs(0xDD2);
    room_lamp(0xDF6);
    room_picture(0x1FA0, POS(0x67E));
    room_list(0x2344, 0xB84);
    dogs_init();
}

static uint8_t busy(void)
{
    return kennel_drinking;
}

static void run(void)
{
    g_state = 6;
    transition();
    draw();
    cat_init_room();
    broom_init();
    dog_reset();
    snd_rhythm_reset();
    snd_poll_init();
    for (;;)
    {
        g_passes = loop_passes();
        snd_pass();
        hotkeys();
        input_update();
        snd_rhythm();
        drink_update();
        snd_poll();
        dogs_update();
        snd_poll();
        cat_update();
        snd_poll();
        if (dog_fight) dog_update();
        else broom_update();
        snd_poll();
        if (cat_exit | cat_failed | cat_won | g_restart | g_menu) return;
        snd_pass_idle();
    }
}

void ovl_entry(void)
{
    ovl.run = run;
    gfx_poll = snd_poll;
    hooks.items_hit = 0;
    hooks.land = room_land;
    hooks.can_mouse = 0;
    hooks.busy = busy;
    hooks.swim = 0;
    hooks.floor_step = room_floor_step;
    room_extra_land = 0;
}
