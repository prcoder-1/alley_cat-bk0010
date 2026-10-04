/ Графика: вывод в координатах CGA 320x200 на экран БК 256x256 (сжатие 4/5 по X).
/
/ Байт БК j содержит пиксели CGA 5j..5j+3 (каждый пятый пиксель CGA выпадает).
/ Спрайты хранятся в геометрии CGA (байт = 4 пикселя), но в порядке бит БК
/ (пиксель 0 в битах 0-1), поэтому байт БК со сдвигом s пикселей — это
/ младший байт ((b[k] | b[k+1]<<8) >> 2s).
/
/ pos  = строка<<8 | столбец CGA (0..79)
/ size = строк<<8 | ширина в байтах CGA (1..40)

	.globl _gfx_blit, _gfx_restore, _gfx_save, _gfx_span, _gfx_fillu, _text_glyph
	.globl _tone_sq, _umulhi
	.globl _gfx_j0, _gfx_je, _gfx_rel0, _gfx_ntint, _gfx_mode
	.globl _gfx_j0c, _gfx_jec, _gfx_rel0c

	VRAM = 040000
	ROW0 = 28			/ 200 строк картинки по центру окна 256

	.text

/ void gfx_mode(uint16_t crop): 0 — сжатие 4/5 (вся ширина CGA), иначе обрезка:
/ видны байты CGA 8..71 (точки 32..287) в масштабе 1:1. Переменные режима — в .data,
/ т.е. своя копия в каждой странице СМК: режим действует только в своей сцене.
_gfx_mode:
	tst	2(sp)
	bne	1f
	mov	$_gfx_j0, g_tj0
	mov	$_gfx_je, g_tje
	mov	$_gfx_rel0, g_trel
	mov	$5, g_step
	rts	pc
1:	mov	$_gfx_j0c, g_tj0
	mov	$_gfx_jec, g_tje
	mov	$_gfx_rel0c, g_trel
	mov	$4, g_step
	rts	pc

/ Геометрия: r0 = pos, r1 = size -> g_addr, g_nb, g_rows, g_w, g_rel0
geom:
	movb	r1, r2
	bic	$0177400, r2		/ W
	mov	r2, g_w
	clrb	r1
	swab	r1
	mov	r1, g_rows
	movb	r0, r3
	bic	$0177400, r3		/ c
	add	r3, r2			/ c+W
	add	g_tje, r2
	movb	(r2), r2
	bic	$0177400, r2
	mov	g_tj0, r4
	add	r3, r4
	movb	(r4), r4
	bic	$0177400, r4		/ j0
	sub	r4, r2
	mov	r2, g_nb
	add	g_trel, r3
	movb	(r3), r2		/ со знаком
	mov	r2, g_rel0
	clrb	r0
	swab	r0			/ строка
	add	$ROW0, r0
	asl	r0
	asl	r0
	asl	r0
	asl	r0
	asl	r0
	asl	r0
	add	$VRAM, r0
	add	r4, r0
	mov	r0, g_addr
	rts	pc

/ Маски крайних байт: g_mfirst, g_mlast — пиксели внутри прямоугольника CGA
masks:
	/ маска первого байта
	mov	$0377, r2
	mov	g_rel0, r0
	bge	1f
	neg	r0
	movb	lmask-1(r0), r2
	bic	$0177400, r2
1:	mov	r2, g_mfirst
	/ маска последнего: rel_last = rel0 + 5(nb-1); внутри 4W - rel_last пикселей
	mov	g_rel0, r0
	mov	g_nb, r1
	dec	r1
	beq	2f
1:	add	g_step, r0
	sob	r1, 1b
2:	mov	g_w, r1
	asl	r1
	asl	r1
	sub	r0, r1
	mov	$0377, r2
	cmp	r1, $4
	bge	1f
	movb	rmask-1(r1), r2
	bic	$0177400, r2
1:	mov	r2, g_mlast
	cmp	g_nb, $1
	bne	1f
	com	r2			/ единственный байт: обе маски
	bic	r2, g_mfirst
1:
	rts	pc

/ uint16_t gfx_span(pos, size): байт БК в строке
_gfx_span:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	r5, -(sp)
	mov	012(sp), r0
	mov	014(sp), r1
	jsr	pc, geom
	mov	g_nb, r0
	bge	1f
	clr	r0
1:	jmp	ret4

