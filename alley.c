/*
 * Двор: верёвки (0x04A0..0x0658), окна и брошенные предметы (0x1830..0x1BE0),
 * мышь в баке (0x2210..0x22F7), мыши на верёвках (0x2330..0x265E), жизни (0x26B3).
 */
#include "alley.h"
#include "cat.h"
#include "dog.h"
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "snd.h"
#include "data_alley.h"
#include "data_wash.h"
#include "data_kernel.h"

/* ================================================================ верёвки */

static uint8_t rope_cat;   /* [04D6] кот едет на этой верёвке */
static uint16_t rope_t;    /* [0544] */

/* [0526] начальная фаза, [0529] шаг фазы, [052C] порог белья, [053A]/[053D] Y кота */
static const uint8_t rp_start[3] = { 3, 0, 3 };
static const uint8_t rp_step[3] = { 0xFF, 1, 0xFF };
static const uint8_t rp_hi[3] = { 0x80, 0x30, 0 };
static const uint8_t rp_ymax[3] = { 75, 107, 139 };
static const uint8_t rp_ymin[3] = { 46, 78, 110 };
static const uint8_t rp_bits[3] = { 0, 9, 10 };   /* [0541]: начальный байт карты */
static const uint8_t rp_row[3] = { 8, 40, 72 };   /* строка полосы верёвки */

/*
 * На БК полоса не может сдвинуться на 4 пикселя CGA (= 3,2 пикселя БК):
 * она сдвигается на целый байт в 4 из 5 шагов, а новый крайний байт
 * собирается из последних трёх вставленных столбцов CGA.
 * rope_m — номер шага по модулю 5, rope_hist — столбцы (16 строк, формат БК).
 */

/* 0x0658: кот на этой верёвке? Возвращает 1, если кот в полосе и НЕ стоит
 * на ней (прыгает рядом) — тогда верёвку сейчас не двигать. */
static uint8_t rope_cat_check(uint8_t bx)
{
    rope_cat = 0;
    uint8_t al = cat_ry;
    if (al < rp_ymin[bx] || al >= rp_ymax[bx]) return 0;
    if (cat_onrope >= 1)
    {
        rope_cat = 1;
        return 0;
    }
    return 1;
}

/* 0x0633: сдвиг карты белья верёвки на бит; вдвигается бит cf */
static uint8_t rope_shift(uint8_t cf)
{
    uint8_t bx = rp_bits[rope_cur];
    uint8_t *p = rope_bits + 1;
    if (bx != 9)
    {
        for (uint8_t i = 0; i < 5; ++i)
        {
            uint8_t v = p[bx + i];
            uint8_t out = v & 1;
            p[bx + i] = (uint8_t)((v >> 1) | (cf << 7));
            cf = out;
        }
    }
    else
    {
        for (uint8_t i = 0; i < 5; ++i)
        {
            uint8_t v = p[bx - i];
            uint8_t out = v >> 7;
            p[bx - i] = (uint8_t)((v << 1) | cf);
            cf = out;
        }
    }
    return cf;
}

/* Полоса на БК — rope.s: столбцы истории (h[1] = h[0], h[0] = новый; h[2] не
 * нужен: смещение влево 7 - o >= 4), не 0 — столбец высокий (строки 8..15 не небо) */
uint8_t rope_push(uint8_t *h, const uint8_t *col);
/* крайний байт полосы, n строк: e = (a | b << 8) >> sh, sh = 0, 2, 4, 6 */
void rope_edge(volatile uint8_t *e, const uint8_t *a, const uint8_t *b, uint8_t sh, uint8_t n);
#ifdef HOST
uint8_t rope_push(uint8_t *h, const uint8_t *col)
{
    uint8_t tall = 0;
    for (uint8_t y = 0; y < 16; ++y)
    {
        h[16 + y] = h[y];
        h[y] = col[y << 2];
        if (y >= 8 && h[y] != SWAPC(0xAA)) tall = 1;
    }
    return tall;
}

void rope_edge(volatile uint8_t *e, const uint8_t *a, const uint8_t *b, uint8_t sh, uint8_t n)
{
    for (; n; --n, e += 64) *e = (uint8_t)((*a++ | (*b++ << 8)) >> sh);
}
#endif

