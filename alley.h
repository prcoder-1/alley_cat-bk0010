#pragma once
#include <stdint.h>

/* Двор: состояние верёвок с бельём */
extern uint8_t wash_buf[64];   /* [04D7] */
extern uint8_t wash_mask;      /* [0540] */
extern uint8_t rope_bits[16];  /* [1015..1024] */
extern uint8_t rope_phase;     /* [0525] столбец вещи, входящий в кадр */
extern uint16_t rope_cur;      /* [052F] верёвка, которая сейчас едет */
extern uint8_t rope_delay;     /* [0531] */

void wash_make(uint8_t lo, uint8_t hi);
void alley_draw(void);
void alley_draw_title(void);

extern uint8_t rope_hist[3][3][16];
extern uint16_t mouse_x[3];
extern uint8_t win_n;
extern uint8_t win_cat_near;
extern uint8_t can_last;

uint16_t can_pick(uint8_t *y);
uint8_t alley_land(void);
void rope_update(void);       /* 0x04A0 */
void rope_tall_reset(void);   /* (БК) полоса верёвки: снова все 16 строк */
void windows_init(void);      /* 0x1830 */
void windows_update(void);    /* 0x1936 */
void item_update(void);       /* 0x184B */
uint8_t items_hit(void);      /* 0x1B7A */
void canmouse_init(void);     /* 0x2210 */
void canmouse_update(void);   /* 0x2216 */
uint8_t canmouse_hit(void);   /* 0x22F7 */
void mice_init(void);         /* 0x2330 */
void mice_update(void);       /* 0x237B */
void lives_update(void);      /* 0x26B3 */
void lives_invalidate(void);
extern uint8_t rope_m[3];
void debris_draw(void);
