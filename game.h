#pragma once
#include <stdint.h>

/*
 * Общее состояние игры. Имена — смысловые, в комментарии — адрес переменной
 * в сегменте данных CAT.EXE (DS:xxxx), из которой она переведена.
 */

extern uint16_t g_state;      /* [0004] текущая сцена: 0 двор, 1..7 комнаты */
extern uint16_t g_prev_state; /* [0006] сцена, из которой вернулись */
extern uint16_t g_level;      /* [0008] уровень сложности/прогресс 0..7 */
extern uint16_t g_skill;      /* [6DF8] выбранный уровень (K/H/T/A = 0..3) */
extern uint8_t g_sound;       /* [0000] звук включён (0xFF) */

uint16_t rand16(void);        /* 0x2DFD: возвращает DX */
void rand_seed(uint16_t s);   /* 0x2E10 */

/* 0x2E29: пересечение прямоугольников. a=(ax,al_y), размеры si/cl; b=(bx,dh) */
uint8_t rect_hit(uint16_t ax, uint8_t ay, uint16_t aw, uint8_t ah,
                 uint16_t bx, uint8_t by, uint16_t bw, uint8_t bh);

/* 0x2B24: нарисовать список блоков (заголовок CX, пары src/dst, конец 0xFFFF) */
void draw_list(const uint16_t *lst, uint16_t base, const uint8_t *gfx, uint16_t gfx_addr);

extern uint8_t g_lives;       /* [1F80] */
extern uint16_t g_alley_x;    /* [0001] где кот ушёл со двора */
extern uint8_t g_alley_y;     /* [0003] */
extern uint8_t g_item_thrown; /* [1678] в кота летит предмет из окна */
extern uint16_t room_win_x;   /* [2650] окно комнаты (куда метла выметает кота) */
extern uint8_t room_win_y;    /* [2652] */
extern uint8_t cheese_hole;   /* [39E0] дырка сыра, у которой стоит кот */
extern uint16_t g_passes;     /* проходов главного цикла PC с прошлой итерации */

/* Графика по смещению в сегменте данных оригинала (DS:xxxx) */
extern uint8_t g_scratch[];   /* [000E] рабочий буфер спрайта */
const uint8_t *gptr(uint16_t ds_off);
/* оверлей регистрирует свои блоки графики */
void gfx_region(uint8_t slot, uint16_t ds_start, uint16_t ds_end, const uint8_t *data);  /* слоты 5..7 */
void gfx_regions_reset(void);
extern uint8_t item_y;        /* [1673] высота летящего предмета (0 — нет) */
extern uint16_t g_passes4;    /* то же для блока «каждой 4-й итерации» */
extern uint8_t g_felicia_next; /* [0418] следующее окно ведёт к Фелиции */
extern uint8_t can_alarm;     /* [1D58] */
void add_score(uint8_t n);    /* 0x2706 */
extern uint16_t g_alley_t;     /* [0410] */
extern uint16_t g_felicia_t;   /* [0412] */
extern uint16_t g_felicia_n;   /* [0414] */
extern uint8_t g_back;         /* [0419] */
extern uint16_t g_fail_pic;    /* [1C30] */
void wipe(uint8_t pattern);    /* 0x1C67 */
void transition(void);         /* 0x1BF0 */

/* Текст шрифтом ПЗУ БК: строка пикселей y, знакоместо 0..31, цвет 1..3 */
void text_at(uint8_t y, uint8_t col, const char *s, uint8_t color);
