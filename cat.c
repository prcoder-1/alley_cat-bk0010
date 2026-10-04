/*
 * Кот: перевод процедур CAT.EXE 0x0700..0x11E3 (без ветки плавания 0x0953,
 * она в оверлее аквариума) и общей части 0x1608.
 */
#include "cat.h"
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "snd.h"
#include "dog.h"
#include "data_kernel.h"

uint8_t cat_fence, cat_exit, cat_failed, cat_won;
uint16_t cat_to_aqua, cat_fence_t;
uint8_t cat_enter, cat_enter_dly, cat_hit, cat_stun, cat_onrope;
uint16_t cat_spr, cat_pos, cat_size, cat_npos, cat_nsize, cat_jsize, cat_jspr;
uint8_t cat_frame, cat_snd_rope, cat_idle_n, cat_dir, cat_pdir, cat_pvdir, cat_vdir;
uint16_t cat_speed, cat_swvx;
uint8_t cat_vy, cat_acc, cat_dec;
uint16_t cat_x;
uint8_t cat_y, cat_ry;
uint16_t cat_tick, cat_tick_lo;
uint8_t cat_noerase, cat_thrown;
uint16_t cat_thr_anim, cat_sw_anim, cat_air_t;
uint8_t cat_drown, cat_drown_y, cat_drown_n;
uint16_t cat_xmin, cat_xmax, cat_sub;
uint8_t cat_window;
uint8_t cat_tint;       /* БК: цвет кота вместо чёрного (аквариум, см. ROOM2) */
uint8_t cat_save[SAVE_SIZE(14, 6)];
static uint8_t splat_save[SAVE_SIZE(18, 10)];  /* [000E] в 0x1166 */

uint8_t in_dx, in_dy, in_btn;

struct scene_hooks hooks;

/* тайминг «второго обновления внутри тика» — проходы главного цикла */
extern uint16_t g_passes;

#define CALL(h) (hooks.h ? hooks.h() : 0)

/* 0x0700 */
void cat_reset_timer(void)
{
    cat_tick = 0;
    cat_sub = 0;
}

/* 0x1124: снять фон под котом */
void cat_save_bg(void)
{
    gfx_save(cat_pos, SZW(cat_size), cat_save);
    cat_noerase = 0;
}

/* 0x1145: вывести кота (AND) со снятием фона */
void cat_draw(void)
{
    static const uint8_t tint_fill[4] = { 0x00, SWAPC(0x55), SWAPC(0xAA), 0xFF };
    cat_size = cat_nsize;
    cat_noerase = 0;
    gfx_ntint = (uint8_t)~tint_fill[cat_tint];
    gfx_blit(cat_pos, SZW(cat_nsize), gptr(cat_spr), cat_save, cat_tint ? BM_TINT : BM_AND, 0);
}

/* 0x11E3: стереть кота */
void cat_erase(void)
{
    gfx_restore(cat_pos, SZW(cat_size), cat_save);
}

/* 0x1112 */
void cat_redraw(void)
{
    cat_pos = POS_XY(cat_x, cat_y);
    cat_save_bg();
}

/* 0x070D: кот входит во двор с края, ближнего к нему */
void cat_init_alley(void)
{
    uint16_t cx = 0;
    uint8_t ah = 1;
    if (cat_x >= 0xA0)
    {
        cx = 0x128;
        ah = 0xFF;
    }
    cat_dir = ah;
    cat_enter = 3;
    cat_enter_dly = 0x0C;
    cat_x = cx;
    cat_y = 0xB4;
    cat_ry = 0xE6;
    cat_pos = POS_XY(cx, 0xB4);
    cat_size = 0x0B03;
    cat_save_bg();
    cat_vdir = 0;
    cat_speed = 2;
    cat_vy = 1;
    cat_stun = 0;
    cat_fence = 0;
    cat_onrope = 0;
    cat_hit = 0;
    cat_noerase = 0;
    in_dx = 0;
    in_dy = 0;
    cat_exit = 0;
    cat_thrown = 0;
    cat_failed = 0;
    cat_to_aqua = 0;
    cat_won = 0;
    cat_window = 0;
    cat_reset_timer();
}

