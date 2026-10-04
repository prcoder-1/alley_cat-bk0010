/*
 * Общее для комнат 1..6: рамка комнаты и мебель (0x29A0, 0x2945..0x2988),
 * опора под котом (0x16C6), метла (0x3150..0x3405), следы лап (0x3445, 0x347F).
 * Входит в каждый оверлей комнаты.
 */
#include "room.h"
#include "cat.h"
#include "dog.h"
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "data_room.h"

uint16_t broom_x;          /* [327D] */
uint8_t broom_y;           /* [327F] */
static uint8_t broom_dx;   /* [3280] */
static uint8_t broom_dy;   /* [3281] */
static uint16_t broom_spos;/* [3282] */
static uint16_t broom_pos; /* [3284] */
uint8_t broom_hidden;      /* [3286] фон под метлой не снят */
static uint16_t broom_scan;/* [328A] */
static uint16_t broom_t;   /* [328C] */
uint8_t dirt[40];          /* [328E] грязь на полу, по столбцам 8 пикселей */
static uint16_t dirt_last; /* [32B6] */
static uint8_t broom_n;    /* [32EA] */
static uint8_t broom_mood; /* [32EB] */
static uint8_t broom_dist; /* [32EC] */
static uint8_t broom_cdx;  /* [32ED] */
static uint8_t broom_cdy;  /* [32EE] */
uint16_t broom_frame;      /* [327A] */
static uint8_t broom_save[SAVE_SIZE(30, 4)];  /* [31E8] */

/* ----------------------------------------------------------- рисование */

static void list(uint16_t lst, uint16_t base)
{
    draw_list((const uint16_t *)(d_room + (lst - ROOM_GFX)), base, d_room, ROOM_GFX);
}

/* 0x29A0: стены и пол комнаты со смещением base */
void room_frame(uint16_t base)
{
    list(0x251C, base);
    gfx_fill(pos_of(base + 0x284), SZ(1, 0x48), 0);
    gfx_fill(pos_of(base + 0x1184), SZ(1, 0x48), 0);
    /* углы стен: столбец из 0x5F строк — байт CGA 0x2A слева, 0xA8 справа (в порядке бит БК наоборот) */
    gfx_fill(pos_of(base + 0x2284), SZ(0x5F, 1), 0xA8);
    gfx_fill(pos_of(base + 0x22CB), SZ(0x5F, 1), 0x2A);
}

/* 0x2958 / 0x2970 / 0x2988 / 0x2945: мебель по спискам */
void room_chairs(uint16_t base)
{
    for (int8_t i = 3; i >= 0; --i) list(t_room_chair[i], base);
}

void room_lamp(uint16_t base)
{
    for (int8_t i = 4; i >= 0; --i) list(t_room_lamp[i], base);
}

void room_table(uint16_t base)
{
    for (int8_t i = 3; i >= 0; --i) list(t_room_table[i], base);
}

void room_stand(uint16_t base)
{
    list(0x2384, base);
    list(0x238C, base);
}

void room_list(uint16_t lst, uint16_t base)
{
    list(lst, base);
}

/* ------------------------------------------------------- опора под котом */

/* 0x16C6 */
uint8_t room_land(void)
{
    cheese_hole = 0;
    if (cat_vdir == 1 &&
        rect_hit(room_win_x - 4, (uint8_t)(room_win_y - 8), 0x0C, 0x10, cat_x, cat_y, 0x18, 0x0E))
    {
        cat_exit = 1;
        return 0;
    }
    if (room_extra_land && room_extra_land()) return 1;
    uint8_t cl = cat_y & 0xF8;
    uint8_t i = t_plat_head[g_state];
    for (;; ++i)
    {
        uint8_t ch = t_plat_y[i];
        if (ch == 0) return 0;
        uint16_t ax = t_plat_x[i];
        uint16_t w = t_plat_w[i];
        if (cl != ch) continue;
        if ((cat_x & 0xFFF8) < ax) continue;
        uint16_t dx = cat_x >= w ? cat_x - w : 0;
        if ((dx & 0xFFFC) > ax) continue;
        cat_y = ch;
        cat_ry = (uint8_t)(ch + 0x32);
        cat_onrope = t_plat_act[i];
        if (cat_onrope) cat_x &= 0xFFFC;
        if (g_state == 4 && i >= 0x27 && i - 0x27 < 0x10)
            cheese_hole = (uint8_t)(i - 0x27 + 1);
        return 1;
    }
}

/* --------------------------------------------------------------- метла */

/* 0x3405 */
void broom_init(void)
{
    for (uint8_t i = 0; i < 40; ++i) dirt[i] = 0;
    dirt_last = 0xFF;
    broom_frame = 0;
    broom_x = 0;
    broom_y = 0xA0;
    broom_hidden = 1;
    broom_dx = 0;
    broom_dy = 0;
    broom_mood = (uint8_t)rand16();
    broom_n = 0x6C;
}

/* 0x33A0 */
void broom_erase(void)
{
    if (broom_hidden) return;
    gfx_restore(broom_spos, SZ(30, 4), broom_save);
}

/* 0x3339: следующий кадр метлы (OR с фоном) */
void broom_draw(void)
{
    uint16_t si;
    for (;;)
    {
        si = t_broom_frames[broom_frame >> 1];
        if (si) break;
        broom_frame = 0;
    }
    broom_spos = broom_pos;
    broom_hidden = 0;
    gfx_blit(broom_pos, SZ(30, 4), d_broom + (si - 0x2EA0), broom_save, BM_OR, 0);
}