/*
 * Нижние 8 строк полосы — небо, пока в кадре нет вещи 16x16 (d_wash_full):
 * их сдвиг ничего не меняет. rope_tall — сколько шагов ещё прокручивать все
 * 16 строк после вставки высокого столбца (64 байта полосы = 80 шагов).
 */
static uint8_t rope_tall[3] = { 84, 84, 84 };

void rope_tall_reset(void)
{
    rope_tall[0] = rope_tall[1] = rope_tall[2] = 84;
}

/* Сдвинуть полосу верёвки на экране БК и вставить новый столбец CGA */
static void rope_scroll(uint8_t r, const uint8_t *col)
{
    uint8_t (*h)[16] = rope_hist[r];
    if (rope_push(h[0], col)) rope_tall[r] = 84;
    uint8_t n = rope_tall[r] ? 16 : 8;
    if (rope_tall[r]) --rope_tall[r];
    uint8_t m = rope_m[r];
    rope_m[r] = m == 4 ? 0 : (uint8_t)(m + 1);
    if (m == 0) return;                       /* шаг без сдвига байта */
    /* сдвиг (4t - 5k) после шага: m+1 -> 0,4,3,2,1; m != 0, поэтому o = 0..3 */
    static const uint8_t ofs_t[5] = { 0, 4, 3, 2, 1 };
    uint8_t o = ofs_t[rope_m[r]];
    volatile uint8_t *row = (volatile uint8_t *)(VRAM_ADDR(rp_row[r]));
    gfx_scroll16(row, r == 1, n);
    snd_poll();
    if (r != 1)
        rope_edge(row, h[0], h[1], (uint8_t)(o << 1), n);   /* вправо: байт 0, окно [столбец t, t-1] */
    else
        rope_edge(row + 63, h[1], h[0], (uint8_t)((3 - o) << 1), n);   /* влево: байт 63, смещение 7 - o >= 4 */
}

/* 0x04A0 */
void rope_update(void)
{
    uint16_t d = rope_delay ? rope_delay : 256;   /* dec byte: из 0 получается 0xFF */
    if (d > g_passes4)
    {
        rope_delay = (uint8_t)(d - g_passes4);
        return;
    }
    rope_delay = 1;
    if (retrace()) return;
    if (cat_hit) return;
    if (item_y) return;
    uint16_t t = ticks();
    if (t == rope_t) return;
    rope_t = t;
    uint8_t al = t_rope_speed[g_level];
    if (cat_y <= 0x60) al >>= 2;
    rope_delay = al;
    uint8_t bx = (uint8_t)rope_cur;
    if (rope_cat_check(bx))
    {
        /* кот прыгает у этой верёвки: дотянуть вещь и сменить верёвку */
        if ((uint8_t)(rope_phase + rp_step[bx]) < 4) return;
        uint8_t dl;
        do dl = (uint8_t)(rand16() & 3); while (dl == rope_cur || dl == 3);
        bx = dl;
        goto pick;
    }
    rope_phase += rp_step[bx];
    if (rope_phase < 4) goto scroll;
    if ((uint8_t)rand16() > 0x40) goto newitem;
    {
        uint8_t dl;
        do
        {
            do dl = (uint8_t)(rand16() & 3); while (dl == 3);
        } while (rope_cat_check(dl));
        bx = dl;
    }
pick:
    rope_cur = bx;
newitem:
    rope_phase = rp_start[bx];
    wash_make(t_wash_lvl[g_level], rp_hi[bx]);
    if (rope_cur == 1)
    {
        rope_shift((uint8_t)((wash_mask >> 1) & 1));
        uint8_t c = wash_mask & 1;
        wash_mask >>= 1;        /* 0x0578 */
        rope_shift(c);
    }
    else
    {
        uint8_t c = wash_mask & 1;
        wash_mask >>= 1;
        rope_shift(c);
        c = wash_mask & 1;
        wash_mask >>= 1;
        rope_shift(c);
    }
    bx = (uint8_t)rope_cur;
scroll:
    if (rope_cat)
    {
        /* На PC кот уезжает вместе с видеопамятью полосы. На БК полоса
         * сдвигается не на каждом шаге, поэтому кот стирается и рисуется
         * заново на соседнем столбце CGA. */
        uint16_t ax = cat_x;
        uint8_t fall = 0;
        if (bx == 1)
        {
            if (ax < 4 || (ax -= 4) < 8) fall = 1;
        }
        else if ((ax += 4) >= 0x123)
            fall = 1;
        cat_erase();
        rope_scroll(bx, wash_buf + rope_phase);
        cat_pos += bx == 1 ? -1 : 1;
        if (fall)
        {
            cat_stun = 0x11;
            cat_vdir = 1;
            cat_vy = 1;
            cat_dec = 0x18;
            cat_speed = (cat_speed & 0xFF00) | 1;
            cat_onrope = 0;
        }
        else
            cat_x = ax;
        cat_nsize = cat_size;
        cat_draw();
        return;
    }
    rope_scroll(bx, wash_buf + rope_phase);
}

