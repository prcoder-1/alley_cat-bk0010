/*
 * Оверлей ROOM1: гостиная с аквариумом (CAT.EXE 0x03E2..0x0425, 0x3850).
 * Кот, коснувшийся аквариума, ныряет в него (state 2).
 */
#include "cat.h"
#include "dog.h"
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "ovl.h"
#include "room.h"
#include "score.h"
#include "snd.h"
#include "data_room1.h"

uint8_t kennel_drinking, cheese_jump;
uint8_t (*room_extra_land)(void);

static uint16_t bowl_t;   /* [35DA] */
static uint16_t bowl_i;   /* [35D8] */

/* 0x3850: аквариум мерцает раз в 6 тиков; касание — нырок */
static void bowl_update(void)
{
    uint16_t t = ticks();
    if ((uint16_t)(t - bowl_t) < 6) return;
    bowl_t = t;
    bowl_i += 2;
    blit(POS(0x15C9), SZ(10, 4), d_bowl + ((bowl_i & 6) >> 1) * 40, BM_COPY);
    if (rect_hit(0xE4, 0x8A, 0x10, 0x0A, cat_x, cat_y, 0x18, 0x0E)) cat_to_aqua = 1;
}

/* 0x2790, ветка state 1 */
static void draw(void)
{
    room_frame(0x640);
    room_list(0x2570, 0xCA0);
    room_win_x = 0xA0;
    room_win_y = 0x60;
    room_chairs(0x1406);
    room_list(0x2344, 0x11C4);
    room_lamp(0x1422);
    room_table(0x1690);
    room_stand(0x16B6);
}

static void run(void)
{
    g_state = 1;
    transition();
    draw();
    cat_init_room();
    broom_init();
    dog_reset();
    snd_rhythm_reset();
    for (;;)
    {
        g_passes = loop_passes();
        hotkeys();
        input_update();
        snd_rhythm();
        cat_update();
        broom_update();
        dog_update();
        bowl_update();
        if (cat_to_aqua) return;
        if (cat_failed | cat_exit | g_restart | g_menu) return;
        snd_idle(48);
    }
}

void ovl_entry(void)
{
    ovl.run = run;
    hooks.items_hit = 0;
    hooks.land = room_land;
    hooks.can_mouse = 0;
    hooks.busy = 0;
    hooks.swim = 0;
    hooks.floor_step = room_floor_step;
    room_extra_land = 0;
}
