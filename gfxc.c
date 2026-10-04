#include "gfx.h"

#ifdef HOST
extern uint8_t vram[];
#define VRAM_BASE ((uintptr_t)vram)
#else
#define VRAM_BASE 0040000
#endif

/* смещение B800:off -> позиция (деление на 80 вычитанием: вызывается редко) */
uint16_t pos_of(uint16_t off)
{
    uint16_t row = (off >> 13) & 1;
    uint16_t l = off & 0x1FFF;
    while (l >= 80 * 8) { l -= 80 * 8; row += 16; }
    while (l >= 80) { l -= 80; row += 2; }
    return (uint16_t)((row << 8) | l);
}

static uint8_t fillrow[80];

void gfx_fill(uint16_t pos, uint16_t size, uint8_t pattern)
{
#ifndef HOST
    if (pattern == (uint8_t)((pattern << 2) | (pattern >> 6)))
    {
        gfx_fillu(pos, size, pattern);
        return;
    }
#endif
    uint8_t w = (uint8_t)size;
    for (uint8_t i = 0; i < w; ++i) fillrow[i] = pattern;
    gfx_blit(pos, size, fillrow, 0, BM_COPY, 1);
}

/* заливка образцом из двух байт (слово CGA, напр. 0x5655 забора) */
void gfx_fill2(uint16_t pos, uint16_t size, uint8_t b0, uint8_t b1)
{
    uint8_t w = (uint8_t)size;
    for (uint8_t i = 0; i < w; i += 2) { fillrow[i] = b0; fillrow[i + 1] = b1; }
    gfx_blit(pos, size, fillrow, 0, BM_COPY, 1);
}

void gfx_fill_rows(uint8_t row, uint8_t rows, uint8_t pattern)
{
    gfx_flush();
    uint16_t v = (uint16_t)(pattern | (pattern << 8));
    volatile uint16_t *p = (volatile uint16_t *)(VRAM_BASE + ((uint16_t)(row + 28) << 6));
    for (uint16_t n = (uint16_t)rows << 5; n; --n) *p++ = v;
}
