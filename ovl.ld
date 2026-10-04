/* Оверлей: адрес задаётся ключом --defsym=OVL=...; bss входит в файл */
OUTPUT_FORMAT("a.out-pdp11")
ENTRY(_ovl_entry)
SECTIONS
{
    . = OVL;
    .text : { *(.text) }
    .data : { *(.data) *(.bss) *(COMMON) . = ALIGN(2); }
}
