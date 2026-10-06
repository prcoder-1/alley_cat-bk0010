/*
 * Оверлей ALLEY: игровой цикл двора (CAT.EXE 0x0140..0x01B4).
 */
#include "alley.h"
#include "cat.h"
#include "dog.h"
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "ovl.h"
#include "score.h"
#include "snd.h"
#include "data_alley.h"

static void alley_run(void);

/* вход оверлея — обязан быть первым в .text */
void ovl_entry(void)
{
    ovl.run = alley_run;
    hooks.items_hit = items_hit;
    hooks.land = alley_land;
    hooks.can_mouse = canmouse_hit;
    hooks.busy = 0;
    hooks.swim = 0;
    hooks.floor_step = 0;
    gfx_region(5, 0x172D, 0x17C9, d_items);
    gfx_region(6, 0x1DD0, 0x1ED0, d_mice);
    gfx_fence = 1;
    gfx_poll = snd_poll;
}

static void alley_run(void)
{
    uint8_t quarter = 0;   /* [040F] & 3 */
    dog_reset();
    windows_init();
    canmouse_init();
    mice_init();
    hiscore_draw();
    score_draw();
    snd_rhythm_reset();
    lives_invalidate();
    snd_poll_init();
    rope_tall_reset();
    for (;;)
    {
        g_passes = loop_passes();
        snd_pass();
        if (g_lives == 0) return;
        hotkeys();
        if (g_menu || g_restart) return;
        input_update();
        cat_update();
        snd_poll();
        dog_update();
        snd_poll();
        if (!dog_fight)
        {
            quarter += (uint8_t)g_passes;
            if (quarter < 4) goto idle;
            g_passes4 = quarter >> 2;
            quarter &= 3;
        }
        else
            g_passes4 = g_passes;
        snd_rhythm();
        rope_update();
        snd_poll();
        windows_update();
        item_update();
        snd_poll();
        canmouse_update();
        snd_poll();
        mice_update();
        snd_poll();
        lives_update();
        if (cat_exit) return;
idle:
        snd_pass_idle();
    }
}
