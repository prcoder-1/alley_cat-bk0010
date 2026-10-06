/*
 * Звук: перевод процедур CAT.EXE 0x5450..0x5BBF.
 *
 * На PC тон даёт канал 2 таймера PIT (делитель от 1193182 Гц), процессор при
 * этом свободен. У БК генератора нет — бит динамика переключает процессор:
 *  - «блокирующие» звуки оригинала (щелчки ритма 0x5B28, шумы, трели)
 *    играются здесь же с той же длительностью;
 *  - непрерывный тон (бипы, визг драки, мелодии) звучит в простое главного
 *    цикла: snd_idle() тратит свободное время на текущий тон.
 * Длительности в отсчётах PIT переводятся в отсчёты таймера БК
 * (23437,5 Гц): n * 23437,5 / 1193182 = n / 50,9.
 */
#include "snd.h"
#include "game.h"
#include "hw.h"
#include "gfx.h"
#include "cat.h"
#include "dog.h"
#include "data_kernel.h"

uint16_t snd_rhythm_freq = 0x500;  /* [592A] */
static uint16_t rh_len;            /* [592E] длительность щелчка, отсчёты PIT */
static uint8_t rh_bit = 0x80;      /* [5927] */
static uint8_t rh_step;            /* [5928] */
static uint8_t rh_acc;             /* [5929] */
static uint8_t rh_dir = 0xFF;      /* [592C] */
static uint8_t rh_extra;           /* [592D] */
static uint8_t beep_n;             /* [5920] */
static uint16_t beep_t;            /* [5921] */
static uint16_t beep_div2;         /* [5923] */
static uint16_t rh_t;              /* [5925] */
uint8_t snd_dog_step;              /* [59BA] (индекс x2) */
static uint16_t arp_i;             /* [5A54] */
uint8_t snd_hold;                  /* [5B07] */
static uint16_t surf_add;          /* [5B08] */
static uint16_t f_mask;            /* [5B0A] */
static uint16_t f_cnt;             /* [5B0C] */
static uint8_t f_div;              /* [5B0E] */
static uint8_t f_phase;            /* [5B0F] */
static uint16_t f_t;               /* [5B10] */
static uint16_t f_glide;           /* [5B12] */

/* ------------------------------------------------------- тон-генератор */

uint16_t tone_div;                 /* текущий тон (делитель PIT), 0 — тишина */
static uint8_t spk_level;

void tone_sq(uint16_t hp, uint16_t counts);   /* gfx.s (страница СМК) */
uint16_t umulhi(uint16_t a, uint16_t b);

/*
 * Полупериод в витках sob цикла tone_sq: div / 1193182 / 2 с при 3 МГц —
 * div * 1,2571 тактов, минус накладные расходы витка. Константы сняты по
 * частоте фронтов в эмуляторе (bk_audio).
 */
#define TONE_MUL 5511     /* 65536 * 1,2571 / 14,95 такта на виток sob */
#define TONE_OFS 9     /* 131 такт накладных расходов полупериода */
static uint16_t hp_div, hp_val;

static uint16_t half_period(uint16_t div)
{
    if (div != hp_div)
    {
        hp_div = div;
        uint16_t h = umulhi(div, TONE_MUL);
        hp_val = h > TONE_OFS ? h - TONE_OFS : 1;
    }
    return hp_val;
}

/* играть тон div в течение counts отсчётов таймера БК (0 — молчать) */
static void tone_run(uint16_t div, uint16_t counts)
{
    gfx_flush();
    tone_sq(div ? half_period(div) : 0, counts);
    tmr_elapsed();
}

/* аналог out 42h/43h + включение динамика (0x5889) */
static void tone(uint16_t div)
{
    tone_div = div;
}

/* PIT-отсчёты -> отсчёты таймера БК */
static uint16_t pit2bk(uint16_t n)
{
    return (uint16_t)((n >> 6) + (n >> 8) + (n >> 9));   /* n / 50,9 */
}