/* =========================================================== окна, предметы */

uint8_t win_n;             /* [1665] стадия окна: 0x1D..0, 0 — закрыто */
static uint16_t win_x;     /* [1666] */
static uint8_t win_y;      /* [1668] */
static uint8_t win_idx;    /* [1669] */
static uint8_t win_delay = 1;  /* [166A] */
static uint8_t win_row;    /* [166B] */
static uint16_t win_wait;  /* [166C] */
static uint16_t win_t;     /* [166E] */
static uint8_t win_throws; /* [1670] */
uint8_t win_cat_near;      /* [1664] кот у окна (мыши бегут быстрее) */
static uint16_t item_x;    /* [1671] */
static uint8_t item_dir;   /* [1674] */
static uint8_t item_hitcat;/* [1675] */
static uint8_t item_top;   /* [1676] */
static uint8_t felicia_mode; /* [1677] кот долго сидит на заборе — швыряют прицельно */
static uint16_t item_spr;  /* [17DD] */
static uint16_t item_sz;   /* [17DF] */
static uint16_t item_dsz;  /* [17E1] */
static uint16_t item_spos; /* [17E5] */
static uint16_t item_ssz;  /* [17E3] */
static uint16_t item_npos; /* [17E7] */
static uint8_t item_steps; /* [17E9] */
static uint16_t item_v;    /* [17EA] */
static uint16_t item_t;    /* [17EC] */
static uint8_t item_save[SAVE_SIZE(12, 4)];   /* [17EE] */

/* 0x1830 */
void windows_init(void)
{
    win_n = 0;
    item_y = 0;
    felicia_mode = 0;
    g_item_thrown = 0;
    win_wait = 9;
}

/* 0x1922 */
static void item_erase(void)
{
    gfx_restore(item_spos, SZW(item_ssz), item_save);
}

/* 0x1AEA: окно по номеру 0..11 -> X и Y */
static void win_xy(uint8_t dl, uint16_t *x, uint8_t *y)
{
    static const uint16_t wx[4] = { 0x18, 0x68, 0xB8, 0x108 };  /* [1658] */
    static const uint8_t wy[4] = { 24, 56, 88, 24 };            /* [1660] */
    *x = wx[dl & 3];
    *y = wy[(dl >> 2) & 3];
}

/* 0x1B05: кот в проёме окна; падение в открытое окно — вход в комнату */
static uint8_t win_cat_hit(void)
{
    if (!rect_hit(win_x, win_y, 0x20, 0x0F, cat_x, cat_y, 0x18, 0x0E)) return 0;
    if (cat_vdir == 1 && cat_hit == 0 && cat_y < 0x60 && win_n >= 5 && win_n < 0x19)
        cat_exit = 1;
    return 1;
}

/* 0x1B4C: окно над баком, на котором мышь? */
static uint8_t win_over_mouse(void)
{
    if (win_idx >= 8) return 0;
    uint8_t bx = (win_idx & 4) ? 2 : 1;   /* мышь 1 или 2 (ряды окон 0,1) */
    uint16_t ax = mouse_x[bx] + 0x10;
    if (ax < win_x) return 0;
    ax = ax >= 0x30 ? (uint16_t)(ax - 0x30) : 0;
    if (ax > win_x) return 0;
    return 1;
}

