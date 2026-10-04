/*
 * Оверлей ROOM7: комната Фелиции (CAT.EXE 0x0260..0x02A7, 0x2E60..0x314E,
 * 0x4C10..0x5051 соперники, 0x6100..0x62EA стрелы амуров).
 * Подняться по сердечкам к Фелиции. Подарки (по одному за пройденную
 * комнату) отвлекают котов-соперников; стрелы ломают и чинят сердечки.
 */
#include "bonus.h"
#include "cat.h"
#include "dog.h"
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "ovl.h"
#include "room.h"
#include "score.h"
#include "snd.h"
#include "data_room7.h"

static uint16_t gift_x[8];     /* [2B5A] */
static uint8_t gift_y[8];      /* [2B6A] */
static uint8_t gift_on[8];     /* [2B72] */
static uint8_t hearts[126];    /* [2BE2] 0 — целое, 2 — дыра; 18 на ряд */
static const uint8_t row_base[7] = { 0, 18, 36, 54, 72, 90, 108 };   /* [2BDB] */
static uint16_t held;          /* [2E8D] подарок у кота, 0xFFFF — нет */
static uint16_t pick_t;        /* [2E8F] */
static uint16_t last_drop;     /* [2E94] */

/* соперник (копия записи из rv[]) */
struct rival
{
    uint16_t x;      /* [4548] */
    uint8_t dir;     /* [454A] */
    uint8_t y;       /* [454B] */
    uint16_t pos;    /* [454C] */
    uint8_t hidden;  /* [454E] */
    uint16_t wait;   /* [454F] отвлечён подарком с тика ... */
    uint16_t anim;   /* [4551] */
    uint8_t stun;    /* [4553] */
};
static struct rival r;         /* [4548] */
static struct rival rv[7];     /* [4554..] */
static uint16_t rv_i;          /* [45B6] */
static uint16_t rv_t;          /* [45B8] */
static uint16_t rv_npos;       /* [45BA] */
static uint16_t rv_speed;      /* [45BC] */
static uint8_t rv_batch;       /* [45BE] */

static uint16_t ar_last;       /* [70EC] */
static uint16_t ar_t;          /* [70EE] */
static uint16_t ar_anim;       /* [70F0] */
static uint8_t ar_on;          /* [70F2] */
static uint16_t ar_x;          /* [70F3] */
static uint8_t ar_y;           /* [70F5] */
static uint8_t ar_dir;         /* [70F6] */
static uint8_t ar_hidden;      /* [70F7] */
static uint16_t ar_spos;       /* [70F8] */
static uint16_t ar_pos;        /* [70FA] */
static uint8_t ar_save[SAVE_SIZE(8, 4)];   /* [70CC] */

uint8_t kennel_drinking, cheese_jump;
uint8_t (*room_extra_land)(void);

#define GIFT(off) (d_fel + ((off) - FEL_GIFT))

/* 0x30E3: сердечко (0 — целое, 2 — тёмное) */
static void heart_draw(uint16_t cx, uint8_t dl, uint8_t v)
{
    static const uint16_t spr[2] = { 0x2DE0, 0x2E00 };   /* [2E20] */
    blit(POS_XY(cx, dl), SZ(8, 4), d_hearts + (spr[v >> 1] - FEL_GFX), BM_COPY);
}

static void gift_draw(uint8_t i)
{
    blit(POS_XY(gift_x[i], gift_y[i]), SZ(15, 6), GIFT(0x2AF0), BM_COPY);
}

static void gift_clear(uint8_t i)
{
    blit(POS_XY(gift_x[i], gift_y[i]), SZ(15, 6), GIFT(0x2B7A), BM_COPY);
}