/* циклы `loop` 8088 (17 тактов) -> отсчёты БК: n * 17 / 4772727 * 23437,5 = n / 12 */
static uint16_t loops2bk(uint16_t n)
{
    return (uint16_t)(n / 12);
}

/* выждать counts отсчётов таймера, играя текущий тон */
void snd_wait(uint16_t counts)
{
    tone_run(g_sound ? tone_div : 0, counts);
}

/*
 * Простой цикла со звучащим тоном. На PC тон звучит сам, у БК — только пока
 * процессор в tone_sq, поэтому кусок вчетверо длиннее запрошенного: доля
 * тона в проходе растёт, звук не рвётся. Логика от этого не страдает —
 * число проходов PC и обратный ход считаются по таймеру.
 */
void snd_idle(uint16_t counts)
{
    if (tone_div) tone_run(tone_div, (uint16_t)(counts << 2));
}

/* звучать текущим тоном до конца тика: нота мелодии звучит сплошняком */
void snd_idle_tick(void)
{
    if (tone_div) tone_run(tone_div, to_tick());
}

/* 0x5B21 */
void snd_off(void)
{
    tone_div = 0;
    spk_level = 0;
    spk_set(0);
}

/* 0x5B28: щелчок ритма — тон snd_rhythm_freq на rh_len отсчётов PIT */
static void click(void)
{
    tone_run(snd_rhythm_freq, pit2bk(rh_len));
    snd_off();
}

/* ------------------------------------------------------------ эффекты */

/* 0x5450 */
void snd_fight_init(void)
{
    f_phase = 0x0C;
    f_cnt = 1;
    f_glide = 0x1FF;
    f_mask = 0x0F;
    f_div = 1;
}

/* 0x58BD */
void snd_rhythm_reset(void)
{
    rh_bit = 0x80;
    rh_step = 0;
    rh_acc = 0;
    snd_rhythm_freq = 0x500;
    rh_dir = 0xFF;
    rh_extra = 0;
    beep_n = 0;
    snd_hold = 0;
    surf_add = 0;
    f_cnt = 1;
    f_div = 1;
}

/* 0x593B: тон div на тик, затем div2 на тик */
void snd_beep(uint16_t div, uint16_t div2)
{
    if (!g_sound) return;
    beep_div2 = div2;
    tone(div);
    beep_n = 2;
    beep_t = ticks();
}

/* 0x595D: чириканье птицы */
void snd_bird(void)
{
    if (!g_sound || beep_n) return;
    uint16_t ax = (uint16_t)((rand16() & 0x7F) + 0xAA);
    snd_beep(ax + 0x1E, ax);
}

/* 0x597F: всплытие за воздухом */
void snd_surface(void)
{
    if (!g_sound) return;
    uint16_t ax = 0x1200 + surf_add, bx = 0x1312 + surf_add;
    surf_add += 0x15E;
    snd_beep(ax, bx);
    snd_hold = 0x18;
}

/* 0x59A3: тон div на cx циклов `loop` */
static void burst(uint16_t div, uint16_t cx)
{
    if (!g_sound) return;
    tone_run(div, loops2bk(cx));
    snd_off();
}

/* 0x58F8 */
void snd_jump_off(void)
{
    if (!dog_active) burst(0x390, 0x1800);
    cat_window = 0;
}

/* 0x590E */
void snd_can_land(void)
{
    if (!dog_active) burst(0x400, 0x1800);
}

/* 0x591F */
void snd_mouse_bump(void)
{
    burst(0x7D0, 0x1800);
    burst(0xA6E, 0x1800);
    burst(0xDEC, 0x1800);
}

/* Ожидание N вызовов int 1Ah на PC 4,77 МГц (~300 тактов = 1,5 отсчёта БК) */
static void delay_int1a(uint16_t n)
{
    tone_run(0, (uint16_t)(n + (n >> 1)));
}