/* 0x1A76: шаг анимации шторы окна */
static void win_anim(void)
{
    --win_n;
    uint8_t dl;
    if (win_n > 0x0E)
        dl = (uint8_t)(win_y + win_n - 0x0E);
    else
        dl = (uint8_t)(win_y + 0x0E - win_n);
    win_row = dl;
    uint16_t p = POS_XY(win_x, dl);
    uint8_t n = (uint8_t)(win_row - win_y);
    if (win_n > 0x0E)
    {
        /* окно открывается: строка становится тёмной или с Фелицией */
        if (g_felicia_next)
            blit(p, SZ(1, 8), d_felicia_win + n * 8, BM_COPY);
        else
            gfx_fill(p, SZ(1, 8), 0);
    }
    else
        blit(p, SZ(1, 8), d_window_a + 1 + n * 10, BM_COPY);  /* закрывается: строка рамы */
}

/* 0x1936 */
void windows_update(void)
{
    uint16_t d = win_delay ? win_delay : 256;     /* dec byte: из 0 получается 0xFF */
    if (d > g_passes4)
    {
        win_delay = (uint8_t)(d - g_passes4);
        return;
    }
    win_delay = 0x0D;
    if (retrace()) return;
    if (win_n) win_cat_hit();
    if (item_y) return;
    if (win_n == 0)
    {
        if (cat_y > 0x60) return;
        felicia_mode = 0;
        if (cat_fence == 1 && !g_felicia_next && (uint16_t)(ticks() - cat_fence_t) >= 0x48)
            ++felicia_mode;
        for (;;)
        {
            uint8_t dl = (uint8_t)rand16();
            if (felicia_mode)
                dl &= 3;
            else
            {
                dl &= 0x0F;
                if (dl >= 0x0C) return;
            }
            win_idx = dl;
            win_xy(dl, &win_x, &win_y);
            if (!win_cat_hit()) break;
        }
        win_n = 0x1D;
        win_wait = t_win_wait[g_level];
        win_throws = 1;
    }
    if (win_cat_hit()) return;
    win_cat_near = 0;
    if (win_over_mouse())
    {
        ++win_cat_near;
        return;
    }
    if (win_n == 0x10) win_t = ticks();
    if (win_n == 0x0F && (uint16_t)(ticks() - win_t) < win_wait)
    {
        /* окно открыто: бросить предмет */
        if (!win_throws || item_y || g_felicia_next) return;
        --win_throws;
        g_item_thrown = 1;
        item_y = win_y;
        item_x = (uint16_t)((rand16() & 0x0F) + win_x);
        item_dir = item_x < cat_x ? 1 : 0xFF;
        uint8_t bx = (uint8_t)(rand16() & 6);
        item_spr = t_item_spr[bx >> 1];
        item_sz = t_item_sz[bx >> 1];
        item_top = t_item_top[bx >> 1];
        item_v = 0x20;
        item_steps = 1;
        item_hitcat = 0;
        return;
    }
    win_anim();
}

/* 0x184B: полёт предмета */
void item_update(void)
{
    if (!item_y) return;
    uint16_t t = ticks();
    if (t == item_t) return;
    item_t = t;
    if (felicia_mode && (item_x & 0xFFF8) == (cat_x & 0xFFF8)) item_dir = 0;
    ++item_steps;
    if (item_v <= 1) --item_v;
    uint16_t ax = item_x;
    uint16_t dx = (uint16_t)((item_v & 0xFF00) | ((item_v & 0xFF) >> 3));
    if (item_dir == 1)
    {
        ax += dx;
        if (ax >= 0x12F) ax = 0x12E;
    }
    else if (item_dir != 0)
        ax = ax >= dx ? ax - dx : 0;
    item_x = ax;
    uint16_t bx = item_sz;
    uint8_t al = (uint8_t)((item_steps >> 1) + item_y);
    uint8_t dl = al;
    if (al >= item_top)
    {
        uint8_t bh = (uint8_t)(bx >> 8);
        uint8_t over = (uint8_t)(al - item_top);
        if (bh <= over)
        {
            /* упал за забор */
            item_y = 0;
            g_item_thrown = 0;
            item_erase();
            return;
        }
        bx = (uint16_t)(((bh - over) << 8) | (bx & 0xFF));
    }
    item_y = dl;
    item_dsz = bx;
    item_npos = POS_XY(item_x, dl);
    if (item_steps != 2) item_erase();
    if (items_hit()) return;
    item_spos = item_npos;
    item_ssz = item_dsz;
    gfx_blit(item_spos, SZW(item_dsz), gptr(item_spr), item_save, BM_KEY, 0);
}