/* 0x300F */
static void draw(void)
{
    draw_list((const uint16_t *)(d_hearts + (0x2E24 - FEL_GFX)), 0, d_hearts, FEL_GFX);
    uint8_t row = 0;
    for (uint8_t y = 0xBF; ; y -= 0x18, ++row)
    {
        for (uint16_t x = 0x20; x < 0x111; x += 0x10)
        {
            uint8_t v = 0;
            if (y != 0xBF) v = (uint8_t)(rand16() & 2);
            heart_draw(x, y, v);
            uint16_t ax = x >> 4;
            ax = ax >= 2 ? ax - 2 : 0;
            if (ax >= 0x12) ax = 0x11;
            hearts[row_base[row] + ax] = v;
        }
        if (y - 0x18 < 0x2F) break;
    }
    held = 0xFFFF;
    last_drop = 0xFFFF;
    for (uint8_t i = 0; i < 8; ++i) gift_on[i] = 0;
    uint16_t n = g_felicia_n;
    if (n == 0) g_felicia_n = n = 1;
    if (n > 8) n = 8;
    while (n--)
    {
        gift_on[n] = 1;
        gift_y[n] = 0xB0;
        gift_x[n] = t_gift_x[n];
        gift_draw((uint8_t)n);
    }
}

/* 0x30FA: встать на целое сердечко */
static uint8_t hearts_land(void)
{
    uint8_t al = (uint8_t)((cat_y - 5) & 0xF8);
    for (int8_t bx = 6; bx >= 0; --bx)
    {
        if (al != t_row_y[bx]) continue;
        uint16_t ax = (cat_x + 7) >> 4;
        ax = ax >= 2 ? ax - 2 : 0;
        if (ax >= 0x12) ax = 0x11;
        if (hearts[row_base[bx] + ax]) return 0;
        cat_y = (uint8_t)(al + 5);
        cat_ry = (uint8_t)(al + 0x37);
        return 1;
    }
    return 0;
}

/* ============================================================= стрелы */

static void arrow_draw(void)
{
    ar_hidden = 0;
    uint16_t si = (ar_anim & 0x1E0) + (ar_dir != 0xFF ? 0xC0 : 0);
    ar_spos = ar_pos;
    gfx_blit(ar_pos, SZ(8, 4), d_arrow + si, ar_save, BM_KEY, 0);
}

static void arrow_erase(void)
{
    if (ar_hidden) return;
    gfx_restore(ar_spos, SZ(8, 4), ar_save);
}

/* 0x62A6: стрела попала в кота — сбивает */
static uint8_t arrow_cat(void)
{
    if (!ar_on) return 0;
    if (!rect_hit(ar_x, ar_y, 0x10, 8, cat_x, cat_y, 0x18, 0x0E)) return 0;
    cat_vdir = 1;
    cat_vy = 2;
    cat_dec = 0x20;
    cat_stun = 8;
    snd_beep(0x91D, 0xCE4);
    return 1;
}

/* 0x6245: стрела ломает/чинит сердечко */
static void arrow_heart(void)
{
    uint8_t al = (uint8_t)((ar_y - 8) & 0xF8);
    for (int8_t bx = 6; bx >= 0; --bx)
    {
        if (al != t_row_y[bx]) continue;
        uint16_t ax = ar_x >> 4;
        if (ax < 2 || (ax -= 2) >= 0x10) return;
        uint16_t di = ax;
        ax += row_base[bx];
        if (ax == ar_last) return;
        ar_last = ax;
        hearts[ax] ^= 2;
        arrow_erase();
        heart_draw((uint16_t)((di + 2) << 4), (uint8_t)(t_row_y[bx] + 0x0F), hearts[ax]);
        arrow_draw();
        return;
    }
}

