/*
 * Очки и рекорд (0x2690..0x2739), ввод (0x1200, 0x12C1, 0x1338).
 */
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "cat.h"
#include "snd.h"
#include "data_kernel.h"
#include "score.h"

uint8_t g_score[7];   /* [1F82] семь десятичных цифр */
uint8_t g_hiscore[7]; /* [1F89] */
uint8_t g_restart;    /* [041B] Ctrl-R */
uint8_t g_menu;       /* [041C] Ctrl-M */

/* 0x2690: рекорд */
void hiscore_update(void)
{
    for (uint8_t i = 0; i < 7; ++i)
    {
        if (g_score[i] == g_hiscore[i]) continue;
        if (g_score[i] > g_hiscore[i])
            for (uint8_t k = 0; k < 7; ++k) g_hiscore[k] = g_score[k];
        return;
    }
}

/* 0x26E8 */
void digits_clear(uint8_t *d)
{
    for (uint8_t i = 0; i < 7; ++i) d[i] = 0;
}

/* 0x2739: семь цифр, после третьей — промежуток */
static void digits_draw(const uint8_t *d, uint16_t pos)
{
    for (uint8_t i = 0; i < 7; ++i)
    {
        blit(pos, SZ(8, 2), d_digits + (d[i] << 4), BM_COPY);
        pos += 2;
        if (i == 2) pos += 2;
    }
    gfx_fence_fix();
}

/* 0x26F2 / 0x26FC */
void hiscore_draw(void)
{
    digits_draw(g_hiscore, POS(0x12CA));
}

void score_draw(void)
{
    digits_draw(g_score, POS(0x143C));
}

/* 0x2706: прибавить n десятков очков (ADD + AAA по шести цифрам) */
void add_score(uint8_t n)
{
    uint8_t al = n;
    for (uint8_t bx = 6; bx; --bx)
    {
        uint8_t d = g_score[bx - 1];
        uint8_t af = (uint8_t)(((d & 0x0F) + (al & 0x0F)) > 0x0F);
        uint8_t a = (uint8_t)(d + al);
        uint8_t ah = 0;
        if ((a & 0x0F) > 9 || af)
        {
            a += 6;
            ah = 1;
        }
        g_score[bx - 1] = a & 0x0F;
        al = ah;
    }
    score_draw();
}

/* 0x271E: dst += src (семь цифр, ADC + AAA) */
void digits_add(uint8_t *dst, const uint8_t *src)
{
    uint8_t cf = 0;
    for (uint8_t bx = 7; bx; --bx)
    {
        uint8_t d = dst[bx - 1], s = (uint8_t)(src[bx - 1] + cf);
        uint8_t af = (uint8_t)(((d & 0x0F) + (s & 0x0F)) > 0x0F);
        uint8_t a = (uint8_t)(d + s);
        cf = 0;
        if ((a & 0x0F) > 9 || af)
        {
            a += 6;
            cf = 1;
        }
        dst[bx - 1] = a & 0x0F;
    }
}

/* ================================================================== ввод */

static uint16_t in_t;          /* [069F] */
static uint16_t presses_seen;  /* [0691] */
uint16_t pause_presses;        /* [6E00] */

#define DOWN(k) ((key_state[k] & 0x80) == 0)

/* 0x12C1: клавиши -> виртуальный ввод */
static void keys_read(void)
{
    uint8_t v = 0;
    if (DOWN(K_DOWN) || DOWN(K_PGDN) || DOWN(K_END)) v = 1;
    if (DOWN(K_UP) || DOWN(K_PGUP) || DOWN(K_HOME)) v = 0xFF;
    in_dy = v;
    uint8_t h = 0;
    if (DOWN(K_RIGHT) || DOWN(K_PGUP) || DOWN(K_PGDN)) h = 1;
    if (DOWN(K_LEFT) || DOWN(K_END) || DOWN(K_HOME)) h = 0xFF;
    in_dx = h;
    in_btn = (uint8_t)(key_state[K_ALT] >> 3);
}

/* 0x1200: опрос не чаще раза в 2 тика */
void input_update(void)
{
    uint16_t t = ticks();
    if ((uint16_t)(t - in_t) < 2) return;
    in_t = t;
    input_poll();
    keys_read();
}

/* 0x1338: служебные клавиши */
void hotkeys(void)
{
    input_poll();
    if (key_presses == presses_seen) return;
    presses_seen = key_presses;
    if (DOWN(K_ESC))
    {
        if (key_presses != pause_presses) game_pause();
        return;
    }
    if (!DOWN(K_CTRL)) return;
    if (DOWN(K_9))
    {
        g_lives = 9;
        return;
    }
    if (DOWN(K_M))
    {
        g_menu = 0xFF;
        return;
    }
    if (DOWN(K_R))
    {
        g_restart = 0xFF;
        return;
    }
    if (DOWN(K_S))
    {
        g_sound = (uint8_t)~g_sound;
        if (!g_sound) snd_off();
    }
}
