/*
 * Бельё на верёвках: новая вещь (0x067D, 0x06DE).
 */
#include "alley.h"
#include "game.h"
#include "data_wash.h"

/* 0x06DE: половинка вещи 8x8 в левую или правую половину буфера */
static uint8_t wash_half(uint8_t *dst)
{
    uint16_t r = rand16() & 6;
    if (r == 6) return 0;
    const uint8_t *src = r == 0 ? d_wash_half2 : r == 2 ? d_wash_half : d_wash_half + 16;
    for (uint8_t i = 0; i < 8; ++i)
    {
        dst[0] = src[0];
        dst[1] = src[1];
        src += 2;
        dst += 4;
    }
    return 1;
}

/* 0x067D: новая вещь в буфер. lo/hi — пороги случайности (BL/BH) */
void wash_make(uint8_t lo, uint8_t hi)
{
    wash_mask = 0;
    for (uint8_t i = 0; i < 64; ++i) wash_buf[i] = 0xAA;
    wash_buf[4] = wash_buf[5] = wash_buf[6] = wash_buf[7] = 0x11;  /* верёвка 0x4444 */
    uint16_t r = rand16();
    if ((uint8_t)r < lo || (uint8_t)(r >> 8) <= hi) return;
    r = rand16();
    if ((uint8_t)r < 0x18)
    {
        for (uint8_t i = 0; i < 64; ++i) wash_buf[i] = d_wash_full[i];
        wash_mask = 3;
    }
    else if ((uint8_t)r < 0x60)
    {
        for (uint8_t i = 0; i < 32; ++i) wash_buf[i] = d_wash_top[i];
        wash_mask = 3;
    }
    else
    {
        wash_mask = (uint8_t)(wash_half(wash_buf) << 1);
        wash_mask |= wash_half(wash_buf + 2);
    }
}

