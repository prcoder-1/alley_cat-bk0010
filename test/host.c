/*
 * Хостовая обвязка для дифференциальных тестов: модель gfx.s на C,
 * управляемые тесту время/ввод/обратный ход, ГСЧ как в helpers.s.
 */
#include <stdint.h>
#include <string.h>

uint8_t vram[16384];
uint16_t gfx_ntint;             /* как экран БК: 64 байта на строку */
#define ROW0 28

extern const uint8_t gfx_j0_t[80], gfx_je_t[128];
extern const int8_t gfx_rel0_t[80];

static void geom(uint16_t pos, uint16_t size, int *addr, int *nb, int *rows, int *w, int *rel0)
{
    int W = size & 0xFF, c = pos & 0xFF;
    *w = W; *rows = size >> 8;
    int j0 = gfx_j0_t[c];
    *nb = gfx_je_t[c + W] - j0;
    *rel0 = gfx_rel0_t[c];
    *addr = (((pos >> 8) + ROW0) << 6) + j0;
}

uint16_t gfx_span(uint16_t pos, uint16_t size)
{
    int a, nb, r, w, rel;
    geom(pos, size, &a, &nb, &r, &w, &rel);
    return (uint16_t)nb;
}

void gfx_save(uint16_t pos, uint16_t size, uint8_t *buf)
{
    int a, nb, r, w, rel;
    geom(pos, size, &a, &nb, &r, &w, &rel);
    for (int y = 0; y < r; ++y, a += 64)
        for (int i = 0; i < nb; ++i) *buf++ = vram[(a + i) & 16383];
}

static uint8_t inmask(int rel, int W)
{
    uint8_t m = 0xFF;
    for (int i = 0; i < 4; ++i)
        if (rel + i < 0 || rel + i >= 4 * W) m &= (uint8_t)~(3 << (2 * i));
    return m;
}

void gfx_restore(uint16_t pos, uint16_t size, const uint8_t *buf)
{
    int a, nb, r, w, rel;
    geom(pos, size, &a, &nb, &r, &w, &rel);
    for (int y = 0; y < r; ++y, a += 64)
        for (int i = 0; i < nb; ++i)
        {
            uint8_t m = inmask(rel + 5 * i, w), *d = &vram[(a + i) & 16383];
            *d = (uint8_t)((*d & ~m) | (*buf++ & m));
        }
}

void gfx_blit(uint16_t pos, uint16_t size, const uint8_t *src, uint8_t *save, uint16_t mode, uint16_t stride)
{
    int a, nb, rows, W, rel0;
    geom(pos, size, &a, &nb, &rows, &W, &rel0);
    if (stride == 0) stride = W;
    else if (stride == 1) stride = 0;
    uint8_t fill = (mode == 1 || mode == 4) ? 0xFF : 0;
    for (int y = 0; y < rows; ++y, a += 64, src += stride)
    {
        uint8_t p[90];
        p[0] = fill;
        memcpy(p + 1, src, W);
        p[W + 1] = p[W + 2] = fill;
        for (int j = 0; j < nb; ++j)
        {
            int rel = rel0 + 5 * j;               /* пиксель спрайта, с которого начинается байт */
            int k = (rel >= 0 ? rel / 4 : -1);
            int s = rel - 4 * k;
            unsigned wv = p[k + 1] | (p[k + 2] << 8);
            uint8_t v = (uint8_t)(wv >> (2 * s));
            uint8_t m = 0xFF;                     /* пиксели внутри спрайта */
            for (int i = 0; i < 4; ++i)
                if (rel + i < 0 || rel + i >= 4 * W) m &= (uint8_t)~(3 << (2 * i));
            uint8_t *d = &vram[(a + j) & 16383];
            if (save) *save++ = *d;
            switch (mode)
            {
            case 0: *d = (uint8_t)((*d & ~m) | (v & m)); break;
            case 1: *d &= v; break;
            case 2: { uint8_t k2 = (uint8_t)((v | (v >> 1)) & 0x55); k2 |= (uint8_t)(k2 << 1); *d = (uint8_t)((*d & ~k2) | v); } break;
            case 3: *d |= v; break;
            case 4: *d = (uint8_t)((*d & v) | (~v & ~gfx_ntint)); break;
            }
        }
    }
}

/* fwin.s: спрайт в байты БК (вне спрайта нули) и вывод с прозрачным цветом 0 */
void fw_conv(uint8_t *dst, const uint8_t *src, uint16_t size, int16_t rel0, uint16_t nb)
{
    int W = size & 0xFF, rows = size >> 8;
    for (int y = 0; y < rows; ++y, src += W)
    {
        uint8_t p[90] = { 0 };
        memcpy(p + 1, src, W);
        for (int j = 0; j < nb; ++j)
        {
            int rel = rel0 + 5 * j;
            int k = (rel >= 0 ? rel / 4 : -1);
            *dst++ = (uint8_t)((p[k + 1] | (p[k + 2] << 8)) >> (2 * (rel - 4 * k)));
        }
    }
}

void fw_key(uint16_t pos, const uint8_t *buf, uint16_t size)
{
    int a = (((pos >> 8) + ROW0) << 6) + gfx_j0_t[pos & 0xFF], nb = size & 0xFF;
    for (int y = 0; y < (size >> 8); ++y, a += 64)
        for (int j = 0; j < nb; ++j)
        {
            uint8_t v = *buf++, k = (uint8_t)((v | (v >> 1)) & 0x55);
            k |= (uint8_t)(k << 1);
            uint8_t *d = &vram[(a + j) & 16383];
            *d = (uint8_t)((*d & ~k) | v);
        }
}

/* время и ввод — задаёт тест */
uint16_t host_ticks;
uint8_t host_retrace = 1;
uint16_t ticks(void) { return host_ticks; }
uint16_t loop_passes(void) { return 1; }
static uint16_t host_sub;
uint16_t tmr_elapsed(void)
{
    host_sub += 3;
    if (host_sub >= 1287) { host_sub -= 1287; ++host_ticks; }
    return 3;
}
uint8_t retrace(void) { return host_retrace; }
uint8_t retrace_seen(uint16_t *last) { (void)last; return host_retrace; }
void tone_sq(uint16_t hp, uint16_t counts) { (void)hp; (void)counts; }
void gfx_flush(void) {}
void gfx_init(void) {}
void gfx_scroll16(volatile uint8_t *row, uint16_t left)
{
    for (int y = 0; y < 16; ++y, row += 64)
        if (left) for (int i = 0; i < 63; ++i) row[i] = row[i + 1];
        else for (int i = 63; i; --i) row[i] = row[i - 1];
}
uint16_t umulhi(uint16_t a, uint16_t b) { return (uint16_t)(((uint32_t)a * b) >> 16); }
void wait_tick(void) { ++host_ticks; }
uint16_t to_tick(void) { return 1; }
uint8_t key_state[22] __attribute__((aligned(2)));
uint16_t key_presses;
void input_poll(void) {}
void spk_set(uint8_t on) { (void)on; }

uint16_t rand_state;
uint16_t rand16(void)
{
    unsigned fb = ((rand_state ^ (rand_state >> 8)) >> 1) & 1;
    rand_state = (uint16_t)((rand_state >> 1) | (fb << 15));
    return rand_state;
}
void rand_seed(uint16_t s) { rand_state = s ? s : 0xFA59; }
void tile8x2(uint8_t *dst, const uint8_t *src, uint16_t stride)
{
    for (int y = 0; y < 8; ++y, src += 2, dst += stride) { dst[0] = src[0]; dst[1] = src[1]; }
}
