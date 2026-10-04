/*
 * Текст шрифтом ПЗУ монитора БК (адрес 0112276 — знак 040, 10 байт на знак,
 * младший бит — левый пиксель). Знакоместо 8x8 пикселей БК, 32 в строке.
 * Пауза (0x5E70).
 */
#include "game.h"
#include "gfx.h"
#include "hw.h"
#include "score.h"
#include "snd.h"

#ifdef HOST
extern const uint8_t host_font[];
#define FONT host_font
#else
#define FONT ((const uint8_t *)0112276)
#endif

#ifdef HOST
static void text_glyph(volatile uint8_t *dst, const uint8_t *glyph, uint16_t nfill)
{
    for (uint8_t r = 0; r < 8; ++r, dst += 64)
        for (uint8_t h = 0; h < 2; ++h)
        {
            uint8_t b = (uint8_t)(glyph[r] >> (h << 2)), v = 0;
            for (uint8_t i = 0; i < 4; ++i)
                if (b & (1 << i)) v |= (uint8_t)(3 << (i << 1));
            dst[h] = (uint8_t)(v & ~nfill);
        }
}
#else
void text_glyph(volatile uint8_t *dst, const uint8_t *glyph, uint16_t nfill);   /* gfx.s */
#endif

void text_at(uint8_t y, uint8_t col, const char *s, uint8_t color)
{
    static const uint8_t fill[4] = { 0x00, 0x55, 0xAA, 0xFF };
    uint16_t nf = (uint8_t)~fill[color & 3];
    volatile uint8_t *p = (volatile uint8_t *)VRAM_ADDR(y) + (col << 1);
    for (; *s; ++s, p += 2)
    {
        uint16_t c = (uint8_t)*s;
        if (c >= 'a' && c <= 'z') c -= 040;   /* на месте строчных латинских в ПЗУ — кириллица */
        c = (uint16_t)((c - 040) << 1);
        uint16_t c8 = (uint16_t)(c << 2);
        asm ("" : "+r" (c8));   /* иначе gcc соберёт c*10 в вызов __mulhi3 */
        text_glyph(p, FONT + c8 + c, nf);
    }
}

/* 0x5E70: пауза. Время стоит (на PC восстанавливается счётчик тиков BIOS). */
void game_pause(void)
{
    snd_off();
    uint16_t t = ticks();
    volatile uint16_t *src = (volatile uint16_t *)VRAM_ADDR(88);
    volatile uint16_t *bak = (volatile uint16_t *)VRAM_ADDR(200);
    for (uint16_t i = 0; i < 16 * 32; ++i) bak[i] = src[i];
    for (uint16_t i = 0; i < 16 * 32; ++i) src[i] = 0;
    text_at(88, 11, "Paws Game:", 2);
    text_at(96, 2, "Press any key to continue...", 2);
    uint16_t k = key_presses;
    while (k == key_presses) input_poll();
    for (uint16_t i = 0; i < 16 * 32; ++i) src[i] = bak[i];
    for (uint16_t i = 0; i < 16 * 32; ++i) bak[i] = 0;
    ticks_set(t);
    pause_presses = key_presses;
}