/* 0x6106 */
static void arrow_update(void)
{
    uint16_t t = ticks();
    if (t == ar_t) return;
    ar_t = t;
    if (arrow_cat())
    {
        cat_erase();
        arrow_erase();
        cat_draw();
        ar_on = 0;
        return;
    }
    if (!ar_on)
    {
        for (;;)
        {
            uint16_t bx = rand16() & 0x1F;
            if (bx >= 0x10)
            {
                bx -= 0x10;
                if (bx > 9) continue;
                ar_dir = bx < 5 ? 1 : 0xFF;
                ar_y = 6;
                ar_x = t_cupid_x[bx] + 4;
            }
            else
            {
                uint16_t ax = 0x0C;
                uint8_t dl = 1;
                if (bx & 8)
                {
                    ax = 0x120;
                    dl = 0xFF;
                }
                ar_x = ax;
                ar_dir = dl;
                ar_y = (uint8_t)(t_cupid_y[bx & 7] + 8);
            }
            break;
        }
        ar_on = 1;
        ar_hidden = 1;
        ar_anim = 0;
        ar_last = 0xFFFF;
    }
    if (ar_anim < 0xA0) ar_anim += 4;
    ar_y += 2;
    uint8_t gone = ar_y > 0xBF;
    if (!gone)
    {
        if (ar_dir != 1)
        {
            if (ar_x < 5) gone = 1;
            else ar_x -= 5;
        }
        else if ((ar_x += 5) >= 0x12C)
            gone = 1;
    }
    if (!gone)
    {
        ar_pos = POS_XY(ar_x, ar_y);
        if (!arrow_cat())
        {
            arrow_heart();
            arrow_erase();
            arrow_draw();
            return;
        }
    }
    ar_on = 0;
    arrow_erase();
}

/* ============================================================ соперники */

static void rival_load(uint8_t bx) { r = rv[bx]; }
static void rival_store(uint8_t bx) { rv[bx] = r; }

/* 0x4FDF / 0x5008 */
static void rival_draw(void)
{
    r.hidden = 0;
    uint16_t si = 0x4500;
    if (r.dir != 0)
    {
        uint16_t bx = r.anim;
        if (r.stun) bx = (bx & 2) + 0x0C;
        if (r.dir == 0xFF) bx += 0x10;
        si = t_rival_frm[bx >> 1];
    }
    r.pos = rv_npos;
    blit(r.pos, SZ(12, 6), si == 0x4500 ? d_rivals : d_rivals2 + (si - 0x45E0), BM_OR);
}

static void rival_erase(void)
{
    if (r.hidden) return;
    gfx_fill(r.pos, SZ(12, 6), 0x55);
}

/* 0x502D: стрела закрывает соперника */
static uint8_t rival_arrow(void)
{
    if (!ar_on) return 0;
    return rect_hit(ar_x, ar_y, 0x10, 8, r.x, r.y, 0x18, 0x0C);
}

/* 0x4E75: соперник наткнулся на подарок — отвлёкся */
static void rival_gifts(void)
{
    for (int8_t i = 7; i >= 0; --i)
    {
        uint8_t bx = (uint8_t)i;
        if (!gift_on[bx]) continue;
        if (!rect_hit(gift_x[bx], gift_y[bx], 0x18, 0x0F, r.x, r.y, 0x18, 0x0C)) continue;
        if (!rv_batch)
        {
            cat_erase();
            if (ar_on) arrow_erase();
        }
        rival_erase();
        gift_on[bx] = 0;
        gift_clear(bx);
        if (!rv_batch)
        {
            if (ar_on) arrow_draw();
            cat_draw();
        }
        uint16_t dx = 0;
        if (rv_i != 6)
        {
            dx = ticks();
            if (dx == 0) --dx;
        }
        r.wait = dx;
        return;
    }
}

/* 0x4DD0: соперник и кот. Верхний — Фелиция: кот дошёл */
static uint8_t rival_cat(void)
{
    if (!rect_hit(cat_x, cat_y, 0x18, 0x0E, r.x, r.y, 0x18, 0x0C)) return 0;
    if (rv_i == 6)
    {
        cat_won = 1;
        cat_erase();
        rival_erase();
        return 1;
    }
    cat_erase();
    rival_erase();
    cat_draw();
    cat_stun = 4;
    cat_vdir = 1;
    cat_vy = 4;
    cat_dec = 8;
    r.stun = 4;
    r.dir = r.x > cat_x ? 1 : 0xFF;
    snd_beep(0xCE4, 0x123B);
    return 1;
}

