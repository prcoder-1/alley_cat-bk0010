/*
 * Сцены в ДОЗУ СМК-512: у каждой своя страница (режим Std10, окно
 * 0120000..0157777). При запуске в каждую страницу грузятся (EMT 36)
 * файл сцены с 0120000 и общий блок HI (блиттер, константы ядра) с 0146000.
 * Первое слово сцены — её вход ovl_entry().
 */
#include "ovl.h"
#include "emt.h"
#include "game.h"

struct ovl_ops ovl;

#define OVL_ADDR ((uint8_t *)0120000)
#define HI_ADDR  ((uint8_t *)0146000)
#define SMK_STD10 060

static const char *const names[] =
{
    "TITLE", "INTER", "ALLEYBG", "ALLEY",
    0, "ROOM1", "ROOM2", "ROOM3", "ROOM4", "ROOM5", "ROOM6", "ROOM7",
};

/* коды страниц 0..15 в регистре 0177130 */
static const uint16_t page_code[] =
{
    0, 02000, 04, 02004, 010, 02010, 014, 02014,
    01, 02001, 05, 02005, 011, 02011, 015, 02015,
};

static struct EMT_36_PARAMS pb;

static void smk_page(uint8_t n)
{
    smk_set((uint16_t)(SMK_STD10 | page_code[n]));
}

static uint8_t load(const char *n, uint8_t *addr)
{
    pb.COMMAND = EMT_36_FILE_READ;
    pb.DATA_PTR = addr;
    pb.SIZE = 0;
    for (uint8_t i = 0; i < 16; ++i)
    {
        char c = *n;
        pb.NAME[i] = c ? c : ' ';
        if (c) ++n;
    }
    EMT_36((const char *)&pb);
    return pb.RESPONSE;
}

static void fail(const char *msg)
{
    text_at(100, 2, msg, 3);
    for (;;) ;
}

void ovl_init(void)
{
    if (*(volatile uint16_t *)0167776 < 0176200) fail("NEED SMK-512");
    for (uint8_t id = 0; id < sizeof names / sizeof names[0]; ++id)
    {
        if (!names[id]) continue;
        smk_page(id);
        if (load("HI", HI_ADDR) | load(names[id], OVL_ADDR)) fail(names[id]);
    }
}

void ovl_load(uint8_t id)
{
    smk_page(id);
    ((void (*)(void))OVL_ADDR)();
}
