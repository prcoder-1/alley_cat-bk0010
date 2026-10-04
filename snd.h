#pragma once
#include <stdint.h>

/* Звук (PC-динамик через PIT -> бипер БК). Имена — по роли, в комментарии адрес. */
extern uint16_t snd_rhythm_freq;  /* [592A] */
extern uint8_t snd_dog_step;      /* [59BA] */
extern uint8_t snd_hold;          /* [5B07] */

void snd_idle(uint16_t counts);  /* непрерывный тон в простое цикла */
void snd_wait(uint16_t counts);  /* выждать, играя текущий тон */
void snd_off(void);              /* 0x5B21 */
void snd_fight_init(void);       /* 0x5450 */
void snd_rhythm_reset(void);     /* 0x58BD */
void snd_rhythm(void);           /* 0x546D: ритм сцены, шаги пса, драка, бипы */
void snd_beep(uint16_t div, uint16_t div2); /* 0x593B */
void snd_bird(void);             /* 0x595D */
void snd_surface(void);          /* 0x597F */
void snd_jump_off(void);         /* 0x58F8 */
void snd_can_land(void);         /* 0x590E */
void snd_mouse_bump(void);       /* 0x591F */
void snd_behind_fence(void);     /* 0x59CB */
void snd_splat_init(void);       /* [5A3C]=[5A3E]=0 */
void snd_splat(void);            /* 0x5A1C */
void snd_squeal(void);           /* 0x5A90 */
void snd_land(void);             /* 0x5AC2 */
void snd_wake(void);             /* 0x5691 */
void snd_spider_init(void);      /* 0x56F4 */
void snd_spider(void);           /* 0x5704 */
void snd_jingle(void);           /* 0x572E */
void snd_zap_init(void);         /* 0x5797 */
void snd_zap(void);              /* 0x57A6 */
void snd_tune2_init(void);       /* 0x57D5 */
void snd_tune2(void);            /* 0x57E4 */
void snd_bonus_init(void);       /* 0x5829 */
void snd_bonus_tick(void);       /* 0x5835 */
void snd_bonus_step(void);       /* 0x5869 */
void snd_wipe(void);             /* 0x5897 */
void snd_tune_init(void);        /* 0x5B54 */
void snd_tune(void);             /* 0x5B63 */
uint16_t snd_tune_pos(void);     /* [59BE] */
void snd_tune_play(void);        /* 0x5BBF */
void snd_tone(uint16_t div);      /* out 42h/43h: непрерывный тон */
