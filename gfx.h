#pragma once
#include <stdint.h>

/*
 * Вывод в координатах CGA 320x200 (см. gfx.s). Позиция — строка<<8 | столбец
 * байта CGA (x/4); размер — строк<<8 | ширина в байтах CGA.
 */
/* байт-образец CGA -> БК: цвета 1 и 2 поменяны (как PERM в re/mkdata.py) */
#define SWAPC(b) ((uint8_t)((((b) & 0x55) << 1) | (((b) & 0xAA) >> 1)))

void gfx_fillu(uint16_t pos, uint16_t size, uint8_t pattern);
void gfx_mode(const uint8_t *crop);   /* 0 — сжатие 4/5, gfx_crop — обрезка 1:1 (точки CGA 32..287); действует в своей сцене */
extern const uint8_t gfx_crop[];   /* gfxcrop.s: таблицы обрезки, только в сцене TITLE */
void gfx_blit(uint16_t pos, uint16_t size, const uint8_t *src, uint8_t *save, uint16_t mode, uint16_t stride);
void gfx_save(uint16_t pos, uint16_t size, uint8_t *buf);
void gfx_restore(uint16_t pos, uint16_t size, const uint8_t *buf);
uint16_t gfx_span(uint16_t pos, uint16_t size);
/* выполнить отложенное стирание gfx_restore (до прямой записи в экран, ожидания и смены сцены) */
void gfx_flush(void);
void gfx_init(void);
/* плитка 8 строк x 2 байта (подряд в src) в буфер со строками по stride байт (helpers.s) */
void tile8x2(uint8_t *dst, const uint8_t *src, uint16_t stride);   /* общие таблицы блиттера в ОЗУ БК: один раз при первой странице */
/* сдвинуть 16 строк экрана (по 64 байта) на байт вправо или влево (left) */
void gfx_scroll16(volatile uint8_t *row, uint16_t left);

enum BLIT_MODE { BM_COPY, BM_AND, BM_KEY, BM_OR, BM_TINT };
extern uint16_t gfx_ntint;   /* для BM_TINT: ~(байт цвета подкраски) */

#define SZ(rows, bytes) ((uint16_t)(((rows) << 8) | (bytes)))
/* размер из CX оригинала (строк:слов) */
#define SZW(cx) ((uint16_t)(((cx) & 0xFF00) | (((cx) & 0xFF) << 1)))

/* смещение в видеопамяти CGA (B800:off) -> позиция */
#define POS(off) ((uint16_t)((((((off) & 0x1FFF) / 80) * 2 + (((off) >> 13) & 1)) << 8) | (((off) & 0x1FFF) % 80)))
uint16_t pos_of(uint16_t off);

/* аналог 0x2CB0: x пикселей, y строк -> позиция */
#define POS_XY(x, y) ((uint16_t)(((uint16_t)(y) << 8) | ((uint16_t)(x) >> 2)))

/* сдвиг позиции на dy строк и dx байт */
#define POS_ADD(p, dy, dx) ((uint16_t)((p) + ((dy) << 8) + (dx)))

/* буфер сохранения фона под спрайт: строк*(ширина+1) байт */
#define SAVE_SIZE(rows, bytes) ((rows) * ((bytes) + 1))

static inline void blit(uint16_t pos, uint16_t size, const uint8_t *src, uint16_t mode)
{
    gfx_blit(pos, size, src, 0, mode, 0);
}

/* залить прямоугольник строк x байт CGA одним байтом-образцом (формат БК) */
void gfx_fill(uint16_t pos, uint16_t size, uint8_t pattern);
/* залить строки целиком (все 64 байта БК) */
void gfx_fill_rows(uint8_t row, uint8_t rows, uint8_t pattern);
void gfx_fill2(uint16_t pos, uint16_t size, uint8_t b0, uint8_t b1);

/* адрес строки CGA в видеопамяти БК */
#ifdef HOST
extern uint8_t vram[];
#define VRAM_ADDR(row) ((uintptr_t)vram + (((uint16_t)(row) + 28) << 6))
#else
#define VRAM_ADDR(row) (0040000 + (((uint16_t)(row) + 28) << 6))
#endif
