	.text
	.globl _main, ___main, _start, ___bss_start, ___bss_end
_start:
	mov	$01000, sp
	mov	$01330, @$0177664	/ стандартное смещение экрана
	mov	$_start, @$04		/ «СТОП» — перезапуск
	mov	$___bss_start, r0
1:	cmp	r0, $___bss_end
	bhis	2f
	clr	(r0)+
	br	1b
2:	jsr	pc, _main
	halt

___main:
	rts	pc
