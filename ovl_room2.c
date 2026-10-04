/*
 * Оверлей ROOM2: аквариум (CAT.EXE 0x0459..0x049B, 0x0953..0x0BAB плавание,
 * 0x34A0..0x384A рыбы, угри, поверхность).
 */
#include "cat.h"
#include "dog.h"
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "ovl.h"
#include "score.h"
#include "snd.h"
#include "data_room2.h"

static uint8_t fish_left;      /* [3410] */
static uint16_t fish_frame;    /* [3411] */
static uint16_t eel_frame;     /* [3413] */
static uint16_t fish_i;        /* [3415] */
static uint8_t fish_dir[24];   /* [3417] */
static uint8_t fish_ydir[24];  /* [342F] */
static uint16_t fish_x[24];    /* [3447] */
static uint8_t fish_y[24];     /* [3477] */
static uint8_t fish_clean[24]; /* [348F] фон восстановлен */
static uint8_t fish_gone[24];  /* [34A7] */
static uint16_t fish_pos[24];  /* [34BF] */
static uint16_t fish_npos;     /* [34EF] */
static uint16_t fish_t;        /* [3509] */
static uint16_t fish_t2;       /* [350B] */
static uint16_t wave_i;        /* [350D] */
static uint16_t wave_t;        /* [350F] */
static uint8_t eaten;          /* [351B] */
static uint8_t wave_v[40];     /* [2656] */
static uint8_t wave_prev;      /* [2653] */
static uint8_t bubble_save[SAVE_SIZE(5, 6)];   /* [000E] (не восстанавливается — как в оригинале) */

/* 0x37C1: стереть рыбу/угря водой */
static void fish_erase(uint8_t bx)
{
    if (fish_clean[bx]) return;
    blit(fish_pos[bx], bx < 12 ? SZ(6, 2) : SZ(2, 4), d_water, BM_COPY);
}

/* 0x363D: новые угри с края, дальнего от кота */
static void eels_spawn(void)
{
again:
    for (uint8_t cx = 12; cx; --cx)
    {
        uint8_t bx = (uint8_t)(cx + 0x0B);
        if (!fish_gone[bx]) continue;
        uint16_t ax = 0;
        uint8_t dl = 1;
        fish_gone[bx] = 0;
        if (cat_x <= 0xA0)
        {
            ax = 0x12E;
            dl = 0xFF;
        }
        fish_dir[bx] = dl;
        fish_x[bx] = ax;
        if (--eaten) goto again;
        return;
    }
}

/* 0x34A0: кот ест рыб; угорь бьёт током. 1 — кого-то съел */
static uint8_t fish_hit(void)
{
    eaten = 0;
    for (uint8_t bx = 0; bx < 24; ++bx)
    {
        if (fish_gone[bx]) continue;
        uint8_t eel = bx >= 12;
        if (!rect_hit(fish_x[bx], fish_y[bx], eel ? 0x10 : 8, eel ? 2 : 6, cat_x, cat_y, 0x18, 0x0E))
            continue;
        if (eel && !cat_won && !cat_drown)
        {
            cat_failed = 1;
            uint16_t cx = cat_x >= 8 ? cat_x - 8 : 0;
            if (cx >= 0x117) cx = 0x116;
            uint8_t dl = cat_y >= 0xB5 ? 0xB4 : cat_y;
            blit(POS_XY(cx, dl), SZ(18, 10), d_zap, BM_COPY);
            snd_zap_init();
            uint16_t t0 = ticks();
            while ((uint16_t)(ticks() - t0) < 0x0D) snd_zap();
            return 0;
        }
        ++eaten;
        snd_beep(0x5DC, 0x425);
        if (eaten == 1) cat_erase();
        fish_erase(bx);
        fish_gone[bx] = 1;
        if (!eel && --fish_left == 0 && !cat_drown) cat_won = 1;
    }
    if (!eaten) return 0;
    eels_spawn();
    return 1;
}

/* 0x35C9 */
static void fish_init(void)
{
    fish_frame = 0;
    fish_i = 0;
    fish_left = 12;
    for (int8_t bx = 23; bx >= 0; --bx)
    {
        fish_clean[bx] = 1;
        fish_gone[bx] = 0;
        fish_y[bx] = t_fish_y[bx];
        fish_ydir[bx] = 1;
        fish_dir[bx] = (rand16() & 1) ? 1 : 0xFF;
        fish_x[bx] = rand16() & 0xFF;
    }
    for (uint8_t n = t_eels_off[g_level]; n; --n)
    {
        uint8_t bx;
        do
        {
            do bx = (uint8_t)(rand16() & 0x0F); while (bx >= 12);
            bx += 12;
        } while (fish_gone[bx]);
        fish_gone[bx] = 1;
    }
}

