#pragma once
#include <stdint.h>

/* Общее для комнат 1..6 (room.c) */
extern uint16_t broom_x;       /* [327D] */
extern uint8_t broom_y;        /* [327F] */
extern uint8_t broom_hidden;   /* [3286] */
extern uint16_t broom_frame;   /* [327A] */
extern uint8_t dirt[40];       /* [328E] */
extern uint8_t kennel_drinking;/* [44BD] кот пьёт (псарня) */
extern uint8_t cheese_jump;    /* [39E1] кот в прыжке через дырку (сыр) */
extern uint8_t (*room_extra_land)(void);  /* 0x3C43 полки библиотеки */

void room_frame(uint16_t base);   /* 0x29A0 */
void room_chairs(uint16_t base);  /* 0x2958 */
void room_lamp(uint16_t base);    /* 0x2970 */
void room_table(uint16_t base);   /* 0x2988 */
void room_stand(uint16_t base);   /* 0x2945 */
void room_list(uint16_t lst, uint16_t base);
uint8_t room_land(void);          /* 0x16C6 */
void broom_init(void);            /* 0x3405 */
void broom_update(void);          /* 0x3150 */
void broom_erase(void);           /* 0x33A0 */
void broom_draw(void);            /* 0x3339 */
void paw_draw(uint8_t bx, uint8_t n); /* 0x347F */
void room_floor_step(void);       /* 0x3445 */
void room_picture(uint16_t src, uint16_t pos);
