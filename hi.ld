/* Блиттер и константы ядра в окне СМК: копия в каждой странице; bss — только рабочие буферы */
OUTPUT_FORMAT("a.out-pdp11")
SECTIONS
{
    . = 0145000;
    .text : { *(.text) }
    .data : { *(.data) }
    .bss : { *(.bss) *(COMMON) . = ALIGN(2); }
}