/* 0x59CB: упал за забор — треск с растущими паузами, 2..7 тиков */
void snd_behind_fence(void)
{
    spk_set(0);
    uint16_t t0 = ticks();
    uint16_t cnt = 0;   /* [5A42] */
    while ((uint16_t)(ticks() - t0) < 2) tone_run(0, 1);
    for (;;)
    {
        uint16_t cx = cnt >> 6;
        if (!cx) cx = 1;
        delay_int1a(cx);
        if ((uint16_t)(ticks() - t0) >= 7) break;
        if (rand16() & 2 & g_sound)
        {
            spk_level ^= 1;
            spk_set(spk_level);
        }
        cnt += 7;
    }
    snd_off();
}

/* 0x5A1C: «шлепок» — плывущий тон, шаг каждые 0x260 отсчётов PIT */
static uint16_t sp_idx;            /* [5A18] */
static uint16_t sp_a, sp_b;        /* [5A3C], [5A3E] */
void snd_splat_init(void)
{
    sp_a = sp_b = 0;
}

void snd_splat(void)
{
    if (!g_sound)
    {
        tone_run(0, pit2bk(0x260));
        return;
    }
    tone_run(tone_div, pit2bk(0x260));
    ++sp_idx;
    uint16_t ax = sp_a & 0x3FF;
    if (ax >= 0x180) ax = (uint16_t)(0x180 - ax);
    ax = (uint16_t)((ax >> 2) + t_splat_div[(sp_idx & 0x1E) >> 1]);
    sp_b += 1;
    sp_a += 4;
    ax += sp_b >> 3;
    tone(ax);
}

/* 0x5A90: визг драки — новая частота на каждом тике */
static uint16_t sq_t;              /* [5A14] */
void snd_squeal(void)
{
    if (!g_sound) return;
    uint16_t t = ticks();
    if (t == sq_t) return;
    sq_t = t;
    tone((uint16_t)(0x200 + (rand16() & 0x70)));
}

/* 0x5AC2: приземление — 2 тика шума со спадающей высотой */
void snd_land(void)
{
    uint16_t base = 0x338;     /* [5A12] */
    uint16_t t0 = ticks();
    while ((uint16_t)(ticks() - t0) < 2)
    {
        if (g_sound)
        {
            tone_run((uint16_t)((rand16() & 0x7FF) + base), 1);
            base -= 2;
        }
        else
            tone_run(0, 1);
    }
    snd_off();
}

/* Бит-банг динамиком: шаблон pat[0..mask], индекс = номер итерации >> sh.
 * Итерация цикла PC ~105 мкс = 2,5 отсчёта таймера БК. */
static void bitbang_ticks(const uint8_t *pat, uint8_t mask, uint8_t sh, uint16_t nticks)
{
    uint16_t t0 = ticks(), it = 0;
    while ((uint16_t)(ticks() - t0) < nticks)
    {
        tone_run(0, 2 + (it & 1));
        ++it;
        if (g_sound && (pat[(it >> sh) & mask] & 2))
        {
            spk_level ^= 1;
            spk_set(spk_level);
        }
    }
}

/* 0x5691: проснулась собака в псарне (на PC ещё и вспышка фона) */
void snd_wake(void)
{
    snd_off();
    bitbang_ticks(t_bb_wake, 0x1F, 2, 2);
    snd_hold = 0x0C;
    snd_off();
}

/* 0x56F4/0x5704: паук поймал кота — шаг шума при каждом вызове */
static uint16_t spi_n;             /* [5AD0] */
void snd_spider_init(void)
{
    spi_n = 0x200;
}

void snd_spider(void)
{
    ++spi_n;
    uint16_t bx = spi_n;
    uint8_t cl = (uint8_t)((bx >> 9) & 0x0F);
    bx = (uint16_t)((bx >> cl) & 0x0F);
    tone_run(0, 2);
    uint8_t lv = (t_bb_spider[bx] & g_sound) ? 1 : 0;
    spk_set(lv);
}

/* 0x576E: пауза 0x1000 циклов, затем тон */
static uint16_t jg_div;            /* [5ACB] */
static void jingle_step(void)
{
    tone_run(tone_div, loops2bk(0x1000));
    if (g_sound) tone(jg_div);
}

