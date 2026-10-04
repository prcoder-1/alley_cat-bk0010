#pragma once
#include <stdint.h>

/* Кот: переменные DS:0550..0587, 05F1..05FA, 0684 оригинала */
extern uint8_t cat_fence;      /* [0550] 1 — сидит на заборе, 2 — после окна */
extern uint8_t cat_exit;       /* [0551] вышел из сцены (окно / низ экрана Фелиции) */
extern uint8_t cat_failed;     /* [0552] сцена провалена (0xDD — побит собакой в комнате) */
extern uint8_t cat_won;        /* [0553] сцена пройдена */
extern uint16_t cat_to_aqua;   /* [0554] перейти в аквариум */
extern uint16_t cat_fence_t;   /* [0556] тик, когда сел на забор */
extern uint8_t cat_enter;      /* [0558] вход с края экрана: осталось шагов */
extern uint8_t cat_enter_dly;  /* [0559] задержка перед входом */
extern uint8_t cat_hit;        /* [055A] сбит (падает без управления) */
extern uint8_t cat_stun;       /* [055B] таймер оглушения/прыжка */
extern uint8_t cat_onrope;     /* [055C] стоит на верёвке/полке (1), 2 — повис */
extern uint16_t cat_spr;       /* [055D] спрайт (смещение DS) */
extern uint16_t cat_pos;       /* [055F] позиция на экране */
extern uint16_t cat_size;      /* [0561] размер выведенного спрайта (строк:слов) */
extern uint16_t cat_npos;      /* [0563] новая позиция */
extern uint16_t cat_nsize;     /* [0565] размер нового спрайта */
extern uint16_t cat_jsize;     /* [0567] размер кадра прыжка */
extern uint16_t cat_jspr;      /* [0569] кадр прыжка */
extern uint8_t cat_frame;      /* [056B] кадр ходьбы 0..5 */
extern uint8_t cat_snd_rope;   /* [056C] звук «зацепился за мышь» уже был */
extern uint8_t cat_idle_n;     /* [056D] */
extern uint8_t cat_dir;        /* [056E] 1 вправо, 0xFF влево, 0 стоит */
extern uint8_t cat_pdir;       /* [056F] */
extern uint8_t cat_pvdir;      /* [0570] */
extern uint8_t cat_vdir;       /* [0571] 0xFF вверх, 1 вниз, 0 нет */
extern uint16_t cat_speed;     /* [0572] шаг по X */
extern uint16_t cat_swvx;      /* [0574] скорость плавания по X (x8) */
extern uint8_t cat_vy;         /* [0576] шаг по Y (при плавании x16) */
extern uint8_t cat_acc;        /* [0577] накопитель замедления прыжка */
extern uint8_t cat_dec;        /* [0578] шаг накопителя */
extern uint16_t cat_x;         /* [0579] X 0..0x127 */
extern uint8_t cat_y;          /* [057B] Y верха спрайта 0..0xB4 */
extern uint8_t cat_ry;         /* [057C] «сырой» Y = Y + 0x32 */
extern uint16_t cat_tick;      /* [057D] тик последнего обновления */
extern uint16_t cat_tick_lo;   /* [057F] */
extern uint8_t cat_noerase;    /* [0583] фон под котом уже восстановлен */
extern uint8_t cat_thrown;     /* [0584] выметен метлой */
extern uint16_t cat_thr_anim;  /* [0585] */
extern uint16_t cat_sw_anim;   /* [0587] */
extern uint16_t cat_air_t;     /* [05F1] тик последнего вдоха */
extern uint8_t cat_drown;      /* [05F3] тонет */
extern uint8_t cat_drown_y;    /* [05F4] */
extern uint8_t cat_drown_n;    /* [05F5] */
extern uint16_t cat_xmin;      /* [05F6] */
extern uint16_t cat_xmax;      /* [05F8] */
extern uint16_t cat_sub;       /* [0684] второе обновление внутри тика */
extern uint8_t cat_window;     /* [127C] звук посадки уже был */
extern uint8_t cat_tint;       /* БК: оттенок чёрного у кота (нехватка воздуха) */
extern uint8_t cat_save[];     /* [05FA] фон под котом (формат БК) */

extern uint8_t in_dx;          /* [0698] ввод по горизонтали: 1 / 0xFF / 0 */
extern uint8_t in_dy;          /* [0699] ввод по вертикали */
extern uint8_t in_btn;         /* [069A] кнопка: 0 нажата, 0x10 отпущена */

void cat_reset_timer(void);    /* 0x0700 */
void cat_init_alley(void);     /* 0x070D */
void cat_init_room(void);      /* 0x07A1 */
void cat_swept(void);          /* 0x0872 */
void cat_update(void);         /* 0x08E5 */
void cat_fall(void);           /* 0x10DD */
void cat_redraw(void);         /* 0x1112 */
void cat_save_bg(void);        /* 0x1124 */
void cat_draw(void);           /* 0x1145 */
void cat_splat(void);          /* 0x1166 */
void cat_erase(void);          /* 0x11E3 */
uint8_t cat_move_x(void);      /* 0x0FC9: 1 — упёрся в край */

/*
 * Крючки сцен (заполняет оверлей). Возвращают 1 там, где оригинал ставит CF.
 */
struct scene_hooks
{
    uint8_t (*items_hit)(void);   /* 0x1B7A: брошенный предмет попал в кота (двор) */
    uint8_t (*land)(void);        /* 0x1608: есть ли опора под котом (1 — встал) */
    uint8_t (*can_mouse)(void);   /* 0x22F7: кот задел мышь из бака (двор) */
    uint8_t (*busy)(void);        /* 4: прыжок в дырку [39E1]; 6: пьёт [44BD] */
    void (*swim)(void);           /* 0x0953: плавание (аквариум) */
    void (*floor_step)(void);     /* 0x3445: следы лап на полу комнаты */
};
uint8_t cat_land(void);           /* 0x1608 */
extern struct scene_hooks hooks;
