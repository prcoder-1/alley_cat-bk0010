#include "hw.h"
#include "memory.h"

#define REG(a) (*(volatile uint16_t *)(a))
#define REGB(a) (*(volatile uint8_t *)(a))

/*
 * Таймер БК (К1801ВИ1) считает вниз с частотой 3 МГц / 128 = 23437,5 Гц.
 * Тик BIOS PC = 65536 / 1193182 с = 1287,3 отсчёта; считаем в четвертях
 * отсчёта: 5149 на тик (ошибка 0,004%).
 * Проход главного цикла PC: ~85 за тик (re/calib.py) = 15 отсчётов.
 */
#define TICK_Q 5149u
#define PASS_CNT 15u

/* не даёт gcc свернуть вычитающий цикл в программное умножение/деление */
#define OPAQUE(v) asm ("" : "+r" (v))

static uint16_t tmr_prev;
static uint16_t tick_acc;   /* в четвертях отсчёта */
static uint16_t tick_cnt;
static uint16_t pass_acc;

/* обновить счёт времени; вернуть прошедшие отсчёты таймера */
uint16_t tmr_elapsed(void)
{
    uint16_t cur = REG(REG_TVE_COUNT);
    uint16_t d = (uint16_t)(tmr_prev - cur);
    tmr_prev = cur;
    if (d > 15000) d = 15000;    /* после долгой паузы (загрузка) — не копить */
    tick_acc += d << 2;
    uint16_t a = tick_acc;
    while (a >= TICK_Q)
    {
        a -= TICK_Q;
        OPAQUE(a);
        ++tick_cnt;
    }
    tick_acc = a;
    pass_acc += d;
    return d;
}

static void tmr_update(void)
{
    tmr_elapsed();
}

uint16_t ticks(void)
{
    tmr_update();
    return tick_cnt;
}

uint16_t loop_passes(void)
{
    tmr_update();
    uint16_t n = 0, a = pass_acc;
    while (a >= PASS_CNT)
    {
        a -= PASS_CNT;
        OPAQUE(a);
        ++n;
    }
    pass_acc = a;
    return n ? n : 1;
}

void wait_tick(void)
{
    uint16_t t = ticks();
    while (ticks() == t);
}

/* ------------------------------------------------------------------ ввод */

uint8_t key_state[K_COUNT];
uint16_t key_presses;

/*
 * Клавиатура БК: код последней клавиши (0177662) и признак «клавиша нажата»
 * (бит 6 0177716, активный 0). Одновременно держать можно одну клавишу,
 * поэтому диагонали оригинала (Home/PgUp/End/PgDn) вынесены на отдельные
 * клавиши. Джойстик «Электроника» (0177714) даёт любые сочетания.
 *
 * Таблица: код БК -> индекс клавиши оригинала (+1), 0 — не используется.
 */
static uint8_t cur_code;

static uint8_t key_index(uint8_t c)
{
    if (c >= 0140) c -= 040;           /* строчные -> заглавные */
    switch (c)
    {
    case 040: return K_ALT + 1;        /* ПРОБЕЛ — действие (Alt) */
    case 032: return K_UP + 1;         /* стрелки */
    case 031: return K_RIGHT + 1;
    case 033: return K_DOWN + 1;
    case 010: return K_LEFT + 1;
    case 'Q': return K_HOME + 1;       /* диагонали */
    case 'E': return K_PGUP + 1;
    case 'Z': return K_END + 1;
    case 'C': return K_PGDN + 1;
    case 'P': return K_ESC + 1;        /* пауза */
    case 'Y': return K_Y + 1;
    case 'N': return K_N + 1;
    case 'K': return K_K + 1;
    case 'H': return K_H + 1;
    case 'T': return K_T + 1;
    case 'A': return K_A + 1;
    case 'S': return K_S + 1;
    case 'R': return K_R + 1;
    case 'M': return K_M + 1;
    }
    return 0;
}

uint8_t key_code(void)
{
    uint8_t c = cur_code;
    return c >= 0140 ? (uint8_t)(c - 040) : c;
}

uint16_t joy_button(void)
{
    return REG(REG_PAR_INTERF) & ((1 << PAR_INTERF_A) | (1 << PAR_INTERF_LEFT_BUTTON) | (1 << PAR_INTERF_RIGHT_BUTTON));
}

void input_poll(void)
{
    if (REGB(REG_KEY_STATE) & 0200)
    {
        cur_code = REGB(REG_KEY_DATA);
        ++key_presses;
    }
    uint8_t held = 0;
    if ((REG(REG_EXT_DEV) & 0100) == 0) held = 1;
    for (uint8_t i = 0; i < K_COUNT; ++i) key_state[i] = 0x80;
    if (held)
    {
        uint8_t c = cur_code;
        /* СУ + буква: Ctrl-комбинации оригинала */
        if (c == 023 || c == 022 || c == 015)
        {
            key_state[K_CTRL] = 0;
            c = (c == 023) ? 'S' : (c == 022) ? 'R' : 'M';
        }
        uint8_t k = key_index(c);
        if (k) key_state[k - 1] = 0;
    }
    uint16_t port = REG(REG_PAR_INTERF);
    if (port & (1 << PAR_INTERF_UP))    key_state[K_UP] = 0;
    if (port & (1 << PAR_INTERF_RIGHT)) key_state[K_RIGHT] = 0;
    if (port & (1 << PAR_INTERF_DOWN))  key_state[K_DOWN] = 0;
    if (port & (1 << PAR_INTERF_LEFT))  key_state[K_LEFT] = 0;
    if (port & ((1 << PAR_INTERF_A) | (1 << PAR_INTERF_LEFT_BUTTON) | (1 << PAR_INTERF_RIGHT_BUTTON)))
        key_state[K_ALT] = 0;
}

/* -------------------------------------------------------------- динамик */

void spk_set(uint8_t on)
{
    REG(REG_EXT_DEV) = on ? 0100 : 0;
}

void hw_init(void)
{
    for (uint16_t *p = (uint16_t *)040000; p < (uint16_t *)0100000; ++p) *p = 0;   /* стереть служебную строку монитора */
    REG(REG_TVE_LIMIT) = 0177777;
    REGB(REG_TVE_CSR) = (1 << TVE_CSR_RUN);
    tmr_prev = REG(REG_TVE_COUNT);
}

/* 1/60 с = 390,6 отсчёта таймера; обратный ход — 8% периода */
uint8_t retrace(void)
{
    uint16_t c = REG(REG_TVE_COUNT);
    while (c >= 391 * 32)
    {
        c -= 391 * 32;
        OPAQUE(c);
    }
    while (c >= 391)
    {
        c -= 391;
        OPAQUE(c);
    }
    return c < 31 ? 1 : 0;
}

void ticks_set(uint16_t t)
{
    tmr_elapsed();
    tick_cnt = t;
}
