/*
 * Бонус за комнату: CAT.EXE 0x38B0..0x3AF4. Входит в оверлеи INTER и ROOM7.
 * Мигание фона (int 10h, AH=0Bh) на БК-0010 невозможно — пропущено.
 */
#include "bonus.h"
#include "cat.h"
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "score.h"
#include "snd.h"
#include "data_bonus.h"

static uint8_t bn[7];          /* [368D] бонус, 7 цифр */
static uint16_t bn_raw;        /* [3697] */
static uint8_t bn_anim;        /* [369F] */
static uint8_t bn_row;         /* [369E] строка текста */
static uint8_t bn_save1[SAVE_SIZE(8, 11)];
uint8_t bn_save2[BN_SAVE2_SIZE];

/* 0x3A96: голова кота в рабочий буфер с маской */
static void head_mask(uint8_t m)
{
    for (uint8_t i = 0; i < 60; ++i) g_scratch[i] = d_bonus_head[i] & m;
}

/* 0x3AAC: столбцы голов снизу вверх до смещения to */
static void heads(uint16_t to)
{
    snd_bonus_init();
    uint16_t base = 0x1B80;
    for (;;)
    {
        for (uint8_t i = 1; t_bonus_list[i] != 0xFFFF; i += 2)
            blit(pos_of(base + t_bonus_list[i + 1]), t_bonus_list[0], g_scratch, BM_COPY);
        if (bn_anim)
        {
            snd_bonus_step();
            uint16_t t = ticks();
            while ((uint16_t)(ticks() - t) < 2) snd_idle(48);
        }
        if (base < 0x280) break;
        base -= 0x280;
        if (base < to) break;
    }
    snd_off();
}

/* 0x3AF4: двоичное -> 7 цифр */
static void to_digits(uint16_t v)
{
    for (uint8_t i = 0; i < 7; ++i) bn[i] = 0;
    for (int8_t k = 12; k >= 0; --k)
        if (v & (1u << k)) digits_add(bn, t_bonus_pow2 + k * 7);
}

/* 0x3A3A: четыре младшие цифры; колонка BIOS 18 -> знакоместо БК 14 */
static void print_bonus(void)
{
    char s[5];
    for (uint8_t i = 0; i < 4; ++i) s[i] = (char)('0' + bn[3 + i]);
    s[4] = 0;
    text_at(bn_row & 0xF8, 14, s, 3);
}

void bonus(uint8_t gift)
{
    uint16_t t, ax;
    if (g_prev_state != 7)
    {
        ++g_felicia_n;
        g_felicia_next = 1;
        head_mask(SWAPC(0xAA));   /* маска AND тоже в цветах БК */
        bn_anim = 0;
        heads(0);
        t = (uint16_t)(ticks() - g_alley_t);
        ax = g_prev_state == 6 ? 0x546 * 2 : 0x546;
        ax = ax >= t ? ax - t : 0;
        if (g_prev_state != 6) ax <<= 1;
    }
    else
    {
        t = (uint16_t)(ticks() - g_felicia_t);
        ax = 0x2A30 >= t ? 0x2A30 - t : 0;
        ax >>= 1;
    }
    bn_raw = ax;
    to_digits(ax);
    digits_add(bn, t_bonus_base + (t_bonus_basep[g_prev_state] - 0x36A2));
    uint16_t dur;
    if (g_prev_state == 7)
    {
        uint16_t idx = g_level << 1;
        uint16_t n = t_bonus_mult[g_level];
        if (gift)
        {
            n <<= 1;
            idx += 0x10;
        }
        while (n--) digits_add(g_score, bn);
        /* 0x39FA: фон под текстом (по позициям текста БК) */
        gfx_save(POS_XY(140, 0x38), SZ(8, 11), bn_save1);
        gfx_save(POS_XY(80, 0x50), SZ(8, 51), bn_save2);
        bn_row = 0x38;
        dur = 0x44;
        print_bonus();
        /* 0x3A6C: строка 10, колонка 10 -> знакоместо БК 8 */
        char s[21];
        for (uint8_t i = 0; i < 18; ++i) s[i] = (char)t_bonus_msg[i];
        uint16_t m = t_bonus_mstr[idx >> 1];
        s[18] = (char)m;
        s[19] = (char)(m >> 8);
        s[20] = 0;
        text_at(80, 8, s, 3);
    }
    else
    {
        digits_add(g_score, bn);
        dur = 0x1E;
        head_mask(0xFF);
        ax = 0xA8C >= bn_raw ? 0xA8C - bn_raw : (uint16_t)(0xA8C - bn_raw);
        bn_row = (uint8_t)(ax >> 4) & 0xF0;
        bn_anim = 1;
        heads((uint16_t)(bn_row * 0x28));
        print_bonus();
    }
    t = ticks();
    while ((uint16_t)(ticks() - t) < dur)
    {
        if (g_prev_state == 7) snd_tune();
        else snd_bonus_tick();
        snd_idle(48);
    }
    if (g_prev_state != 7)
    {
        snd_off();
        return;
    }
    gfx_restore(POS_XY(140, 0x38), SZ(8, 11), bn_save1);
    gfx_restore(POS_XY(80, 0x50), SZ(8, 51), bn_save2);
}
