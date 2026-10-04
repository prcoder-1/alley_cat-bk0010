/* Заглушки ядра для теста комнат (то, что в игре живёт в main.c, ovl.c, score.c, text.c) */
#include <stdint.h>
struct ovl_ops { void (*run)(void); void (*menu)(void); } ovl;
void transition(void) {}
void wipe(uint8_t p) { (void)p; }
void game_pause(void) {}
void text_at(uint8_t y, uint8_t c, const char *s, uint8_t col) { (void)y; (void)c; (void)s; (void)col; }
void smk_set(uint16_t c) { (void)c; }
uint16_t g_alley_t, g_felicia_t, g_felicia_n;
uint8_t g_back;