/* 0x07A1: кот в комнате (или снова во дворе — в точке, где ушёл) */
void cat_init_room(void)
{
    uint16_t cx;
    uint8_t dl;
    if (g_state == 0)
    {
        cx = g_alley_x;
        dl = g_alley_y;
    }
    else
    {
        dl = t_room_cat_y[g_state];
        cx = t_room_cat_x[g_state];
    }
    cat_x = cx;
    cat_y = dl;
    cat_ry = (uint8_t)(dl + 0x32);
    cat_pos = POS_XY(cx, dl);
    cat_jspr = 0x0A7C;   /* [0FB2] */
    cat_jsize = 0x0D03;  /* [0FBE] */
    cat_size = 0x0D03;
    cat_save_bg();
    cat_vdir = 1;
    cat_dir = 0;
    cat_vy = 1;
    cat_dec = 0x40;
    cat_stun = g_state == 7 ? 0 : 0x0A;
    cat_fence = 0;
    cat_onrope = 0;
    cat_hit = 0;
    cat_noerase = 0;
    in_dx = 0;
    in_dy = 0;
    cat_exit = 0;
    cat_thrown = 0;
    cat_failed = 0;
    cat_to_aqua = 0;
    cat_won = 0;
    cat_window = 0;
    cat_reset_timer();
    if (g_state == 2)
    {
        cat_vy = 0x10;
        cat_swvx = 0x10;
        cat_air_t = ticks();
        cat_drown = 0;
        cat_drown_y = 5;
        cat_drown_n = 1;
    }
}

/* 0x0872: метла вышвыривает кота к окну комнаты */
void cat_swept(void)
{
    snd_rhythm_freq = 0x400;
    if (cat_thrown) return;
    cat_vy = 8;
    cat_vdir = cat_y < room_win_y ? 1 : 0xFF;
    uint16_t ax = cat_x - room_win_x;
    uint8_t dl = 0xFF;
    if (!(cat_x > room_win_x))
    {
        dl = 1;
        ax = (uint16_t)~ax;
    }
    cat_dir = dl;
    if (ax >> 8) ax = 0xFF;
    uint8_t al = (uint8_t)~ax;
    if (al < 0x30) al = 0x30;
    al = (uint8_t)(al - (al >> 2));
    cat_dec = al;
    cat_speed = al >> 5;
    cat_onrope = 0;
    cheese_hole = 0;
    cat_acc = 1;
    cat_stun = 0x10;
    cat_thrown = 1;
}

/* 0x0FC9: шаг по X; 1 — упёрся в границу */
uint8_t cat_move_x(void)
{
    cat_xmin = 8;
    cat_xmax = 0x123;
    if (g_state == 7)
    {
        cat_xmin = 0x24;
        cat_xmax = 0x10F;
    }
    uint16_t ax = cat_x;
    if (cat_dir == 0) return 0;
    if (cat_dir == 1)
    {
        ax += cat_speed;
        if (ax >= cat_xmax)
        {
            cat_x = cat_xmax - 1;
            return 1;
        }
    }
    else
    {
        if (ax < cat_speed || (ax -= cat_speed) < cat_xmin)
        {
            cat_x = cat_xmin;
            return 1;
        }
    }
    cat_x = ax;
    return 0;
}

/* 0x1020: следующий кадр ходьбы; разгон до 8 */
static uint16_t walk_frame(void)
{
    if (cat_dir != cat_pdir) cat_speed = 2;
    if (cat_speed < 8)
    {
        --cat_acc;
        if ((cat_acc & 3) == 0) ++cat_speed;
    }
    uint8_t bl = (uint8_t)(cat_frame + 1);
    if (bl >= 6) bl = 0;
    cat_frame = bl;
    if (cat_dir == 0xFF) bl += 6;
    return t_cat_walk[bl];
}