/* 0x1B7A: предмет попал в кота */
uint8_t items_hit(void)
{
    if (g_state != 0) return 0;
    uint8_t dl = item_y;
    if (!dl) return 0;
    uint16_t cx = (uint16_t)((item_sz >> 8) | (item_sz << 8));
    if (!rect_hit(item_x, dl, 0x10, (uint8_t)cx, cat_x, cat_y, 0x18, 0x0E)) return 0;
    cat_erase();
    item_erase();
    cat_fall();
    if (!item_hitcat)
    {
        item_hitcat = 1;
        cat_splat();
        item_dir = item_dir == 0xFF ? 1 : 0xFF;
        item_v = 0x60;
        item_steps = 1;
        cat_onrope = 0;
    }
    return 1;
}

/* ============================================================ мышь в баке */

static uint8_t cm_n;        /* [1D59] стадия 0x1B..0 */
static uint16_t cm_t;       /* [1D5A] */
static uint16_t cm_x;       /* [1D5C] */
static uint8_t cm_y;        /* [1D5E] */
static uint8_t cm_row;      /* [1D5F] */
static uint16_t cm_spos;    /* [1D60] */
static uint16_t cm_pos;     /* [1D62] */
static uint16_t cm_size;    /* [1D64] */
static uint16_t cm_ssize;   /* [1D66] */
static uint8_t cm_save[SAVE_SIZE(13, 4)];   /* [1D24] */

/* 0x2210 */
void canmouse_init(void)
{
    cm_n = 0;
}

/* 0x22DC */
static void canmouse_erase(void)
{
    if (cm_n == 0x1A) return;
    gfx_restore(cm_spos, SZW(cm_ssize), cm_save);
}

/* 0x22F7: кот задел мышь — пёс просыпается */
uint8_t canmouse_hit(void)
{
    if (!cm_n) return 0;
    uint16_t cx = (uint16_t)((cm_size >> 8) | (cm_size << 8));
    if (!rect_hit(cm_x, cm_row, 0x10, (uint8_t)cx, cat_x, cat_y, 0x18, 0x0E)) return 0;
    can_alarm = 1;
    return 1;
}

static uint16_t cm_rt;     /* кадр последней проверки обратного хода */

/* 0x2216: мышь высовывается из бака и прячется */
void canmouse_update(void)
{
    uint16_t t = ticks();
    if (t == cm_t) return;
    if (!retrace_seen(&cm_rt)) return;
    cm_t = t;
    if (canmouse_hit()) return;
    if (!cm_n)
    {
        if (cat_y != 0x86 && cat_y != 0x8E && (uint8_t)rand16() > 5) return;
        uint8_t y;
        uint16_t cx = can_pick(&y);
        cm_y = (uint8_t)(y + 3);
        cm_x = (uint16_t)(cx + (rand16() & 7) + 6);
        cm_n = 0x1B;
    }
    --cm_n;
    uint8_t dl;
    uint16_t bx;
    if (cm_n > 0x0D)
    {
        dl = (uint8_t)(cm_y + cm_n - 0x0F);      /* вылезает: растёт снизу вверх */
        bx = (uint16_t)(((0x1B - cm_n) << 8) | 2);
    }
    else
    {
        dl = (uint8_t)(cm_y + 0x0C - cm_n);      /* прячется */
        bx = (uint16_t)((cm_n << 8) | 2);
    }
    cm_size = bx;
    cm_row = dl;
    cm_pos = POS_XY(cm_x, dl);
    canmouse_erase();
    if (canmouse_hit()) return;
    if (!cm_n) return;
    cm_spos = cm_pos;
    cm_ssize = cm_size;
    gfx_blit(cm_pos, SZW(cm_size), d_canmouse, cm_save, BM_KEY, 0);
}