/* 0x3675: одна рыба (или угорь) за вызов; рыбы и угри — через тик */
static void fish_update(void)
{
    uint16_t t = ticks();
    if (t == fish_t) return;
    fish_t2 = t;
    uint16_t bx = ++fish_i;
    if (bx >= 24)
    {
        bx = 0;
        fish_i = 0;
        fish_frame ^= 0x0C;
        eel_frame += 8;
        fish_t = fish_t2;
    }
    else if (bx == 12)
        fish_t = fish_t2;
    if (fish_gone[bx]) return;
    if ((uint8_t)rand16() <= 0x10)
    {
        fish_dir[bx] = (rand16() & 1) ? 1 : 0xFF;
        fish_ydir[bx] = (rand16() & 1) ? 1 : 0xFF;
    }
    uint16_t cx = bx < 12 ? 4 : 2;
    uint16_t ax = fish_x[bx];
    if (fish_dir[bx] != 1)
    {
        if (ax < cx)
        {
            ax = 0;
            fish_dir[bx] = 1;
        }
        else
            ax -= cx;
    }
    else
    {
        ax += cx;
        if (ax >= 0x12F)
        {
            ax = 0x12E;
            fish_dir[bx] = 0xFF;
        }
    }
    fish_x[bx] = ax;
    uint8_t al = fish_y[bx];
    if (fish_ydir[bx] != 1)
    {
        --al;
        if (al < t_fish_y[bx])
        {
            al = t_fish_y[bx];
            fish_ydir[bx] = 1;
        }
    }
    else
    {
        ++al;
        uint8_t dl = (uint8_t)(t_fish_y[bx] + 0x18);
        if (al > dl)
        {
            al = dl;
            fish_ydir[bx] = 0xFF;
        }
    }
    fish_y[bx] = al;
    fish_npos = POS_XY(fish_x[bx], al);
    fish_erase((uint8_t)bx);
    fish_pos[bx] = fish_npos;
    fish_clean[bx] = 0;
    if (bx >= 12)
    {
        uint16_t si = (uint16_t)(((bx << 3) + eel_frame) & 0x18);
        blit(fish_npos, SZ(2, 4), d_fish + 0x30 + si, BM_COPY);
    }
    else
    {
        uint16_t si = fish_frame;
        if (!(bx & 1)) si ^= 0x0C;
        if (fish_dir[bx] != 1) si += 0x18;
        blit(fish_npos, SZ(6, 2), d_fish + si, BM_COPY);
    }
}

/* 0x37E5: волны на поверхности (кроме тех, что у головы кота) */
static void waves_update(void)
{
    uint16_t t = ticks();
    if ((uint16_t)(t - wave_t) < 8) return;
    uint16_t bx = ++wave_i;
    if (bx >= 0x28)
    {
        bx = 0;
        wave_i = 0;
        wave_t = t;
    }
    uint16_t di = bx << 1;
    if (cat_y <= 7)
    {
        uint16_t ax = (uint16_t)((cat_x >> 2) + 1);
        ax = ax >= di ? ax - di : (uint16_t)~(ax - di);
        if (ax < 4) return;
    }
    wave_v[bx] += 8;
    blit((uint16_t)((4 << 8) | di), SZ(4, 2), d_waves + (wave_v[bx] & 0x18), BM_COPY);
}