/* 0x4E3E: после броска подарка — проверить всех */
static void rivals_vs_gifts(void)
{
    rv_batch = 1;
    uint16_t save = rv_i;
    for (rv_i = 0; rv_i < 7; ++rv_i)
    {
        rival_load((uint8_t)rv_i);
        if (r.wait == 0)
        {
            rival_gifts();
            rival_store((uint8_t)rv_i);
        }
    }
    rv_i = save;
}

/* 0x4C10 */
static void rivals_update(void)
{
    uint16_t t = ticks();
    if (t == rv_t) return;
    uint16_t bx = ++rv_i;
    if (bx == 1 || bx == 4) rv_t = t;
    else if (bx >= 7)
    {
        bx = 0;
        rv_i = 0;
        rv_t = t;
    }
    rival_load((uint8_t)bx);
    if (rival_arrow()) return;
    if (r.wait)
    {
        uint16_t ax = t_rival_wait[g_level];
        if (rv_i == 0) ax <<= 1;
        if ((uint16_t)(ticks() - r.wait) < ax) return;
        r.wait = 0;
        r.hidden = 1;
        r.x = cat_x > 0xA0 ? 0x24 : 0x108;
        r.dir = 0;
    }
    if (rival_cat())
    {
        rival_store((uint8_t)rv_i);
        return;
    }
    if (r.stun)
    {
        if (--r.stun == 0) r.dir = r.dir == 0xFF ? 1 : 0xFF;
    }
    else if (r.y <= cat_y)
    {
        if ((rv_i == 6 && cat_y < 0x28) || (uint8_t)rand16() <= t_rival_chase[g_level])
        {
            uint8_t dl = 0;
            if ((r.x & 0x0FF8) != (cat_x & 0x0FF8)) dl = (r.x & 0x0FF8) < (cat_x & 0x0FF8) ? 1 : 0xFF;
            r.dir = dl;
            if (cat_y >= 0x28 && rv_i == 6) r.dir = dl == 0xFF ? 1 : 0xFF;   /* Фелиция убегает */
        }
    }
    rv_speed = r.stun ? 4 : 8;
    uint16_t ax = r.x;
    if (r.dir == 0)
    {
        uint8_t d = (uint8_t)rand16();
        if (d <= 0x10) r.dir = (d & 1) ? 1 : 0xFF;
    }
    else
    {
        if (r.dir == 1)
        {
            ax += rv_speed;
            if (ax >= 0x10B)
            {
                ax = 0x10A;
                r.dir = 0xFF;
                r.stun = 0;
            }
        }
        else if (ax < rv_speed || (ax -= rv_speed) <= 0x24)
        {
            ax = 0x25;
            r.dir = 1;
            r.stun = 0;
        }
        r.x = ax;
        r.anim += 2;
        if (r.anim >= 0x0C) r.anim = 0;
        if (!r.stun && (uint8_t)rand16() <= 8) r.dir = 0;
    }
    rv_npos = POS_XY(r.x, r.y);
    if (rival_arrow()) return;
    if (!rival_cat())
    {
        rival_erase();
        rival_draw();
        rv_batch = 0;
        rival_gifts();
    }
    rival_store((uint8_t)rv_i);
}

/* 0x4F59 */
static void rivals_init(void)
{
    for (rv_i = 0; rv_i < 7; ++rv_i)
    {
        r.x = (rand16() & 0x7F) + 0x60;
        r.dir = 0;
        r.hidden = 1;
        r.anim = 0;
        r.stun = 0;
        uint16_t dx = 0;
        if (rv_i == 0)
        {
            dx = ticks();
            if (dx == 0) --dx;
        }
        r.wait = dx;
        r.y = (uint8_t)(t_row_y[rv_i] + 3);
        rival_store((uint8_t)rv_i);
    }
    rv_i = 0;
}