/* 0x0F87: вход с края — видна часть спрайта шириной 3-n слов */
static void enter_clip(uint8_t n, uint8_t dir)
{
    cat_nsize = (uint16_t)(0x0B03 - n);
    if (dir != 0xFF)
    {
        cat_spr += (uint16_t)n << 1;
        cat_x = 0;
    }
    else
        cat_x = (uint16_t)n * 8 + 0x128;
    /* 0x2D70: строки спрайта с шагом 6 байт в буфер [000E] */
    const uint8_t *s = gptr(cat_spr);
    uint8_t *d = g_scratch;
    uint8_t w = (uint8_t)((3 - n) << 1);
    for (uint8_t r = 0; r < 11; ++r)
    {
        for (uint8_t i = 0; i < w; ++i) d[i] = s[i];
        d += w;
        s += 6;
    }
    cat_spr = 0x000E;
}

/* 0x1069: кот сидит — шевелит хвостом и головой */
static void cat_idle(void)
{
    cat_speed = 2;
    cat_acc = 8;
    if (cat_size == 0x0C02)
    {
        ++cat_idle_n;
        if (cat_idle_n & 7) return;
    }
    cat_erase();
    if (CALL(items_hit)) return;
    if (dog_hit()) return;
    uint16_t r = rand16() & 0x0E;
    cat_size = 0x0C02;
    /* верх и низ — один вывод (фон под котом снимается вместе со стиранием) */
    static uint8_t idle[48];
    const uint8_t *a = gptr(t_cat_idle_a[r >> 1]);
    r = rand16() & 6;
    const uint8_t *b = gptr(t_cat_idle_b[r >> 1]);
    for (uint8_t i = 0; i < 24; ++i)
    {
        idle[i] = a[i];
        idle[i + 24] = b[i];
        asm ("" : "+r" (i));   /* иначе gcc соберёт вызов memcpy */
    }
    gfx_blit(cat_pos, SZ(12, 4), idle, cat_save, BM_AND, 0);
    cat_noerase = 0;
}

/* 0x10DD: кота сбили — падает без управления */
void cat_fall(void)
{
    cat_onrope = 0;
    cat_vdir = 1;
    cat_vy = 2;
    cat_dec = 1;
    cat_acc = 0xFF;
    cat_dir = 0;
    cat_hit = 1;
    cat_jspr = 0x0A2E;   /* [0FAC] */
    cat_jsize = 0x0D03;  /* [0FB8] */
    cat_fence = 2;
}

/* 0x1166: «шлепок» (кота сбили) — клякса и звук 10 тиков */
void cat_splat(void)
{
    uint16_t cx = cat_x >= 0x0C ? cat_x - 0x0C : 0;
    if (cx >= 0x10F) cx = 0x10E;
    uint16_t p = POS_XY(cx, cat_y);
    gfx_blit(p, SZ(18, 10), gptr(0x1679), splat_save, BM_KEY, 0);
    uint16_t t0 = ticks();
    snd_splat_init();
    do snd_splat(); while ((uint16_t)(ticks() - t0) < 0x0A);
    snd_off();
    gfx_restore(p, SZ(18, 10), splat_save);
    cat_noerase = 0;
    if (g_item_thrown && g_lives) --g_lives;
}

static uint16_t cat_rt;   /* кадр последней проверки обратного хода */

