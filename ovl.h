#pragma once
#include <stdint.h>

/*
 * Сцены — в страницах ДОЗУ СМК-512 (окно 0120000); вход сцены
 * ovl_entry() заполняет таблицу ovl.
 */
enum OVL_ID
{
    OVL_TITLE, OVL_INTER, OVL_ALLEYBG, OVL_ALLEY,
    OVL_ROOM0,      /* + номер комнаты 1..7 */
};

struct ovl_ops
{
    void (*run)(void);    /* основная функция оверлея */
    void (*menu)(void);   /* TITLE: меню (0x5EE5) */
};
extern struct ovl_ops ovl;

void ovl_warm(void);   /* до всего: после «СТОП» вернуть штатный режим СМК */
void ovl_init(void);
void ovl_load(uint8_t id);
void smk_set(uint16_t code);
