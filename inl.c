/* Внешние определения inline-функций заголовков (C99: inline без extern не порождает символ) */
#include "tools.h"
#include "emt.h"
extern inline void set_PSW(uint16_t psw);
extern inline void EMT_36(const char *ptr);