/* 0x0953..0x0BAB: кот плывёт */
static void swim(void)
{
    uint8_t lv = (uint8_t)g_level;
    uint16_t ax = (uint16_t)(cat_tick - cat_air_t);
    uint8_t bx;
    if (ax >= t_air_warn[lv])
    {
        if (ax >= t_air_dead[lv]) cat_failed = 1;
        if (--cat_drown_n == 0)
        {
            snd_surface();
            cat_drown_n = 6;
            uint8_t al = cat_drown_y;
            if (cat_y >= 0xB3 && al < 0xC8)
            {
                al += 0x1E;
                cat_drown_y = al;
            }
            uint8_t dl = cat_y >= al ? (uint8_t)(cat_y - al) : 0;
            gfx_blit(POS_XY(cat_x, dl & 0xF8), SZ(5, 6), d_bubble, bubble_save, BM_AND, 0);
        }
        cat_dir = 0;
        cat_vdir = 1;
        cat_drown = 1;
        cat_vy = 0x20;
        cat_tint = 0;
        goto vmove;
    }
    /* на PC здесь меняется цвет фона (цвет 0): чёрные части, в т.ч. кот,
     * краснеют, когда кончается воздух; на БК — оттенок кота */
    cat_tint = ax < t_air_c1[lv] ? 0 : ax < t_air_c2[lv] ? 1 : ax < t_air_c3[lv] ? 2 : 3;
    cat_pdir = cat_dir;
    cat_pvdir = cat_vdir;
    {
        uint8_t al = in_dx;
        if (al == 0)
        {
            if (cat_swvx >= 0x10)
            {
                --cat_swvx;
                goto hx;
            }
        }
        else if (al == cat_dir)
        {
            if (cat_swvx < 0x30) cat_swvx += 3;
            goto hx;
        }
        cat_dir = al;
        cat_swvx = 0x20;
    }
hx:
    {
        uint16_t sp = cat_swvx >> 3;
        if (sp > t_swim_vx[lv]) sp = t_swim_vx[lv];
        cat_speed = sp;
    }
    cat_move_x();
    {
        uint8_t al = in_dy;
        if (al == 0)
        {
            al = 0xFF;
            if (cat_vy >= 0x10)
            {
                --cat_vy;
                goto vmove;
            }
        }
        else if (al == cat_vdir)
        {
            if (cat_vy < 0x40) cat_vy += 4;
            goto vmove;
        }
        cat_vdir = al;
        cat_vy = 0x20;
    }
vmove:
    {
        uint8_t dl = cat_y;
        uint8_t bl = cat_vy >> 4;
        if (bl > t_swim_vy[lv]) bl = t_swim_vy[lv];
        if (cat_vdir == 1)
        {
            dl += bl;
            if (dl >= 0xB4) dl = 0xB3;
        }
        else if (cat_vdir != 0)
        {
            if (dl < bl || (dl -= bl) <= 3)
            {
                if (cat_spr == 0x08C8) cat_air_t = cat_tick;   /* [09B8]: вынырнул */
                dl = 2;
            }
        }
        cat_y = dl;
        cat_npos = POS_XY(cat_x, dl);
    }
    if (cat_drown)
        bx = 0x10;
    else if (cat_dir != cat_pdir || cat_vdir != cat_pvdir)
        bx = 0x18;
    else
    {
        ++cat_sw_anim;
        bx = (uint8_t)cat_sw_anim;
        if ((in_dx | in_dy) == 0) bx >>= 1;
        if (cat_y >= 0xB3 && cat_vdir == 1) goto walk;
        if (cat_y <= 4 && in_dy != 0) goto vert;
        if ((uint16_t)(cat_vy >> 1) >= cat_swvx) goto vert;
walk:
        if (cat_dir == 0) goto vert;
        bx &= 6;
        if (cat_dir != 1) bx |= 8;
        goto set;
vert:
        bx = (uint8_t)((bx & 2) | 0x10);
        if (cat_vdir == 1) bx += 4;
    }
set:
    cat_spr = t_swim_spr[bx >> 1];
    cat_nsize = t_swim_sz[bx >> 1];
    cat_erase();
    cat_pos = cat_npos;
    cat_draw();
    if (fish_hit()) cat_draw();
}

/* 0x2790, ветка state 2: вода и поверхность */
static void draw(void)
{
    gfx_fill_rows(0, 4, 0xAA);
    for (uint8_t i = 0; i < 0x28; ++i)
    {
        uint8_t dl;
        do dl = (uint8_t)(rand16() & 0x18); while (dl == wave_prev);
        wave_prev = dl;
        wave_v[i] = dl;
        blit((uint16_t)((4 << 8) | (i << 1)), SZ(4, 2), d_waves + dl, BM_COPY);
    }
}

static void run(void)
{
    g_state = 2;
    transition();
    draw();
    fish_init();
    cat_init_room();
    dog_active = 0;
    dog_fight = 0;
    snd_rhythm_reset();
    for (;;)
    {
        g_passes = loop_passes();
        hotkeys();
        input_update();
        snd_rhythm();
        cat_update();
        fish_update();
        waves_update();
        if (cat_failed | cat_won | g_menu | g_restart) break;
        snd_idle(48);
    }
    cat_tint = 0;
}

void ovl_entry(void)
{
    ovl.run = run;
    hooks.items_hit = 0;
    hooks.land = 0;
    hooks.can_mouse = 0;
    hooks.busy = 0;
    hooks.swim = swim;
    hooks.floor_step = 0;
    gfx_region(4, 0x06D0, 0x09DA, d_swim);
}
