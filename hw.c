#include "hw.h"
#include "memory.h"
#include "gfx.h"

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

/* счёт времени — в helpers.s (tmr_elapsed вызывается по много раз за проход) */
extern uint16_t tmr_prev;
extern uint16_t tick_acc;   /* в четвертях отсчёта */
extern uint16_t tick_cnt;
extern uint16_t pass_acc;

/* кадры 1/60 с (обратный ход луча CGA): 390,625 отсчёта = 3125 восьмых */
#define FRAME_8 3125u
#define RETRACE_8 250u      /* обратный ход — 8% периода */
extern uint16_t rt_ph8;     /* фаза в кадре, восьмые отсчёта */
extern uint16_t rt_frame;   /* номер кадра */

static void tmr_update(void)
{
    tmr_elapsed();
}

/* отсчётов таймера до следующего тика BIOS */
uint16_t to_tick(void)
{
    tmr_elapsed();
    return (uint16_t)((TICK_Q - tick_acc) >> 2) + 1;   /* tick_acc — четверти отсчёта */
}

uint16_t ticks(void)
{
    tmr_update();
    return tick_cnt;
}

uint16_t loop_passes(void)
{
    tmr_update();
    gfx_flush();
    /* pass_acc / PASS_CNT делением сдвигами (pass_acc < 15360) */
    uint16_t n = 0, a = pass_acc, c = PASS_CNT << 9, b = 1 << 9;
    do
    {
        if (a >= c)
        {
            a -= c;
            n += b;
        }
        c >>= 1;
        OPAQUE(c);
    } while (b >>= 1);
    pass_acc = a;
    return n ? n : 1;
}

void wait_tick(void)
{
    uint16_t t = ticks();
    while (ticks() == t);
}

/* ------------------------------------------------------------------ ввод */

uint8_t key_state[(K_COUNT + 1) & ~1] __attribute__((aligned(2)));
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
static uint8_t cur_ar2;     /* код набран с АР2 */
uint16_t kbd_get(void);     /* helpers.s: код | 0200, если с АР2 */

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
    case '9': return K_9 + 1;
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
        uint16_t k = kbd_get();
        cur_code = (uint8_t)(k & 0177);
        cur_ar2 = (uint8_t)(k & 0200);
        ++key_presses;
    }
    uint8_t held = 0;
    if ((REG(REG_EXT_DEV) & 0100) == 0) held = 1;
    uint16_t *ks = (uint16_t *)key_state;   /* без memset: опрос — в каждом проходе */
    uint16_t *ke = ks + (K_COUNT + 1) / 2;
    do
    {
        *ks++ = 0x8080;
        OPAQUE(ks);
    } while (ks != ke);
    if (held)
    {
        uint8_t c = cur_code;
        /* СУ + буква: Ctrl-комбинации оригинала */
        if (c == 023 || c == 022 || c == 015)
        {
            key_state[K_CTRL] = 0;
            c = (c == 023) ? 'S' : (c == 022) ? 'R' : 'M';
        }
        /* АР2 + 9 — Ctrl-9 оригинала (9 жизней) */
        if (cur_ar2 && c == '9') key_state[K_CTRL] = 0;
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

void vram_clear(void)
{
    for (uint16_t *p = (uint16_t *)040000; p < (uint16_t *)0100000; ++p) *p = 0;
}

void hw_init(void)
{
    vram_clear();   /* стереть служебную строку монитора */
    REG(REG_TVE_LIMIT) = 0177777;
    REGB(REG_TVE_CSR) = (1 << TVE_CSR_RUN);
    tmr_prev = REG(REG_TVE_COUNT);
}

/* сейчас обратный ход луча (1/60 с, 8% периода) */
uint8_t retrace(void)
{
    tmr_elapsed();
    if (rt_ph8 < RETRACE_8) return 1;
    return 0;
}

/*
 * Для мест, которые ЖДУТ обратного хода: на PC главный цикл проходит ~85 раз
 * за тик и не пропускает ни одного обратного хода, а проход цикла БК длится
 * миллисекунды. Поэтому «обратный ход был с прошлой проверки» тоже считается.
 */
uint8_t retrace_seen(uint16_t *last)
{
    tmr_elapsed();
    uint16_t f = rt_frame;
    if (f != *last)
    {
        *last = f;
        return 1;
    }
    if (rt_ph8 < RETRACE_8) return 1;
    return 0;
}

void ticks_set(uint16_t t)
{
    tmr_elapsed();
    tick_cnt = t;
}
