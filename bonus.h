#pragma once
#include <stdint.h>

/* 0x38B0: бонус за выигранную комнату; gift — у кота подарок Фелиции ([2E8D] < 8) */
void bonus(uint8_t gift);

/* фон под строкой бонуса; после её стирания (gfx_flush) свободен */
#define BN_SAVE2_SIZE (8 * 52)   /* SAVE_SIZE(8, 51) */
extern uint8_t bn_save2[BN_SAVE2_SIZE];