/* 0x08E5: обновление кота */
void cat_update(void)
{
    uint16_t t = ticks();
    uint16_t ax = 0;     /* AX после int 1Ah или 0x20 */
    if (t == cat_tick)
    {
        if (cat_sub == 0) return;
        if (cat_sub > g_passes)
        {
            cat_sub -= g_passes;
            return;
        }
        cat_sub = 0;
    }
    else
        cat_sub = ax = 0x20;
    if (g_state == 2 || (cat_vdir | cat_dir) == 0)
    {
        if (!retrace_seen(&cat_rt)) return;
    }
    cat_tick = t;
    cat_tick_lo = ax;    /* 0x092A */
    if (CALL(busy)) return;
    if (g_state == 2)
    {
        if (hooks.swim) hooks.swim();
        return;
    }

    /* 0x0BAC: ходьба, прыжок, падение */
    if (CALL(items_hit)) return;
    if (dog_fight) return;
    if (cat_enter)
    {
        if (cat_enter_dly)
        {
            if (!dog_active) --cat_enter_dly;
            return;
        }
        if (--cat_enter == 0)
        {
            cat_speed = 8;
            cat_move_x();
            goto c1c;
        }
        cat_spr = walk_frame();
        enter_clip(cat_enter, cat_dir);
        if (cat_enter != 2) cat_erase();
        if (CALL(items_hit)) return;
        if (dog_hit()) return;
        cat_pos = POS_XY(cat_x, cat_y);
        cat_draw();
        return;
    }
c1c:
    if (cat_onrope)
    {
        if (cat_onrope == 1)
        {
            cat_onrope = 2;
            cat_speed = 6;
            cat_npos = POS_XY(cat_x, cat_y);
            cat_erase();
            if (CALL(items_hit)) return;
            if (dog_hit()) return;
            cat_pos = cat_npos;
            cat_nsize = 0x0E03;
            cat_spr = 0x09DA;
            cat_draw();
        }
        if (in_dy == 0) return;
        goto e78;
    }

    uint8_t al;
    if (cat_vdir != 0)
    {
        /* в воздухе */
        if (cat_move_x())
        {
            cat_dir = 0;
            cat_vy = 2;
            cat_vdir = 1;
            cat_stun = 0;
        }
        else
        {
            uint8_t a = cat_acc;
            cat_acc = (uint8_t)(a - cat_dec);
            if (a < cat_dec)
            {
                if (cat_vdir != 1)
                {
                    if (cat_vy > 1) --cat_vy;
                    else cat_vdir = 1;
                }
                else if (cat_vy < 4)
                    ++cat_vy;
            }
        }
        /* 0x0CC1 */
        if (cat_hit == 0)
        {
            uint8_t chk = 1;
            if (cat_stun && --cat_stun) chk = 0;
            if (chk && cat_vdir == 1 && cat_land())
            {
                al = cat_ry;
                goto landed;
            }
        }
        al = cat_ry;
        if (cat_vdir != 1)
        {
            if (al < cat_vy)
            {
                al = 0;
                cat_vdir = 1;
                cat_vy = 1;
            }
            else
                al -= cat_vy;
        }
        else
        {
            al += cat_vy;
            if (al > 0xE6)
            {
                if (g_state == 7)
                {
                    if (al >= 0xF8)
                    {
                        al = 0xF8;
                        cat_exit = 1;
                    }
                    goto d4f;
                }
                al = 0xE6;
                cat_fence = 0;
                goto landed;
            }
        }
        goto d4f;
landed:
        cat_vdir = 0;
        cat_thrown = 0;
        cat_speed = 2;
        cat_stun = 0;
        cat_hit = 0;
        if (cat_onrope) snd_land();
d4f:
        cat_ry = al;
        cat_y = al >= 0x32 ? (uint8_t)(al - 0x32) : 0;
        cat_npos = POS_XY(cat_x, cat_y);
        if (!cat_noerase) cat_erase();
        if (CALL(items_hit) || dog_hit())
        {
            cat_noerase = 1;
            return;
        }
        cat_pos = cat_npos;
        uint16_t bx;
        if (cat_thrown)
        {
            cat_thr_anim += 2;
            uint8_t i = (uint8_t)((cat_thr_anim & 0x0E) >> 1);
            cat_spr = t_cat_tumble[i];
            bx = t_cat_tumble_sz[i];
        }
        else
        {
            cat_spr = cat_jspr;
            bx = cat_jsize;
        }
        cat_nsize = bx;
        uint8_t over = (uint8_t)(0x32 - cat_ry);
        if (cat_ry < 0x32)
        {
            /* верх спрайта над краем экрана — обрезать сверху */
            uint8_t bh = (uint8_t)(bx >> 8);
            if (bh <= over)
            {
                cat_noerase = 1;
                return;
            }
            bx = (uint16_t)(((bh - over) << 8) | (bx & 0xFF));
            cat_nsize = bx;
            cat_spr = (uint16_t)(cat_jspr + over * ((bx & 0xFF) << 1));
            cat_draw();
            return;
        }
        /* 0x0DDE: обрезка снизу — за забором (после окна) и у Фелиции */
        if (g_state == 7)
        {
            if (cat_y < 0xBB) goto draw;
            al = (uint8_t)(cat_y - 0xBB);
        }
        else
        {
            if (cat_fence != 2 || cat_y < 0x5E) goto draw;
            al = (uint8_t)(cat_y - 0x5E);
        }
        {
            uint8_t bh = (uint8_t)(bx >> 8);
            if (bh <= al)
            {
                if (g_state == 7)
                {
                    cat_exit = 1;
                    return;
                }
                cat_init_alley();
                snd_behind_fence();
                return;
            }
            cat_nsize = (uint16_t)(((bh - al) << 8) | (bx & 0xFF));
            cat_vy = 2;
        }
draw:
        cat_draw();
        return;
    }

    /* 0x0E23: стоит */
    if (g_state == 7 || cat_y < 0xB4)
    {
        if (!cat_land())
        {
            cat_dir = 0;
            cat_vdir = 1;
            goto eb1;
        }
        if (g_state == 0)
        {
            if (!CALL(can_mouse))
                cat_snd_rope = 0;
            else
            {
                if (!cat_snd_rope) snd_mouse_bump();
                in_dy = 1;
                cat_snd_rope = 1;
                in_dx = (rand16() & 1) ? 1 : 0xFF;
            }
        }
    }
e78:
    cat_pdir = cat_dir;
    cat_dir = in_dx;
    cat_vdir = in_dy;
    if (in_dy == 0) goto f34;
    {
        uint8_t ah, a;
        if (cat_vdir == 1)
        {
            if (cat_y >= 0xB4)
            {
                cat_vdir = 0;
                cat_thrown = 0;
                in_dy = 0;
                goto f34;
            }
eb1:
            ah = 1;
            a = 0x20;
            cat_stun = 8;
            if (cat_fence == 1) cat_fence = 0;
        }
        else
        {
            /* прыжок: спад скорости подъёма зависит от разбега */
            cat_stun = 0;
            uint8_t bl = (uint8_t)cat_speed;
            if (bl > 2) cat_speed = (cat_speed & 0xFF00) | (uint8_t)(bl - 2);
            ah = 8;
            a = (uint8_t)((bl ^ 0x0F) << 4);
            if (cat_fence == 1) ++cat_fence;
        }
        cat_dec = a;
        cat_vy = ah;
        cat_acc = 1;
        cat_onrope = 0;
        uint8_t bl = (uint8_t)((uint8_t)(cat_dir + 1) << 1);
        if (cat_vdir != 0xFF) bl += 6;
        cat_jspr = t_cat_jump[bl >> 1];
        cat_jsize = t_cat_jump_sz[bl >> 1];
        cheese_hole = 0;
        if (cat_window) snd_jump_off();
        return;
    }
f34:
    if (g_state != 0 && g_state != 7 && hooks.floor_step) hooks.floor_step();
    cat_move_x();
    cat_npos = POS_XY(cat_x, cat_y);
    if ((cat_dir | cat_vdir) == 0)
    {
        cat_idle();
        return;
    }
    cat_spr = walk_frame();
    cat_erase();
    if (CALL(items_hit)) return;
    if (dog_hit()) return;
    cat_pos = cat_npos;
    cat_nsize = 0x0B03;
    cat_draw();
}

/* 0x1608: опора под котом — своя у каждой сцены */
uint8_t cat_land(void)
{
    return CALL(land);
}
