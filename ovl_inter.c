/*
 * Оверлей INTER: возврат во двор, CAT.EXE 0x1BF0 при сцене 0 — шторка,
 * картинка провала (0x1D76), «HERE KITTY» (0x5BE0), бонус (0x38B0),
 * танец Фелиции (0x5313) и провал у Фелиции (0x6040).
 * Смена палитры (0x1D31) на БК-0010 невозможна — пропущена.
 */
#include "bonus.h"
#include "cat.h"
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "ovl.h"
#include "snd.h"
#include "data_inter.h"

/* маска пикселей CGA (пиксель 0 в битах 7-6) -> порядок бит БК */
static uint8_t rev_px(uint8_t m)
{
    uint8_t r = 0;
    for (uint8_t i = 0; i < 4; ++i)
    {
        r = (uint8_t)((r << 2) | (m & 3));
        m >>= 2;
    }
    return r;
}

static void wait_tick_snd(void (*snd)(void))
{
    uint16_t t = ticks();
    while (ticks() == t)
    {
        if (snd) snd();
        snd_idle(48);
    }
}

/* 0x5BE0: пёс зовёт кота */
static void kitty(void)
{
    uint16_t t = ticks();
    for (uint16_t i = 0; i < 0x10;)
    {
        blit(POS(0x0A74), SZ(0x44, 8), d_kitty + (i & 2) * 272, BM_COPY);
        i += 2;
        while ((uint16_t)(ticks() - t) < 4)
        {
            snd_tune2();
            snd_idle(48);
        }
        t = ticks();
        if (i == 4) blit(POS(0x0668), SZ(16, 8), d_here, BM_COPY);
        if (i >= 8 && i - 8 < 6)
            blit(pos_of(t_kitty_pos[(i - 8) >> 1]), SZ(21, 12), d_kitty_txt, BM_COPY);
    }
    snd_off();
}

/* 0x6040: провал у Фелиции — кот падает сверху */
static uint16_t ff_t, ff_t2;    /* [6F26], [6F28] */
static void felicia_fail(void)
{
    for (uint8_t i = 0; i < 72; ++i) g_scratch[i] = 0;
    uint16_t pos = 0x25;
    do
    {
        while (!retrace());
        blit(pos_of(pos), SZ(12, 6), g_scratch, BM_COPY);
        pos += 0x1E0;
        blit(pos_of(pos), SZ(12, 6), d_ffail_cat, BM_COPY);
        uint16_t t;
        while ((t = ticks()) == ff_t) snd_idle(48);
        ff_t = t;
        if (g_sound) snd_tone(pos >> 1);
    }
    while (pos < 0x1A40);
    blit(pos_of(pos), SZ(17, 12), d_ffail_end, BM_COPY);
    uint16_t t0 = ff_t;   /* [6F26] */
    for (;;)
    {
        uint16_t t;
        while ((t = ticks()) == ff_t2) snd_idle(48);
        ff_t2 = t;
        if (g_sound) snd_tone((t & 1) ? 0xB54 : 0xC00);
        if ((uint16_t)(t - t0) >= 0x12) break;
    }
    snd_off();
}

/* 0x1D76 */
static void fail_pic(void)
{
    if (g_prev_state == 7)
    {
        felicia_fail();
        return;
    }
    snd_tune2_init();
    uint16_t pic = 0x185B;
    if (cat_failed)
    {
        pic = t_fail_pic[(g_fail_pic & 6) >> 1];
        g_fail_pic += 2;
        if (g_lives) --g_lives;
        if (cat_failed == 0xDD && g_level != 0 && g_lives >= 1)
        {
            kitty();
            snd_off();
            return;
        }
    }
    const uint8_t *src = d_fail_pics + (pic - 0x185B);
    uint8_t mask = 0x80;
    for (uint8_t n = 0x1C; n; --n)
    {
        /* 0x1E17: картинка через маску */
        uint8_t m = rev_px(mask);
        for (uint8_t i = 0; i < 192; ++i) g_scratch[i] = src[i] & m;
        blit(POS(0x0ED0), SZ(12, 16), g_scratch, BM_COPY);
        wait_tick_snd(snd_tune2);
        if (n <= 0x14) mask = (uint8_t)t_fail_mask[(n & 6) >> 1];
        else mask = (uint8_t)(0x80 | (mask >> 1));
    }
    snd_off();
}

/* 0x52D0: мелодия танца, нота на тик */
static uint16_t dn_t, dn_i, dn_prev;   /* [52C4], [52C6], [52C8] */
static void dance_snd(void)
{
    if (!g_sound) return;
    uint16_t t = ticks();
    if (t == dn_t) return;
    dn_t = t;
    uint16_t ax = t_dance_tune[dn_i >> 1];
    dn_i += 2;
    if (ax == dn_prev)
    {
        snd_off();
        return;
    }
    dn_prev = ax;
    snd_tone(ax);
}

/* 0x5313 / 0x5368: танец Фелиции и котов */
static void dance(void)
{
    if (g_level < 2) return;
    uint8_t ph = 0;    /* [5016] */
    uint16_t t0 = ticks(), t1 = t0;
    dn_t = t0;
    dn_i = 0;
    dn_prev = 0;
    do
    {
        for (const uint16_t *p = t_dance_lst + ((t_dance_lvl[g_level] - 0x5018) >> 1); p[0]; p += 2)
        {
            blit(pos_of(p[0]), SZ(35, 8), d_dance + (((p[1] ^ ph) & 2) ? 280 : 0), BM_COPY);
            dance_snd();
        }
        ph ^= 2;
        uint16_t t;
        while ((uint16_t)((t = ticks()) - t0) < 5)
        {
            dance_snd();
            snd_idle(48);
        }
        t0 = t;
    }
    while ((uint16_t)(t0 - t1) < 0x28);
    snd_off();
}

static void run(void)
{
    wipe(0);
    snd_off();
    if (cat_won)
    {
        if (g_prev_state == 7) dance();
        else bonus(0);
    }
    else
        fail_pic();
    wipe(0xAA);
    snd_off();
}

void ovl_entry(void)
{
    ovl.run = run;
}
