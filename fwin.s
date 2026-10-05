/ Разлёт сердечек у Фелиции (ROOM7): спрайт заранее переводится в байты БК,
/ потом выводится без пересчёта сжатия 4/5 (см. fwin_phase в ovl_room7.c)
	.globl _fw_conv, _fw_key
	.text

	kmask = 037200			/ как в gfx.s: маска непрозрачных пикселей
	VRAM = 040000
	ROW0 = 28

/ void fw_conv(uint8_t *dst, const uint8_t *src, uint16_t size, int16_t rel0, uint16_t nb)
/ Строки спрайта (size = строк<<8 | байт CGA) -> nb байт БК на строку подряд в dst.
/ Те же фазы, что P0..P3 в gfx.s; вне спрайта — нули (при выводе прозрачны).
_fw_conv:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	r5, -(sp)
	mov	012(sp), r3
	mov	014(sp), r4
	mov	016(sp), r0
	movb	r0, r1
	bic	$0177400, r1
	mov	r1, c_w
	clrb	r0
	swab	r0
	mov	r0, c_rows
	add	$line+1, r1		/ поля строки: line[0] и три байта за краем
	clrb	(r1)+
	clrb	(r1)+
	clrb	(r1)
	clrb	line
	mov	020(sp), r0		/ rel0: первый байт k0 = rel0>>2, вход по rel0&3
	mov	r0, r1
	asr	r1
	asr	r1
	add	$line+1, r1
	bic	$0177774, r0
	asl	r0
	mov	c_ents(r0), c_ent
	cmp	r0, $4
	blt	1f
	inc	r1
1:	mov	r1, c_r1
	mov	022(sp), c_nb
c_row:	mov	$line+1, r1
	mov	c_w, r2
1:	movb	(r4)+, (r1)+
	sob	r2, 1b
	mov	c_r1, r1
	mov	c_nb, r5
	jmp	@c_ent

c_ents:	.word C0, C1, D2, D3
D2:	movb	-1(r1), r2
	swab	r2
	clrb	r2
	br	C2
D3:	movb	-1(r1), r2
	swab	r2
	clrb	r2
	br	C3
C0:	movb	(r1)+, (r3)+
	dec	r5
	beq	c_end
C1:	clr	r0
	bisb	(r1)+, r0
	movb	(r1)+, r2
	swab	r2
	clrb	r2
	bis	r2, r0
	asr	r0
	asr	r0
	movb	r0, (r3)+
	dec	r5
	beq	c_end
C2:	swab	r2
	movb	(r1)+, r0
	swab	r0
	clrb	r0
	bis	r0, r2
	mov	r2, r0
	asr	r0
	asr	r0
	asr	r0
	asr	r0
	movb	r0, (r3)+
	dec	r5
	beq	c_end
C3:	clrb	r2
	swab	r2
	movb	(r1)+, r0
	swab	r0
	clrb	r0
	bis	r2, r0
	asl	r0
	asl	r0
	swab	r0
	movb	r0, (r3)+
	dec	r5
	bne	C0
c_end:	dec	c_rows
	bne	c_row
	jmp	f_ret

/ void fw_key(uint16_t pos, const uint8_t *buf, uint16_t size): pos — как у gfx_blit
/ (режим сжатия), size = строк<<8 | nb; цвет 0 прозрачен (как BM_KEY)
_fw_key:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	r5, -(sp)
	mov	012(sp), r0
	mov	r0, r3			/ (строка+ROW0)*64 + VRAM + j0[столбец]
	clrb	r3
	add	$ROW0*256, r3
	clc
	ror	r3
	asr	r3
	add	$VRAM, r3
	bic	$0177400, r0
	movb	_gfx_j0(r0), r0
	bic	$0177400, r0
	add	r0, r3
	mov	014(sp), r1
	mov	016(sp), r5
	movb	r5, r4
	bic	$0177400, r4
	clrb	r5
	swab	r5
1:	mov	r4, r2
2:	movb	(r1)+, r0
	beq	3f
	bicb	kmask(r0), (r3)
	bisb	r0, (r3)
3:	inc	r3
	sob	r2, 2b
	add	$64, r3
	sub	r4, r3
	sob	r5, 1b
f_ret:	mov	(sp)+, r5
	mov	(sp)+, r4
	mov	(sp)+, r3
	mov	(sp)+, r2
	rts	pc

	.bss
	.even
c_w:	.space 2
c_rows:	.space 2
c_ent:	.space 2
c_r1:	.space 2
c_nb:	.space 2
line:	.space 18			/ 0, до 14 байт строки, 3 нуля
