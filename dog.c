/*
 * Пёс: перевод процедур CAT.EXE 0x1E40..0x21E0.
 */
#include "dog.h"
#include "cat.h"
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "snd.h"
#include "data_kernel.h"

uint8_t dog_fight;          /* [1CB8] */
static uint16_t dog_steps;  /* [1CB9] сколько шагов облако дрожит на месте */
static uint16_t dog_spr;    /* [1CBB] */
static uint16_t dog_pos;    /* [1CBD] */
uint8_t dog_active;         /* [1CBF] */
static uint8_t dog_enter;   /* [1CC0] выход из-за края: 4..1 */
static uint8_t dog_leave;   /* [1CC1] уход за край */
static uint16_t dog_dsize;  /* [1CC2] размер выведенного */
static uint16_t dog_size;   /* [1CC4] */
uint16_t dog_x;             /* [1CC6] */
uint8_t dog_y;              /* [1CC8] */
static uint16_t dog_tick;   /* [1CC9] */
static uint16_t dog_npos;   /* [1CCD] */
static uint8_t dog_frame;   /* [1CCF] */
static uint8_t dog_dir;     /* [1CD0] */
static uint16_t dog_count;  /* [1CE1] */
uint8_t can_alarm;          /* [1D58] мышь в баке подняла пса */
static uint8_t dog_save[SAVE_SIZE(15, 8)];   /* [1C40] */

/* 0x1E40 */
void dog_reset(void)
{
    dog_active = 0;
    dog_count = 0;
    dog_enter = 0;
    dog_leave = 0;
    dog_fight = 0;
    dog_y = 0xB1;
    snd_fight_init();
}

/* 0x2022: кадр — ходьба по направлению или облако драки */
static void dog_frame_sel(void)
{
    uint8_t bl;
    if (dog_fight)
    {
        ++dog_frame;
        bl = (uint8_t)((dog_frame & 6) | 8);
    }
    else
    {
        dog_frame += 2;
        bl = dog_frame & 2;
        if (dog_dir == 1) bl |= 4;
    }
    dog_spr = t_dog_spr[bl >> 1];
}

/* 0x2059: часть спрайта у края экрана (ширина 4-n слов) */
static void dog_clip(uint8_t n, uint8_t ah)
{
    dog_size = (uint16_t)(0x0F04 - n);
    if (ah != 0xFF)
    {
        dog_spr += (uint16_t)n << 1;
        dog_x = 0;
    }
    else
        dog_x = (uint16_t)n * 8 + 0x120;
    const uint8_t *s = gptr(dog_spr);
    uint8_t *d = g_scratch;
    uint8_t w = (uint8_t)((4 - n) << 1);
    for (uint8_t r = 0; r < 15; ++r)
    {
        for (uint8_t i = 0; i < w; ++i) d[i] = s[i];
        d += w;
        s += 8;
    }
    dog_spr = 0x000E;
}

/* 0x209B */
static void dog_draw(void)
{
    dog_dsize = dog_size;
    if (!dog_fight)
        gfx_blit(dog_pos, SZW(dog_size), gptr(dog_spr), dog_save, BM_KEY, 0);
    else
        gfx_blit(dog_pos, SZW(dog_size), gptr(dog_spr), dog_save, BM_COPY, 0);
}

/* 0x20E1 */
static void dog_restore(void)
{
    gfx_restore(dog_pos, SZW(dog_dsize), dog_save);
}

/* 0x2136: драка — облако на месте встречи, кот переносится к дальнему краю */
static void fight_start(void)
{
    if (g_state == 6)
    {
        dog_y = cat_y;
        dog_x = cat_x;
    }
    uint16_t ax = (uint16_t)((dog_x + cat_x) >> 1);
    if (ax >= 0x118) ax = 0x117;
    dog_x = ax;
    uint8_t bl;
    uint16_t dx;
    if (ax > 0xA0)
    {
        bl = 1;
        dx = ax - 0x9F;
    }
    else
    {
        bl = 0xFF;
        dx = 0xA1 - ax;
    }
    dog_fight = bl;
    dog_active = 1;
    dog_leave = 0;
    dog_steps = dx >> 3;
    if (g_state == 6)
    {
        cat_erase();
        dog_fight = 0;
        dog_size = 0x0F04;
        dog_spr = t_dog_spr[0];
        dog_pos = POS_XY(dog_x, dog_y);
        dog_draw();
        dog_fight = bl;
    }
    dog_restore();
    cat_erase();
    cat_x = cat_x >= 0xA0 ? 0 : 0x122;
    if (g_state == 0) cat_init_alley();
}

