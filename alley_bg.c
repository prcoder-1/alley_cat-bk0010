/*
 * Двор: рисование фона (перевод процедур 0x2A00..0x2C84, 0x067D, 0x06DE).
 */
#include "game.h"
#include "gfx.h"
#include "alley.h"
#include "data_alleybg.h"
#include "data_wash.h"


static uint8_t fence_prev; /* [2AC4] (на PC — общий счётчик циклов фона) */

/* запомнить столбец вещи (формат БК) — начальная история прокрутки на БК */
static void hist_col(uint8_t *dst, uint8_t c)
{
    for (uint8_t y = 0; y < 16; ++y) dst[y] = wash_buf[(y << 2) + c];
}

/* 0x2AC6: верёвка из 20 вещей, ряд строк row, порог hi, карта bits */
static void rope_draw(uint8_t r, uint8_t row, uint8_t hi, uint8_t *bits)
{
    for (uint8_t n = 0; n < 20; ++n)
    {
        wash_make(t_wash_lvl[g_level], hi);
        if (n == 0 && r != 1)
            for (uint8_t c = 0; c < 3; ++c) hist_col(rope_hist[r][c], c);
        if (n == 19 && r == 1)
            for (uint8_t c = 0; c < 3; ++c) hist_col(rope_hist[r][c], (uint8_t)(3 - c));
        blit((uint16_t)((row << 8) | (n << 2)), SZ(16, 4), wash_buf, BM_COPY);
        uint8_t sh = (uint8_t)((~n & 3) << 1);
        bits[n >> 2] |= (uint8_t)(wash_mask << sh);
    }
}

/* 0x2A80 */
static void ropes_init(void)
{
    for (uint8_t i = 1; i <= 15; ++i) rope_bits[i] = 0;
    rope_draw(0, 8, 0x80, rope_bits + 1);
    rope_draw(1, 40, 0x30, rope_bits + 6);
    rope_draw(2, 72, 0, rope_bits + 11);
    rope_m[0] = rope_m[1] = rope_m[2] = 0;
    rope_phase = 0x10;
    rope_cur = 0;
    rope_delay = 1;
}

/* 0x2B9E: забор */
void fence_draw(void)
{
    fence_prev = 0;     /* 0x2ACA */
    for (uint8_t c = 0; c < 80; c += 2)
    {
        uint8_t r;
        do r = (uint8_t)(rand16() & 0x30); while (r == fence_prev);
        fence_prev = r;
        blit((uint16_t)((104 << 8) | c), SZ(8, 2), d_fence_top + r, BM_COPY);
    }
    /* тело забора: слово 0x5655 (байты 0x55, 0x56) в строках 112..175 */
    gfx_fill2(POS(0x1180), SZ(64, 80), SWAPC(0x55), SWAPC(0x95));
    /* кляксы: 4 вида по 9 штук */
    for (uint8_t k = 0; k < 4; ++k)
        for (uint8_t i = 0; i < 9; ++i)
            blit(pos_of((uint16_t)((rand16() & 0x776) + 0x12C0)), SZ(5, 2), d_graffiti + k * 10, BM_COPY);
    /* мусор на земле */
    for (uint8_t i = 0; i < 5; ++i)
        blit(pos_of((uint16_t)((rand16() & 0x3E) + 0x3A98)), SZ(5, 2), d_graffiti + 40, BM_COPY);
}

/* 0x2C3D: бак */
static void can_draw(uint16_t off)
{
    uint8_t n = off >= 0x1720 ? 2 : 3;
    uint16_t p = pos_of(off);
    blit(p, SZ(12, 10), d_can_lid, BM_COPY);
    p = POS_ADD(p, 12, 0);
    while (n--)
    {
        blit(p, SZ(8, 8), d_can_body, BM_COPY);
        p = POS_ADD(p, 8, 0);
    }
    blit(p, SZ(11, 8), d_can_base, BM_COPY);
}

/* 0x2C84 */
void cans_draw(void)
{
    for (const uint16_t *t = t_cans_pos + (t_cans_idx[g_level] >> 1); *t; ++t)
        can_draw(*t);
}

/* 0x2B8B / 0x2B71: окна */
void windows_draw(void)
{
    static const uint16_t rows[3] = { POS(0x3C5), POS(0x8C5), POS(0xDC5) };
    for (uint8_t r = 0; r < 3; ++r)
        for (uint8_t i = 0; i < 4; ++i)
            blit(POS_ADD(rows[r], 0, i * 20), SZ(16, 10), d_window, BM_COPY);
}

/* 0x2A68: значок уровня сложности */
void skill_draw(void)
{
    static const uint16_t icon[4] = { 0x2890, 0x27E0, 0x2820, 0x2810 };
    blit(POS(0x1902), SZ(8, 2), d_tiles + (icon[g_skill & 3] - 0x2720), BM_COPY);
}

/* 0x5400: мусор на земле по уровню */
void debris_draw(void)
{
    uint8_t lv = (uint8_t)(g_level & 7);
    const uint16_t *p = t_debris_list + ((t_debris_lv[lv] - 0x5864) >> 1);
    for (; *p != 0xFFFF; ++p)
    {
        uint16_t k = t_debris_kind[(lv << 3) + ((rand16() & 0x0E) >> 1)] >> 1;
        blit(pos_of(*p), SZW(t_debris_sz[k]), d_debris + (t_debris_spr[k] - 0x56E0), BM_COPY);
    }
}

/* общая часть 0x2A00 и 0x2A30 */
static void alley_bg_common(void)
{
    gfx_fill_rows(0, 200, SWAPC(0xAA));
    fence_draw();
    draw_list(t_list_alley, 0, d_tiles, 0x2720);
    skill_draw();
}

/* 0x2A00: фон двора для игры */
void alley_draw(void)
{
    alley_bg_common();
    cans_draw();
    windows_draw();
    ropes_init();
}

/* 0x2A30: фон заставки — баки как на уровне 1, без окон и верёвок */
void alley_draw_title(void)
{
    alley_bg_common();
    uint16_t lv = g_level;
    g_level = 1;
    cans_draw();
    g_level = lv;
}