/* ======================================================= мыши на верёвках */

uint16_t mouse_x[3];       /* [1F30] */
static const uint8_t mouse_y[3] = { 0, 32, 64 };   /* [1F36] */
static uint8_t mouse_dir[3];   /* [1F3C] */
static uint8_t mouse_pdir[3];  /* [1F3F] */
static uint16_t mouse_pos[3];  /* [1F42] */
static uint8_t mouse_hidden[3];/* [1F48] */
static uint16_t mouse_npos;    /* [1F4B] */
static uint8_t mouse_anim[3];  /* [1F4D] */
static uint8_t mouse_caught[3];/* [1F50] */
static uint16_t mouse_ct[3];   /* [1F53] */
static uint16_t mouse_t;       /* [1F65] */
static uint16_t mouse_cloud;   /* [1F67] */
static uint16_t mouse_step;    /* [1F69] */
static uint16_t mouse_i;       /* [1F6C] */
static uint8_t mouse_save[3][SAVE_SIZE(8, 4)];   /* [1ED0]/[1EF0]/[1F10] */
static uint8_t cloud_save[SAVE_SIZE(8, 12)];      /* [000E] */

/* 0x2330 */
void mice_init(void)
{
    mouse_i = 0;
    uint16_t ax = 0;
    uint8_t dl = 1;
    if (cat_x <= 0xA0)
    {
        ax = 0x12C;
        dl = 0xFF;
    }
    for (uint8_t i = 0; i < 3; ++i)
    {
        mouse_x[i] = ax;
        mouse_dir[i] = dl;
        mouse_hidden[i] = 1;
        mouse_caught[i] = 0;
    }
}

/* 0x254D */
static void mouse_erase(void)
{
    gfx_restore(mouse_pos[mouse_i], SZ(8, 4), mouse_save[mouse_i]);
}

/* 0x265E: мышь задета летящим предметом */
static uint8_t mouse_item_hit(void)
{
    if (!item_y) return 0;
    uint16_t i = mouse_i;
    return rect_hit(mouse_x[i], mouse_y[i], 0x10, 0x08, item_x, item_y, 0x10, 0x0C);
}

/* 0x2567: мышь и кот */
static uint8_t mouse_cat(void)
{
    uint16_t i = mouse_i;
    if (!rect_hit(mouse_x[i], mouse_y[i], 0x10, 0x08, cat_x, cat_y, 0x18, 0x0E)) return 0;
    if (mouse_caught[i]) return 1;
    if (cat_ry < 0x26) return 1;
    if (cat_onrope)
    {
        /* мышь врезалась в кота на верёвке: кот падает, драка-облако */
        cat_onrope = 0;
        cat_stun = 0x11;
        cat_vdir = 1;
        cat_dir = 0;
        uint16_t p = mouse_pos[i];
        if (mouse_x[i] >= 0x10) p -= 4;
        mouse_cloud = p;
        gfx_blit(p, SZ(8, 12), d_cloud, cloud_save, BM_KEY, 0);
        mouse_t = ticks();
        while ((uint16_t)(ticks() - mouse_t) < 8)
        {
            snd_squeal();
            snd_idle(30);
        }
        snd_off();
        gfx_restore(mouse_cloud, SZ(8, 12), cloud_save);
        return 1;
    }
    /* поймана в прыжке */
    mouse_caught[i] = 1;
    mouse_dir[i] = 1;
    mouse_ct[i] = ticks();
    cat_erase();
    gfx_blit(mouse_pos[i], SZ(8, 4), gptr(t_mouse_pts[i]), 0, BM_KEY, 0);
    cat_save_bg();
    add_score(t_mouse_score[i]);
    snd_beep(0x3E8, 0x2EE);
    return 1;
}

