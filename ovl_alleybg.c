/*
 * Оверлей ALLEYBG: фон двора (0x2A00) и мусор на земле (0x5400).
 */
#include "alley.h"
#include "game.h"
#include "ovl.h"

static void bg_run(void)
{
    alley_draw();
    debris_draw();
}

void ovl_entry(void)
{
    ovl.run = bg_run;
}
