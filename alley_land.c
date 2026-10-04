/*
 * Двор: опора под котом (0x1608 для сцены 0, 0x1657, 0x17AD) и выбор бака (0x15D0).
 */
#include "alley.h"
#include "cat.h"
#include "game.h"
#include "hw.h"
#include "snd.h"
#include "data_alley.h"

uint8_t can_last;  /* [1028] бак, из которого последний раз лезла мышь */

/* 0x15D0: случайный бак уровня -> X (cx) и Y верха (0x88 высокий / 0x90 низкий) */
uint16_t can_pick(uint8_t *y)
{
    uint8_t cl = t_cans_cnt[g_level];
    uint8_t dl;
    do
    {
        do dl = (uint8_t)(rand16() & 7); while (dl > cl);
        dl += t_cans_start[g_level];
    } while (dl == can_last);
    can_last = dl;
    uint8_t c = t_cans_top[dl];
    *y = (c & 0x80) ? 0x88 : 0x90;
    return (uint16_t)((c & 0x7F) << 2);
}

/* 0x1657: встать на крышку бака */
static uint8_t land_can(void)
{
    uint8_t cl = (uint8_t)((cat_y + 2) & 0xF8);
    for (const uint8_t *p = t_cans_top + t_cans_start[g_level]; ; ++p)
    {
        uint8_t al = *p;
        if (al == 0)
        {
            cat_window = 0;
            return 0;
        }
        uint8_t ch = (al & 0x80) ? 0x88 : 0x90;
        if (cl != ch) continue;
        uint16_t ax = (uint16_t)((al & 0x7F) << 2);
        if ((cat_x & 0xFFF8) < ax) continue;
        uint16_t dx = cat_x >= 0x0F ? cat_x - 0x0F : (uint16_t)(cat_x - 0x0F);
        if ((dx & 0xFFF8) > ax) continue;
        ch -= 2;
        cat_y = ch;
        cat_ry = (uint8_t)(ch + 0x32);
        if (!cat_window)
        {
            cat_window = 1;
            snd_can_land();
        }
        return 1;
    }
}

/* 0x17AD: встать на бельё. Верёвки на Y = 8, 0x28, 0x48; карта белья по 8 пикселей */
static uint8_t land_rope(void)
{
    uint8_t dl = cat_y & 0xF8;
    uint8_t bx;
    if (dl == 0x08) bx = 0;
    else if (dl == 0x28) bx = 1;
    else if (dl == 0x48) bx = 2;
    else return 0;
    uint16_t ax = cat_x;
    if (bx == rope_cur && rope_phase <= 3)
    {
        /* верёвка сейчас едет: поправка на непоказанную часть вещи */
        if (bx != 1)
            ax += (uint16_t)((4 - rope_phase) << 2);
        else
            ax -= (uint16_t)((rope_phase + 1) << 2);
    }
    static const uint8_t base[3] = { 0, 5, 10 };   /* [1025] */
    uint16_t b = (uint16_t)(ax + 0x0A);
    uint8_t col = (uint8_t)(b >> 3);
    uint8_t mask = (uint8_t)(0x80 >> (col & 7));
    if (!(rope_bits[1 + base[bx] + (b >> 6)] & mask)) return 0;
    cat_y = dl;
    cat_ry = (uint8_t)(dl + 0x32);
    cat_x &= 0xFFF8;
    cat_onrope = 1;
    return 1;
}

/* 0x1608, сцена 0 */
uint8_t alley_land(void)
{
    uint8_t al = cat_y & 0xF8;
    if (al != 0x60)
    {
        if (land_can()) return 1;
        return land_rope();
    }
    /* верх забора */
    if (cat_fence >= 2) return 0;
    cat_y = al;
    cat_ry = (uint8_t)(al + 0x32);
    if (cat_fence != 1)
    {
        cat_fence = 1;
        cat_fence_t = ticks();
    }
    return 1;
}