/* ============================================================== подарки */

/* 0x2F66: подобрать */
static void gift_pick(void)
{
    uint16_t t = ticks();
    if (t == pick_t) return;
    pick_t = t;
    if (held < 8)
    {
        last_drop = 0xFFFF;
        return;
    }
    for (int8_t i = 7; i >= 0; --i)
    {
        uint8_t bx = (uint8_t)i;
        if (!gift_on[bx]) continue;
        if (!rect_hit(gift_x[bx], gift_y[bx], 0x18, 0x0F, cat_x, cat_y, 0x18, 0x0E)) continue;
        if (bx == last_drop) return;
        cat_erase();
        if (ar_on) arrow_erase();
        gift_on[bx] = 0;
        held = bx;
        gift_clear(bx);
        if (ar_on) arrow_draw();
        cat_draw();
        snd_beep(0x3E8, 0x349);
        return;
    }
    last_drop = 0xFFFF;
}

/* 0x2E60: бросить на ближайший ряд (кнопка) */
static void gift_drop(void)
{
    if (held >= 8 || in_btn != 0) return;
    uint16_t row = 0xFFFF;
    uint8_t best = 0xFF;
    for (int8_t bx = 6; bx >= 0; --bx)
    {
        uint8_t al = cat_y >= t_row_y[bx] ? (uint8_t)(cat_y - t_row_y[bx]) : (uint8_t)~(uint8_t)(cat_y - t_row_y[bx]);
        if (al > best) continue;
        best = al;
        row = (uint16_t)bx;
    }
    if (row == 0xFFFF) row = 0;
    uint8_t g = (uint8_t)held;
    uint8_t y = t_row_y[row];
    uint16_t x = cat_x;
    if (x >= 0x108) x = 0x107;
    x &= 0x0FFC;
    for (int8_t i = 7; i >= 0; --i)
    {
        uint8_t bx = (uint8_t)i;
        if (bx == g || !gift_on[bx]) continue;
        if (rect_hit(gift_x[bx], gift_y[bx], 0x18, 0x0F, x, y, 0x18, 0x0F)) return;
    }
    gift_y[g] = y;
    gift_x[g] = x;
    cat_erase();
    if (ar_on) arrow_erase();
    last_drop = g;
    gift_on[g] = 1;
    gift_draw(g);
    held = 0xFFFF;
    rivals_vs_gifts();
    if (ar_on) arrow_draw();
    cat_draw();
    snd_beep(0x3E8, 0x4A5);
}

/* ------------------------------------------------- победа: 0x528B, 0x5060, 0x514A */

#define FW_FEL   (d_fwin)
#define FW_CAT   (d_fwin + (0x4B8A - 0x4A82))

/* 0x5060: кот с сердцем спускается к Фелиции, затем бонус */
static void fwin_approach(void)
{
    uint16_t ax = cat_x;
    if (ax >= 0x117) ax = 0x116;
    ax = ax >= 0x10 ? ax - 0x10 : 0;
    ax &= 0x0FF0;
    cat_x = ax;
    cat_y = 0x14;
    ax = ax >= 0x80 ? ax - 0x80 : (uint16_t)~(ax - 0x80);
    ax >>= 3;
    if (ax > 0x0D) ax = 0x0D;
    uint16_t step = ax + 2;       /* [4D6A] */
    uint16_t delay = 0x0A;        /* [4DD6] */
    for (;;)
    {
        if (delay != 0x0A) snd_tune();
        uint16_t t = ticks();
        ax = cat_x;
        uint16_t cx = ax & 0x0FF0;
        if (cx == 0x80) ax = cx;
        else if (cx > 0x80) ax -= step;
        else ax += step;
        cat_x = ax;
        if (cat_y >= 0x54) return;
        cat_y += 8;
        uint16_t pos = POS_XY(cat_x + 4, cat_y);
        gfx_blit(pos, SZ(32, 14), FW_CAT, 0, BM_KEY, 0);
        blit(POS_ADD(pos, 6, 3), SZ(13, 8), FW_FEL, BM_COPY);
        if (delay == 0x0A)
        {
            snd_jingle();
            snd_tune_init();
        }
        do
        {
            snd_tune();
            snd_idle(48);
        }
        while ((uint16_t)(ticks() - t) < delay);
        if (delay == 0x0A) bonus(held < 8);
        delay = 2;
    }
}