/ void gfx_save(pos, size, uint8_t *buf): снять фон (в формате БК)
_gfx_save:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	r5, -(sp)
	mov	012(sp), r0
	mov	014(sp), r1
	jsr	pc, geom
	tst	g_nb
	bgt	1f
	jmp	ret4
1:	mov	016(sp), r4
	mov	g_addr, r3
	mov	g_rows, r5
1:	mov	g_nb, r2
	mov	r3, r1
2:	movb	(r1)+, (r4)+
	sob	r2, 2b
	add	$64, r3
	sob	r5, 1b
	jmp	ret4

/ void gfx_restore(pos, size, const uint8_t *buf): вернуть фон; в крайних байтах —
/ только пиксели внутри прямоугольника CGA (соседние принадлежат другим объектам)
_gfx_restore:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	r5, -(sp)
	mov	012(sp), r0
	mov	014(sp), r1
	jsr	pc, geom
	tst	g_nb
	bgt	1f
	jmp	ret4
1:	jsr	pc, masks
	mov	016(sp), r4
	mov	g_addr, r3
	mov	g_rows, g_left
1:	mov	r3, r1
	mov	g_nb, r2
	mov	g_mfirst, r0
	jsr	pc, mbyte
	dec	r2
	beq	3f
	dec	r2
	beq	2f
4:	movb	(r4)+, (r1)+
	sob	r2, 4b
2:	mov	g_mlast, r0
	jsr	pc, mbyte
3:	add	$64, r3
	dec	g_left
	bne	1b
	jmp	ret4

/ void gfx_fillu(pos, size, uint8_t pattern): заливка однотонным байтом (все 4 пикселя
/ одного цвета, т.е. образец не зависит от сдвига) — словами
_gfx_fillu:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	r5, -(sp)
	mov	012(sp), r0
	mov	014(sp), r1
	jsr	pc, geom
	tst	g_nb
	bgt	1f
	jmp	ret4
1:	jsr	pc, masks
	movb	016(sp), r5
	bic	$0177400, r5
	mov	r5, r0
	swab	r0
	bis	r0, r5
	mov	g_addr, r3
	mov	g_rows, g_left
1:	mov	r3, r1
	mov	g_nb, r2
	mov	g_mfirst, r0
	jsr	pc, fmbyte
	dec	r2
	beq	5f
	dec	r2
	beq	4f
	bit	$1, r1
	beq	2f
	movb	r5, (r1)+
	dec	r2
	beq	4f
2:	mov	r2, r4
	asr	r4
	beq	3f
6:	mov	r5, (r1)+
	sob	r4, 6b
3:	bit	$1, r2
	beq	4f
	movb	r5, (r1)+
4:	mov	g_mlast, r0
	jsr	pc, fmbyte
5:	add	$64, r3
	dec	g_left
	bne	1b
	jmp	ret4

/ (r1)+ = (VRAM & ~r0) | (r5 & r0)
fmbyte:	mov	r5, r4
	mov	r0, -(sp)
	com	r0
	bic	r0, r4
	movb	(r1), r0
	bic	(sp)+, r0
	bis	r4, r0
	movb	r0, (r1)+
	rts	pc

/ void text_glyph(uint8_t *dst, const uint8_t *glyph, uint16_t nfill):
/ знак шрифта ПЗУ 8x8 (младший бит — левый пиксель) в 2 байта x 8 строк,
/ пиксели цветом ~nfill
_text_glyph:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	010(sp), r1
	mov	012(sp), r2
	mov	014(sp), r4
	mov	$8, r3
1:	movb	(r2)+, r0
	mov	r0, -(sp)
	bic	$0177760, r0
	movb	spread(r0), r0
	bic	r4, r0
	movb	r0, (r1)
	mov	(sp)+, r0
	asr	r0
	asr	r0
	asr	r0
	asr	r0
	bic	$0177760, r0
	movb	spread(r0), r0
	bic	r4, r0
	movb	r0, 1(r1)
	add	$64, r1
	sob	r3, 1b
	mov	(sp)+, r4
	mov	(sp)+, r3
	mov	(sp)+, r2
	rts	pc

spread:	.byte 0, 03, 014, 017, 060, 063, 074, 077
	.byte 0300, 0303, 0314, 0317, 0360, 0363, 0374, 0377