/* 0x33BA: метла задела кота */
static uint8_t broom_cat(void)
{
    if (dog_fight) return 0;
    uint8_t hit;
    if (g_state == 6 && kennel_drinking)
        hit = rect_hit(broom_x, broom_y, 0x10, 0x1E,
                       cat_x >= 8 ? cat_x - 8 : 0, (uint8_t)(cat_y + 3), 0x28, 0x0E);
    else
    {
        hit = rect_hit(broom_x, broom_y, 0x10, 0x1E, cat_x, cat_y, 0x18, 0x0E);
        if (hit && !(g_state == 4 && cheese_jump)) cat_swept();
    }
    return hit;
}

/* 0x347F: нарисовать следы стадии n в столбце bx */
void paw_draw(uint8_t bx, uint8_t n)
{
    blit((uint16_t)((192 << 8) | (bx << 1)), SZ(5, 2), d_paws + n * 10, BM_COPY);
}

/* 0x3445: кот идёт по полу — следы */
void room_floor_step(void)
{
    if (cat_y < 0xB4 || cat_dir == 0) return;
    uint16_t ax = (cat_x + 0x0C) >> 3;
    if (ax > 0x27 || ax == dirt_last) return;
    dirt_last = ax;
    if (dirt[ax] >= 4) return;
    paw_draw((uint8_t)ax, ++dirt[ax]);
}

/* 0x3150 */
void broom_update(void)
{
    uint16_t t = ticks();
    if ((uint16_t)(t - broom_t) < t_broom_period[g_state]) return;
    broom_t = t;
    if (broom_cat()) return;
    if (dog_broom_hit(broom_x, broom_y)) return;
    ++broom_n;
    broom_mood ^= (uint8_t)(broom_n & (uint8_t)rand16());
    uint16_t ax;
    uint8_t dl;
    if (broom_x >= cat_x)
    {
        ax = broom_x - cat_x;
        dl = 0xFF;
    }
    else
    {
        ax = (uint16_t)~(broom_x - cat_x);
        dl = 1;
    }
    broom_cdx = dl;
    uint8_t bl = (uint8_t)(broom_y + 0x14);
    if (bl >= cat_y)
    {
        bl -= cat_y;
        dl = 0xFF;
    }
    else
    {
        bl = (uint8_t)~(uint8_t)(bl - cat_y);
        dl = 1;
    }
    broom_cdy = dl;
    broom_dist = (uint8_t)((ax >> 2) + (bl >> 1));
    uint16_t bx = broom_scan;
    if (bx >= 0x27)
    {
        bx = 0x26;
        broom_scan = bx;
    }
    if (dirt[bx] == 0)
    {
        --broom_scan;
        uint16_t d = (uint16_t)(ticks() - g_alley_t) >> 3;
        uint8_t al = broom_dist >= (uint8_t)d ? (uint8_t)(broom_dist - (uint8_t)d) : 0;
        if (al >= broom_mood)
        {
            /* далеко: вниз, иногда в сторону */
            broom_dy = 1;
            uint8_t r = (uint8_t)rand16();
            if (r == 0) broom_dx = 0;
            else if (r <= 7) broom_dx = (r & 1) ? 1 : 0xFF;
        }
        else
        {
            al = broom_mood & 0x2F;
            if (al == 0)
            {
                broom_dx = (rand16() & 1) ? 1 : 0xFF;
                broom_dy = (rand16() & 1) ? 1 : 0xFF;
            }
            else if ((al & 7) == 0)
            {
                broom_dx = broom_cdx;
                broom_dy = broom_cdy;
            }
        }
    }
    else
    {
        /* к грязи: подмести */
        broom_dy = 1;
        ax = bx << 3;
        if (broom_x != ax)
            broom_dx = broom_x < ax ? 1 : 0xFF;
        else
        {
            broom_dx = 0;
            if (broom_y == 0xA5)
            {
                broom_dy = 0;
                if (broom_frame == 6 || broom_frame == 0x12)
                {
                    gfx_restore(broom_spos, SZ(30, 4), broom_save);
                    paw_draw((uint8_t)bx, --dirt[bx]);
                    broom_hidden = 1;
                }
            }
        }
    }
    /* 0x32AC: шаг */
    uint16_t px = broom_x;
    uint8_t py = broom_y;
    uint16_t cx = broom_x;
    if (broom_dx == 1)
    {
        cx += 8;
        if (cx >= 0x131) cx = 0x130;
    }
    else if (broom_dx == 0xFF)
        cx = cx >= 8 ? cx - 8 : 0;
    broom_x = cx & 0xFFF8;
    dl = broom_y;
    if (broom_dy == 1)
    {
        dl += 2;
        if (dl >= 0xA6) dl = 0xA5;
    }
    else if (broom_dy == 0xFF)
        dl = dl >= 2 ? (uint8_t)(dl - 2) : 0;
    broom_y = dl;
    broom_pos = POS_XY(broom_x, broom_y);
    if (broom_cat() || dog_broom_hit(broom_x, broom_y))
    {
        broom_dx = 0;
        broom_dy = 0;
        broom_x = px;
        broom_y = py;
        return;
    }
    broom_erase();
    broom_frame += 2;
    broom_draw();
}

/* картина на стене: 16 строк x 2 слова из области мебели (0x1FA0, 0x1FE0) */
void room_picture(uint16_t src, uint16_t pos)
{
    blit(pos, SZ(16, 4), d_room + (src - ROOM_GFX), BM_COPY);
}