/* 0x20F5 */
uint8_t dog_hit(void)
{
    if (dog_fight) return 0;
    if ((dog_active | dog_enter | dog_leave) == 0) return 0;
    if (cat_y < 0xA3) return 0;
    if (cat_enter) return 0;
    uint16_t ax = dog_x + 0x20;
    if (ax < cat_x) return 0;
    ax = ax >= 0x38 ? (uint16_t)(ax - 0x38) : 0;
    if (ax > cat_x) return 0;
    fight_start();
    return 1;
}

/* 0x21E0: метла задела пса */
uint8_t dog_broom_hit(uint16_t bx, uint8_t by)
{
    if ((dog_active | dog_enter | dog_leave) == 0) return 0;
    return rect_hit(bx, by, 0x10, 0x1E, dog_x, dog_y, 0x20, 0x0F);
}

/* 0x1E63 */
void dog_update(void)
{
    uint16_t t = ticks();
    if ((uint16_t)(t - dog_tick) < (uint16_t)((dog_count & 1) + 1)) return;
    if (!retrace()) return;
    dog_tick = t;
    ++dog_count;
    uint16_t ax;
    if (dog_leave)
    {
        if (--dog_leave == 0)
        {
            snd_off();
            if (dog_fight)
            {
                if (g_state != 0)
                {
                    cat_failed = 0xDD;
                    cat_x = 0xA0;
                    cat_y = 0x60;
                    return;
                }
                if (g_lives) --g_lives;
            }
            dog_restore();
            dog_reset();
            return;
        }
        dog_frame_sel();
        dog_clip((uint8_t)(4 - dog_leave), dog_dir == 0xFF ? 1 : 0xFF);
        goto draw;
    }
    if (dog_fight)
    {
        uint8_t dl = dog_fight;
        if (dog_steps)
        {
            --dog_steps;
            dl = (rand16() & 1) ? 1 : 0xFF;
        }
        dog_dir = dl;
        ax = dog_x;
        goto move;
    }
    if (!dog_active)
    {
        if (!dog_enter)
        {
            if (!can_alarm)
            {
                if (cat_y < 0xB4) return;
                if (cat_enter) return;
                if ((uint8_t)rand16() >= t_dog_appear[g_level]) return;
            }
            snd_dog_step = 0;
            dog_dir = cat_x < 0xA0 ? 0xFF : 1;
            dog_enter = 4;
        }
        if (--dog_enter == 0)
        {
            dog_active = 1;
            goto walk;
        }
        dog_frame_sel();
        dog_clip(dog_enter, dog_dir);
        goto draw;
    }
walk:
    can_alarm = 0;
    ax = dog_x;
    if (cat_y >= 0xB4 && !cat_enter)
    {
        if ((uint8_t)rand16() <= t_dog_chase[g_level])
            dog_dir = ax > cat_x ? 0xFF : 1;
    }
move:
    if (dog_dir == 0) goto stay;
    if (dog_dir == 1)
    {
        ax += 8;
        if (ax < 0x11E) goto stay;
        ax = 0x11E;
    }
    else
    {
        if (ax >= 8)
        {
            ax -= 8;
            goto stay;
        }
        ax = 0;
    }
    /* дошёл до края */
    if (dog_fight)
    {
        if (dog_steps) goto stay;
    }
    else if (cat_y >= 0xB4 && !cat_enter)
        goto stay;
    dog_leave = 4;
stay:
    dog_x = ax;
    dog_frame_sel();
    dog_size = 0x0F04;
draw:
    dog_npos = POS_XY(dog_x, dog_y);
    if (dog_enter != 3) dog_restore();
    if (dog_hit()) return;
    dog_pos = dog_npos;
    dog_draw();
}

/* 0x2136 снаружи: проснувшаяся собака в псарне бросается на кота */
void dog_hit_force(void)
{
    fight_start();
}