/ void tone_sq(uint16_t hp, uint16_t counts): меандр, полупериод — hp витков sob
/ (исполняется из ОЗУ СМК, где нет тактов ожидания, поэтому высота стабильна);
/ длится counts отсчётов таймера БК. hp = 0 — тишина той же длительности.
_tone_sq:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	010(sp), r1
	mov	012(sp), r2
	mov	@$0177710, r3
	tst	r1
	bne	2f
1:	mov	r3, r0
	sub	@$0177710, r0
	cmp	r0, r2
	blo	1b
	br	9f
2:	mov	t_level, r4
3:	mov	r4, @$0177716
	neg	r4
	add	$0100, r4		/ 0 <-> 0100
	mov	r1, r0
4:	sob	r0, 4b
	mov	r3, r0
	sub	@$0177710, r0
	cmp	r0, r2
	blo	3b
	mov	r4, t_level
9:	mov	(sp)+, r4
	mov	(sp)+, r3
	mov	(sp)+, r2
	rts	pc

/ uint16_t umulhi(uint16_t a, uint16_t b): старшее слово произведения
_umulhi:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	010(sp), r2
	mov	012(sp), r3
	clr	r0
	clr	r1
	mov	$020, r4
1:	asl	r1
	rol	r0
	asl	r3
	bcc	2f
	add	r2, r1
	adc	r0
2:	sob	r4, 1b
	mov	(sp)+, r4
	mov	(sp)+, r3
	mov	(sp)+, r2
	rts	pc

ret4:
	mov	(sp)+, r5
	mov	(sp)+, r4
	mov	(sp)+, r3
	mov	(sp)+, r2
	rts	pc

/ void gfx_blit(pos, size, const uint8_t *src, uint8_t *save, uint16_t mode, uint16_t stride)
/   mode: 0 копия (пиксели за краями спрайта не трогаются), 1 AND,
/         2 цвет 0 прозрачен, 3 OR, 4 AND с подкраской чёрного (_gfx_ntint)
/   save: если не 0 — сюда снимается фон до вывода (формат БК)
/   stride: шаг строк источника, 0 = ширина, 1 = одна строка на все
_gfx_blit:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	r5, -(sp)
	mov	012(sp), r0
	mov	014(sp), r1
	jsr	pc, geom
	tst	g_nb
	bgt	1f
	jmp	ret4
1:	mov	016(sp), g_src
	mov	020(sp), g_save
	mov	022(sp), r0
	asl	r0
	mov	ops(r0), g_op
	mov	024(sp), r1
	bne	1f
	mov	g_w, r1
1:	cmp	r1, $1			/ 1 = повторять одну строку
	bne	1f
	clr	r1
1:	mov	r1, g_stride
	clr	g_fill
	cmp	r0, $2			/ AND: заполнитель = все единицы
	beq	2f
	cmp	r0, $8			/ AND с подкраской — тоже
	bne	1f
2:	mov	$-1, g_fill
1:
	/ начало в буфере строки: pbuf[0] — заполнитель (k = -1)
	mov	g_rel0, r0		/ kptr = pbuf+1 + rel0>>2, вход = rel0 & 3
	mov	r0, r1
	asr	r1
	asr	r1
	add	$pbuf+1, r1
	mov	r1, g_kptr
	bic	$0177774, r0
	asl	r0
	mov	blk(r0), g_entry
	cmp	g_step, $4		/ обрезка: сдвигов нет, строка копируется как есть
	bne	1f
	mov	$bcopy, g_entry
1:
	jsr	pc, masks
	mov	g_addr, r3
	mov	g_rows, g_left
	clr	g_conv

row:
	tst	g_conv			/ повтор одной строки: tbuf уже готов
	beq	1f
	jmp	cvdone
1:
	/ строка источника -> pbuf[1..W]
	mov	g_src, r0
	mov	$pbuf, r1
	movb	g_fill, (r1)+
	mov	g_w, r2
1:	movb	(r0)+, (r1)+
	sob	r2, 1b
	movb	g_fill, (r1)+
	movb	g_fill, (r1)+
	mov	g_src, r0
	add	g_stride, r0
	mov	r0, g_src
	/ преобразование -> tbuf
	mov	g_kptr, r1
	mov	$tbuf, r4
	mov	g_nb, r5
	jmp	@g_entry

b0:	movb	(r1)+, (r4)+
	dec	r5
	bne	b1
	br	cvdone