/* 0x519B / 0x522A: восемь сердечек разлетаются из одной точки */
static void fwin_phase(uint8_t k)
{
    const uint16_t *f = t_fwin;
    uint16_t spr = f[k], dx = f[9 + k], dy = f[12 + k], xmax = f[15 + k], ymax = f[18 + k];
    uint16_t size = f[21 + k], delay = f[24 + k];
    const uint8_t *src = d_fwin + (spr - 0x4A82);
    uint16_t x[8], y[8];
    for (int8_t i = 7; i >= 0; --i)
    {
        snd_tune();
        x[i] = f[3 + k];
        y[i] = f[6 + k];
    }
    uint8_t first = 1, done = 0;
    do
    {
        uint16_t t = ticks();
        for (int8_t i = 7; i >= 0; --i)
        {
            snd_tune();
            if (!first || i == 7)
                gfx_blit(POS_XY(x[i], y[i]), SZW(size), src, 0, BM_KEY, 0);
            uint16_t d = t_fwin_dir[i];
            if (d)
            {
                if (d == 1)
                {
                    x[i] += dx;
                    if (x[i] > xmax) { x[i] = xmax; ++done; }
                }
                else if (x[i] >= dx) x[i] -= dx;
                else { x[i] = 0; ++done; }
            }
            d = t_fwin_dir[8 + i];
            if (d)
            {
                if (d == 1)
                {
                    y[i] += dy;
                    if (y[i] > ymax) { y[i] = ymax; ++done; }
                }
                else if (y[i] >= dy) y[i] -= dy;
                else { y[i] = 0; ++done; }
            }
        }
        do
        {
            snd_tune();
            snd_idle(48);
        }
        while ((uint16_t)(ticks() - t) < delay);
        first = 0;
    }
    while (!done);
}

/* 0x528B: победа у Фелиции (до шторки возврата во двор) */
static void felicia_win(void)
{
    g_prev_state = 7;   /* на PC 0x528B вызывается из 0x1BF0, когда [0006] = 7 */
    snd_tune_init();
    fwin_approach();
    for (uint8_t k = 0; k < 3; ++k) fwin_phase(k);
    snd_tune_play();
    if (g_lives < 9) ++g_lives;
    if (g_level < 7) ++g_level;
    g_felicia_n = 0;
    g_felicia_t = ticks();
    snd_off();
    cat_x = 0x98;   /* 0x1C07 */
    cat_y = 0x5F;
}

static void run(void)
{
    g_state = 7;
    transition();
    draw();
    cat_init_room();
    (void)rand16();   /* 0x3405: метлы нет, но ГСЧ расходуется как на PC */
    ar_on = 0;
    rivals_init();
    snd_rhythm_reset();
    for (;;)
    {
        g_passes = loop_passes();
        hotkeys();
        input_update();
        snd_rhythm();
        cat_update();
        arrow_update();
        gift_pick();
        gift_drop();
        rivals_update();
        if (g_menu | g_restart) return;
        if (cat_won)
        {
            felicia_win();
            return;
        }
        if (cat_exit) return;
        snd_idle(48);
    }
}

void ovl_entry(void)
{
    ovl.run = run;
    hooks.items_hit = 0;
    hooks.land = hearts_land;
    hooks.can_mouse = 0;
    hooks.busy = 0;
    hooks.swim = 0;
    hooks.floor_step = 0;
    room_extra_land = 0;
}
