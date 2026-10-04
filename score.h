#pragma once
#include <stdint.h>

extern uint8_t g_score[7];
extern uint8_t g_hiscore[7];
extern uint8_t g_restart;      /* [041B] */
extern uint8_t g_menu;         /* [041C] */
extern uint16_t pause_presses; /* [6E00] */

void hiscore_update(void);     /* 0x2690 */
void digits_clear(uint8_t *d); /* 0x26E8 */
void hiscore_draw(void);       /* 0x26F2 */
void score_draw(void);         /* 0x26FC */
void digits_add(uint8_t *dst, const uint8_t *src); /* 0x271E */
void input_update(void);       /* 0x1200 */
void hotkeys(void);            /* 0x1338 */
void game_pause(void);         /* 0x5E70 */