b1:	movb	(r1)+, r0
	bic	$0177400, r0
	movb	(r1), r2
	swab	r2
	clrb	r2
	bis	r2, r0
	asr	r0
	asr	r0
	movb	r0, (r4)+
	dec	r5
	bne	b2
	br	cvdone
b2:	movb	(r1)+, r0
	bic	$0177400, r0
	movb	(r1), r2
	swab	r2
	clrb	r2
	bis	r2, r0
	asr	r0
	asr	r0
	asr	r0
	asr	r0
	movb	r0, (r4)+
	dec	r5
	bne	b3
	br	cvdone
b3:	movb	(r1)+, r0
	bic	$0177400, r0
	movb	(r1)+, r2
	swab	r2
	clrb	r2
	bis	r2, r0
	asl	r0
	asl	r0
	swab	r0
	movb	r0, (r4)+
	sob	r5, b0
cvdone:
	tst	g_stride
	bne	1f
	inc	g_conv
1:
	/ снять фон
	mov	g_save, r4
	beq	1f
	mov	r3, r1
	mov	g_nb, r2
2:	movb	(r1)+, (r4)+
	sob	r2, 2b
	mov	r4, g_save
1:	mov	$tbuf, r4
	mov	r3, r1
	mov	g_nb, r2
	jmp	@g_op

/ копия: VRAM = (VRAM & ~m) | (v & m), m = 377 внутри
opcopy:
	mov	g_mfirst, r0
	jsr	pc, mbyte
	dec	r2
	beq	9f
	dec	r2
	beq	3f
2:	movb	(r4)+, (r1)+
	sob	r2, 2b
3:	mov	g_mlast, r0
	jsr	pc, mbyte
	br	9f

mbyte:	movb	(r4)+, r5
	mov	r0, -(sp)
	com	r0
	bic	r0, r5			/ v & m
	movb	(r1), r0
	bic	(sp)+, r0		/ VRAM & ~m
	bis	r5, r0
	movb	r0, (r1)+
	rts	pc

opand:
1:	movb	(r4)+, r0
	com	r0
	bicb	r0, (r1)+
	sob	r2, 1b
	br	9f

opkey:
1:	movb	(r4)+, r0
	mov	r0, r5
	asr	r5
	bis	r0, r5
	bic	$0177652, r5		/ & 0x55: ненулевые пиксели
	mov	r5, -(sp)
	asl	r5
	bis	(sp)+, r5
	bicb	r5, (r1)
	bisb	r0, (r1)+
	sob	r2, 1b
	br	9f

opor:
1:	bisb	(r4)+, (r1)+
	sob	r2, 1b
	br	9f

/ AND с подкраской: чёрные пиксели спрайта рисуются цветом _gfx_tint
optint:
1:	movb	(r4)+, r0
	com	r0			/ ~s: пиксели спрайта
	bicb	r0, (r1)		/ фон & s
	bic	_gfx_ntint, r0		/ ~s & T
	bisb	r0, (r1)+
	sob	r2, 1b

9:	add	$64, r3
	dec	g_left
	beq	1f
	jmp	row
1:	jmp	ret4

/ обрезка 1:1: строка без сдвига
bcopy:	movb	(r1)+, (r4)+
	sob	r5, bcopy
	jmp	cvdone

ops:	.word opcopy, opand, opkey, opor, optint
blk:	.word b0, b1, b2, b3
/ первый байт: внутри при rel0 = -1,-2,-3 старшие 3,2,1 пикселя
lmask:	.byte 0374, 0360, 0300, 0
/ последний байт: внутри 1,2,3 младших пикселя
rmask:	.byte 03, 017, 077, 0

	.data
g_tj0:	.word _gfx_j0
g_tje:	.word _gfx_je
g_trel:	.word _gfx_rel0
g_step:	.word 5
t_level: .word 0

	.bss
	.even
_gfx_ntint: .space 2		/ ~(образец цвета подкраски)
g_addr:	.space 2
g_nb:	.space 2
g_rows:	.space 2
g_left:	.space 2
g_w:	.space 2
g_rel0:	.space 2
g_src:	.space 2
g_save:	.space 2
g_op:	.space 2
g_stride:	.space 2
g_fill:	.space 2
g_conv:	.space 2
g_kptr:	.space 2
g_entry:	.space 2
g_mfirst:	.space 2
g_mlast:	.space 2
pbuf:	.space 84
tbuf:	.space 66