/* 0x237B */
void mice_update(void)
{
    uint16_t t = ticks();
    if (t == mouse_t) return;
    mouse_t = t;
    if (cat_hit) return;
    uint16_t bx = mouse_i + 1;
    if (bx >= 3) bx = 0;
    mouse_i = bx;
    if (mouse_item_hit()) return;
    if (mouse_cat()) return;
    bx = mouse_i;
    if (mouse_caught[bx])
    {
        if ((uint16_t)(ticks() - mouse_ct[bx]) < 0x36) return;
        /* вернулась: с края, дальнего от кота */
        uint8_t dl = 1;
        uint16_t ax = 0;
        if (cat_x <= 0xA0)
        {
            ax = 0x12C;
            dl = 0xFF;
        }
        mouse_x[bx] = ax;
        mouse_caught[bx] = 0;
        mouse_dir[bx] = dl;
    }
    mouse_pdir[bx] = mouse_dir[bx];
    uint16_t r;
    if (win_cat_near)
    {
        mouse_step = 0x0C;
        goto turn;
    }
    mouse_step = cat_y <= 0x60 ? 8 : 4;
    if (bx == rope_cur)
    {
turn:
        if (mouse_dir[bx] == 0)
        {
            r = rand16();
            goto rnddir;
        }
    }
    if (cat_onrope && mouse_y[bx] <= cat_y && (uint8_t)(mouse_y[bx] + 0x10) >= cat_y)
    {
        if ((uint8_t)rand16() <= t_mouse_chase[g_level])
        {
            /* бежит на кота */
            mouse_step = 0x0C;
            mouse_dir[bx] = mouse_x[bx] < cat_x ? 1 : 0xFF;
            goto move;
        }
    }
    {
        uint8_t cl = 0x18;
        if (cat_y > 0x60)
        {
            cl = 0x28;
            if (mouse_dir[bx] == 0) cl = 0x10;
        }
        r = rand16();
        if ((uint8_t)r > cl) goto move;
        if (mouse_dir[bx] != 0)
        {
            mouse_dir[bx] = 0;
            goto move;
        }
    }
rnddir:
    mouse_dir[bx] = (r & 1) ? 1 : 0xFF;
move:
    {
        uint8_t dl = mouse_dir[bx];
        uint16_t ax = mouse_x[bx];
        if (dl == 1)
        {
            ax += mouse_step;
            if (ax >= 0x12F)
            {
                ax = 0x12E;
                dl = 0xFF;
            }
        }
        else if (dl != 0)
        {
            if (ax >= mouse_step) ax -= mouse_step;
            else
            {
                ax = 0;
                dl = 1;
            }
        }
        mouse_x[bx] = ax;
        mouse_dir[bx] = dl;
        mouse_npos = POS_XY(ax, mouse_y[bx]);
    }
    if (!mouse_hidden[bx] && (mouse_dir[bx] | mouse_pdir[bx])) mouse_erase();
    if (mouse_item_hit()) return;
    if (mouse_cat()) return;
    bx = mouse_i;
    mouse_hidden[bx] = 0;
    uint16_t si;
    if (mouse_dir[bx] == 0)
    {
        if (mouse_pdir[bx] == 0) return;
        si = 0x1E30;
    }
    else
    {
        si = 0x1E50;
        ++mouse_anim[bx];
        if (!(mouse_anim[bx] & 1)) si += 0x20;
        if (mouse_dir[bx] != 1) si += 0x40;
    }
    mouse_pos[bx] = mouse_npos;
    gfx_blit(mouse_npos, SZ(8, 4), gptr(si), mouse_save[bx], BM_AND, 0);
}

/* ============================================================== жизни */

static uint8_t lives_shown = 0xFF;   /* [1F81] */

/* 0x26B3 */
void lives_update(void)
{
    if (g_lives == lives_shown) return;
    lives_shown = g_lives;
    blit(POS(0x1260), SZ(8, 2), d_digits + g_lives * 16, BM_COPY);
}

void lives_invalidate(void)
{
    lives_shown = 0xFF;
}
