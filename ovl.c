/*
 * Сцены в ДОЗУ СМК-512: у каждой своя страница (режим Std10, окно
 * 0120000..0157777): файл сцены с 0120000 и общий блок HI (блиттер,
 * константы ядра) с 0144000. Первое слово сцены — её вход ovl_entry().
 *
 * Файлы читаются EMT 36 в раскладке, в которой запущена игра (на живой
 * плате — Std10, страница 0; под ДОС там её резидент с обработчиком EMT 36).
 * Поэтому файл сначала грузится в видеопамять, а в страницу сцены копируется.
 * Страницы 0 и 1 — системные: сцены занимают страницы 2..13.
 */
#include "ovl.h"
#include "emt.h"
#include "game.h"
#include "hw.h"
#include "gfx.h"

struct ovl_ops ovl;

#define OVL_ADDR ((uint8_t *)0120000)
#define HI_ADDR  ((uint8_t *)0144000)
#define OVL_SIZE (0144000 - 0120000)
#define HI_SIZE  (0160000 - 0144000)
#define HI_BUF   ((uint8_t *)040000)              /* буферы — в видеопамяти */
#define OVL_BUF  ((uint8_t *)(040000 + HI_SIZE))   /* до 0100000 ровно */
#define SMK_STD10 060
#define PAGE0     2                               /* первая страница сцен */

static uint16_t smk_home;   /* раскладка при запуске (код для 0177130) */
/* в .data: crt0 его не обнуляет, и после «СТОП» (перезапуск через вектор 4)
 * сцены уже лежат в страницах — повторно не грузятся */
static uint16_t cold = 1;
static uint16_t page_on;   /* включена страница сцены (в ней блиттер) */

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

uint16_t smk_probe(void);   /* helpers.s */

static struct EMT_36_PARAMS pb __attribute__((aligned(2)));

static void smk_page(uint8_t n)
{
    smk_set((uint16_t)(SMK_STD10 | page_code[n + PAGE0]));
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

/* сообщение и стоп; только средствами ядра: блиттер (HI) ещё не загружен */
extern const uint8_t font[];   /* font.s */

static void fail(const char *msg)
{
    static const uint8_t spread[16] =
    {
        0, 03, 014, 017, 060, 063, 074, 077, 0300, 0303, 0314, 0317, 0360, 0363, 0374, 0377,
    };
    vram_clear();   /* буфер загрузки в видеопамяти */
    volatile uint8_t *p = (volatile uint8_t *)VRAM_ADDR(100) + 4;
    for (; *msg; ++msg, p += 2)
    {
        uint8_t c = (uint8_t)*msg;
        if (c < 040 || c > 0137) c = ' ';
        const uint8_t *g = font + ((uint16_t)(c - 040) << 3);
        volatile uint8_t *d = p;
        for (uint8_t r = 0; r < 8; ++r, d += 64)
        {
            d[0] = spread[g[r] & 15];
            d[1] = spread[g[r] >> 4];
        }
    }
    for (;;) ;
}

static void copy(uint8_t *dst, const uint8_t *src, uint16_t n)
{
    uint16_t *d = (uint16_t *)dst;
    const uint16_t *s = (const uint16_t *)src;
    for (n >>= 1; n; --n) *d++ = *s++;
}

/* «СТОП» ставит СМК в SYS, где ПЗУ платы закрывает и регистры БК: при
 * повторном запуске сразу вернуть штатный режим */
void ovl_warm(void)
{
    page_on = 0;   /* лежит в .data — crt0 не обнуляет */
    if (!cold) smk_set(SMK_STD10);
}

void ovl_init(void)
{
    if (!cold) return;
    /* наличие платы — пробой страниц, а не словом 0167776: в эмуляторе с КНГМД
     * там ПЗУ дисковода */
    smk_home = smk_probe();
    if (!smk_home) fail("NEED SMK-512");
    /* слово модели в ПЗУ платы: 176000/176400/177000 — 64/128/256 Кбайт, там
     * страницы 2..13 легли бы на 0..1 и друг на друга */
    uint16_t model = *(volatile uint16_t *)0167776 & 0177400;
    if (model >= 0176000 && model <= 0177000) fail("NEED SMK-512 (512K)");
    for (uint8_t id = 0; id < sizeof names / sizeof names[0]; ++id)
    {
        smk_page(id);
        *(volatile uint16_t *)OVL_ADDR = (uint16_t)(0x5A00 | id);
    }
    for (uint8_t id = 0; id < sizeof names / sizeof names[0]; ++id)
    {
        smk_page(id);
        if (*(volatile uint16_t *)OVL_ADDR != (uint16_t)(0x5A00 | id))
        {
            smk_set(smk_home);
            fail("NEED SMK-512 (512K)");
        }
    }
    smk_set(smk_home);
    if (load("HI", HI_BUF)) fail("HI");
    for (uint8_t id = 0; id < sizeof names / sizeof names[0]; ++id)
    {
        if (!names[id]) continue;
        if (load(names[id], OVL_BUF)) fail(names[id]);
        smk_page(id);
        copy(HI_ADDR, HI_BUF, HI_SIZE);
        copy(OVL_ADDR, OVL_BUF, OVL_SIZE);
        smk_set(smk_home);
    }
    cold = 0;
    vram_clear();
}

void ovl_load(uint8_t id)
{
    if (page_on) gfx_flush();
    gfx_regions_reset();
    smk_page(id);
    if (!page_on)
    {
        page_on = 1;
        gfx_init();
    }
    ((void (*)(void))OVL_ADDR)();
}
