/ Полоса верёвки двора (к rope_scroll в alley.c; на ПК — версии на Си там же)
	.globl _rope_push, _rope_edge
	.text

/ uint8_t rope_push(uint8_t *h, const uint8_t *col): столбцы истории h[0..1] по
/ 16 байт сдвинуть (h[1] = h[0]), в h[0] — новый столбец col[4y]; не 0, если в
/ строках 8..15 столбца не небо (вещь 16x16). h[2] не нужен (смещение 7 - o >= 4)
_rope_push:
	mov	r2, -(sp)
	mov	4(sp), r0
	mov	6(sp), r1
	clr	r2
	.rept	8
	movb	(r0), 16(r0)
	movb	(r1), (r0)+
	add	$4, r1
	.endr
	.rept	8
	movb	(r0), 16(r0)
	movb	(r1), (r0)+
	cmpb	(r1), $0125		/ небо: SWAPC(0xAA)
	beq	1f
	inc	r2
1:	add	$4, r1
	.endr
	mov	r2, r0
	mov	(sp)+, r2
	rts	pc

/ void rope_edge(uint8_t *e, const uint8_t *a, const uint8_t *b, uint8_t sh, uint8_t n):
/ e[64y] = (a[y] | b[y] << 8) >> sh, y < n; sh = 0, 2, 4, 6
_rope_edge:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	010(sp), r0
	mov	012(sp), r1
	mov	014(sp), r2
	mov	020(sp), r4
	bic	$0177400, r4
	mov	016(sp), r3
	bic	$0177400, r3
	jmp	@1f(r3)
1:	.word	e0, e2, e4, e6
e0:	movb	(r1)+, (r0)
	add	$64, r0
	sob	r4, e0
	br	9f
e2:	movb	(r2)+, r3
	swab	r3
	clrb	r3
	bisb	(r1)+, r3
	asr	r3
	asr	r3
	movb	r3, (r0)
	add	$64, r0
	sob	r4, e2
	br	9f
e4:	movb	(r2)+, r3
	swab	r3
	clrb	r3
	bisb	(r1)+, r3
	asr	r3
	asr	r3
	asr	r3
	asr	r3
	movb	r3, (r0)
	add	$64, r0
	sob	r4, e4
	br	9f
e6:	movb	(r2)+, r3		/ (w << 2) >> 8
	swab	r3
	clrb	r3
	bisb	(r1)+, r3
	asl	r3
	asl	r3
	swab	r3
	movb	r3, (r0)
	add	$64, r0
	sob	r4, e6
9:	mov	(sp)+, r4
	mov	(sp)+, r3
	mov	(sp)+, r2
	rts	pc
