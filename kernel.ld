/* Ядро: грузится с 01000, bss следом (обнуляется в crt0) */
OUTPUT_FORMAT("a.out-pdp11")
ENTRY(_start)
SECTIONS
{
    . = 01000;
    .text : { *(.text) }
    .data : { *(.data) }
    .bss :
    {
        ___bss_start = .;
        *(.bss) *(COMMON)
        . = ALIGN(2);
        ___bss_end = .;
    }
    _kernel_end = .;
}