/* 0x572E: трель (кот у Фелиции) */
void snd_jingle(void)
{
    for (jg_div = 0x1F4; ; )
    {
        jingle_step();
        jg_div -= 0x1E;
        if (jg_div <= 0xC8) break;
    }
    for (jg_div = 0x1F4; ; )
    {
        jingle_step();
        jg_div -= 0x14;
        if (jg_div <= 0x12C) break;
    }
    for (;;)
    {
        jingle_step();
        jg_div += 0x1E;
        if (jg_div >= 0x320) break;
    }
    snd_off();
}

/* 0x5797/0x57A6: удар угря — ШИМ динамиком */
static uint8_t zp_n;               /* [5ACF] */
static uint16_t zp_w;              /* [5ACD] */
void snd_zap_init(void)
{
    snd_off();
    zp_n = 0;
    zp_w = 8;
}

void snd_zap(void)
{
    ++zp_n;
    uint8_t al = zp_n & 0x3F;
    if (al == 0) ++zp_w;
    uint8_t bl = (uint8_t)((zp_w >> 2) & 0x1F);
    tone_run(0, 1);
    spk_set((al >= bl && g_sound) ? 1 : 0);
}

/* 0x57D5/0x57E4: мелодия провала/возврата, нота на 2 тика */
static uint16_t ft_t, ft_i;        /* [5A83], [5A85] */
void snd_tune2_init(void)
{
    ft_i = 0;
    ft_t = ticks();
}

void snd_tune2(void)
{
    if (!g_sound) return;
    uint16_t t = ticks();
    if ((uint16_t)(t - ft_t) < 2) return;
    ft_t = t;
    uint16_t i = ft_i >> 1;
    ft_i += 2;
    uint16_t ax;
    if (cat_failed)
    {
        ax = t_tune_fail[i];
        if (ax == 0)
        {
            snd_off();
            return;
        }
    }
    else
        ax = t_tune_back[i];
    tone(ax);
}

/* 0x5829/0x5835/0x5869: звук подсчёта бонуса */
static uint16_t bn_i;              /* [5A62] */
static uint16_t bn_t;              /* [5A80] */
static uint8_t bn_n;               /* [5A82] */
void snd_bonus_init(void)
{
    bn_i = 0;
    bn_n = 0;
}

void snd_bonus_tick(void)
{
    if (!g_sound) return;
    uint16_t t = ticks();
    if (t == bn_t) return;
    bn_t = t;
    ++bn_n;
    uint16_t bx = bn_i >> 1;
    if (!(bn_n & 1)) ++bx;
    tone(t_bonus_snd[bx]);
}

void snd_bonus_step(void)
{
    if (!g_sound) return;
    tone(t_bonus_snd[bn_i >> 1]);
    bn_i += 2;
}

/* 0x5897: звук «шторки» перехода сцены */
static uint16_t wp_i;              /* [5A56] */
void snd_wipe(void)
{
    if (!g_sound) return;
    tone(t_wipe_snd[(wp_i & 6) >> 1]);
    wp_i += 2;
}

/* 0x5B54/0x5B63/0x5BBF: мелодия (по 2 тика на ноту, повтор ноты = пауза) */
static uint16_t tn_i, tn_t, tn_prev;   /* [59BE], [59C0], [59BC] */
void snd_tune_init(void)
{
    tn_i = 0;
    tn_t = ticks();
}

void snd_tune(void)
{
    if (!g_sound) return;
    uint16_t t = ticks();
    if ((uint16_t)(t - tn_t) < 2) return;
    tn_t = t;
    uint16_t bx = tn_i & 0xFE;
    if (bx >= 0x86)
    {
        bx = 0;
        tn_i = 0;
    }
    tn_i += 2;
    uint16_t ax = t_tune[bx >> 1];
    uint16_t prev = tn_prev;
    tn_prev = ax;
    if (ax == prev)
    {
        snd_off();
        return;
    }
    tone(ax);
}

uint16_t snd_tune_pos(void)
{
    return tn_i;
}

