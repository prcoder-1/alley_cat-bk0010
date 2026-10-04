#pragma once
#include <stdint.h>

/* Пёс (двор и комнаты): 0x1E40..0x21E0 */
extern uint8_t dog_fight;   /* [1CB8] драка/уносит кота: направление */
extern uint8_t dog_active;  /* [1CBF] пёс на экране */

void dog_reset(void);       /* 0x1E40 */
void dog_update(void);      /* 0x1E63 */
uint8_t dog_hit(void);      /* 0x20F5: столкновение с котом -> драка (1) */
void dog_hit_force(void);   /* 0x2136 */
uint8_t dog_broom_hit(uint16_t bx, uint8_t by);  /* 0x21E0 */
