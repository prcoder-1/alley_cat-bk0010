#include "game.h"
#include "gfx.h"
#include "data_kernel.h"

uint16_t g_state;
uint16_t g_prev_state;
uint16_t g_level;
uint16_t g_skill;
uint8_t g_sound = 0xFF;

/* 0x2E29 */
uint8_t rect_hit(uint16_t ax, uint8_t ay, uint16_t aw, uint8_t ah,
                 uint16_t bx, uint8_t by, uint16_t bw, uint8_t bh)
{
    if ((uint16_t)(ax + aw) < bx) return 0;
    uint16_t t = ax >= bw ? (uint16_t)(ax - bw) : 0;
    if (t > bx) return 0;
    if ((uint8_t)(ay + ah) < by) return 0;
    uint8_t u = ay >= bh ? (uint8_t)(ay - bh) : 0;
    if (u > by) return 0;
    return 1;
}

/* 0x2B24 */
void draw_list(const uint16_t *lst, uint16_t base, const uint8_t *gfx, uint16_t gfx_addr)
{
    uint16_t size = *lst++;
    for (;;)
    {
        uint16_t src = *lst++;
        if (src == 0xFFFF) return;
        uint16_t dst = (uint16_t)(*lst++ + base);
        blit(pos_of(dst), size, gfx + (src - gfx_addr), BM_COPY);
    }
}

uint8_t g_lives;
uint16_t g_alley_x;
uint8_t g_alley_y;
uint8_t g_item_thrown;
uint8_t item_y;
uint16_t room_win_x;
uint8_t room_win_y;
uint8_t cheese_hole;
uint16_t g_passes = 1;
uint16_t g_passes4 = 1;
uint8_t g_felicia_next;
uint16_t g_fail_pic;
uint8_t g_scratch[200];

/* Блоки графики: 0..4 — ядро, 5..7 — сцена (сбрасываются при смене сцены). */
struct gregion { uint16_t start, end; const uint8_t *data; };
static struct gregion regions[8] = {
    { 0x000E, 0x000E + sizeof g_scratch, g_scratch },
    { 0x09DA, 0x0F7A, d_cat },
    { 0x1679, 0x1679 + 180, d_splat },
    { 0x2720, 0x27C0, d_digits },
    { 0x1280, 0x15C8, d_dog },
};

void gfx_region(uint8_t slot, uint16_t ds_start, uint16_t ds_end, const uint8_t *data)
{
    regions[slot].start = ds_start;
    regions[slot].end = ds_end;
    regions[slot].data = data;
}

void gfx_regions_reset(void)
{
    for (uint8_t i = 5; i < 8; ++i) regions[i].end = 0;
}

const uint8_t *gptr(uint16_t off)
{
    for (struct gregion *r = regions; r < regions + 8; ++r)
        if (off >= r->start && off < r->end) return r->data + (off - r->start);
    return d_cat;
}

/* Состояние верёвок двора: создаётся оверлеем фона, используется оверлеем двора */
uint8_t wash_buf[64];      /* [04D7] вещь на верёвке 16x16 (формат БК) */
uint8_t wash_mask;         /* [0540] */
uint8_t rope_bits[16];     /* [1015..1024] карта белья */
uint8_t rope_phase;        /* [0525] */
uint16_t rope_cur;         /* [052F] */
uint8_t rope_delay;        /* [0531] */
uint8_t rope_m[3];         /* шаг прокрутки по модулю 5 (только БК) */
uint8_t rope_hist[3][3][16];