void snd_tune_play(void)
{
    while (g_sound && tn_i < 0x7C)
    {
        snd_tune();
        snd_idle(8);
    }
}

/* ---------------------------------------------------------- движок ритма */

/* 0x546D: фоновый ритм сцены, шаги пса, звук драки, долгие бипы */
void snd_rhythm(void)
{
    if (!g_sound) return;
    uint16_t t = ticks();
    if (dog_fight)
    {
        if (f_phase == 0)
        {
            if (t == f_t) return;
            f_t = t;
            tone((uint16_t)((f_glide & 0x1FF) + 0xC8));
            f_glide -= 0x4B;
            return;
        }
        if (t != f_t)
        {
            f_t = t;
            --f_phase;
        }
        if (f_div > g_passes)
        {
            f_div -= (uint8_t)g_passes;
            return;
        }
        f_div = 2;
        if ((uint8_t)rand16() <= 4) ++f_cnt;
        if (f_cnt & 1) f_mask += 7;
        tone((uint16_t)((rand16() & f_mask & 0x1FF) + 0x190));
        return;
    }
    if (beep_n)
    {
        if (t == beep_t) return;
        beep_t = t;
        if (--beep_n == 0)
        {
            snd_off();
            return;
        }
        tone(beep_div2);
        return;
    }
    if (t == rh_t) return;
    uint8_t si = 3;
    if ((dog_active | snd_hold) == 0)
    {
        si = 1;
        if (g_state == 0)
        {
            si = 0;
            if (item_y) si = 2;
        }
    }
    if ((cat_thrown | snd_hold) == 0)
        if ((uint16_t)(t - rh_t) < t_rh_tempo[si]) return;
    rh_t = t;
    if (dog_active || snd_hold)
    {
        if (!dog_active) --snd_hold;
        /* шаг пса */
        rh_len = 0x1200;
        if (snd_dog_step >= 6) snd_dog_step = 0;
        snd_rhythm_freq = t_rh_arp[snd_dog_step >> 1];
        snd_dog_step += 2;
        click();
        return;
    }
    if (si == 2)
    {
        /* летящий предмет: высота тона по высоте предмета */
        snd_rhythm_freq = (uint16_t)(((uint16_t)item_y << 4) + 0x200);
        rh_len = 0x1800;
        click();
        return;
    }
    rh_len = t_rh_len[si];
    uint8_t carry = rh_bit & 1;
    rh_bit >>= 1;
    if (carry)
    {
        rh_len = 0x1000;
        rh_bit = 0x80;
        uint8_t al = (uint8_t)(++rh_step & t_rh_bar[si]);
        if (al == 0)
        {
            rh_acc += t_rh_acc[si];
            uint16_t r = rand16();
            if ((uint8_t)r <= t_rh_extra[si]) rh_extra = (uint8_t)r & 7;
            r = (uint16_t)((rand16() & 0xFF) << 1);
            uint8_t cl = 1;
            if (r & 2)
            {
                cl = 0xFF;
                r += 0x300;
            }
            snd_rhythm_freq = r;
            rh_dir = cl;
        }
        rh_step = (uint8_t)(al | (rh_acc & t_rh_accmask[si]));
    }
    if (rh_dir != 0xFF)
    {
        arp_i += 2;
        snd_rhythm_freq = t_rh_arp[(arp_i & 0x0E) >> 1];
    }
    else
    {
        if (snd_rhythm_freq <= 0xC8) snd_rhythm_freq = 0x500;
        snd_rhythm_freq -= 0x19;
    }
    if (cat_thrown)
    {
        rh_len = 0x2000;
        rh_dir = 0xFF;
        click();
        return;
    }
    if (t_rh_pat[rh_step + t_rh_patofs[si]] & rh_bit)
    {
        click();
        return;
    }
    if (rh_extra == 0) return;
    --rh_extra;
    rh_len = t_rh_len2[si];
    click();
}

/* прямая установка тона (out 42h/43h в процедурах сцен) */
void snd_tone(uint16_t div)
{
    tone(div);
}
