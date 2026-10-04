/ Вспомогательные подпрограммы для кода gcc и ГСЧ оригинала
	.globl ___xorhi3, _rand16, _rand_seed, _rand_state
	.text

/ int __xorhi3(int a, int b)
___xorhi3:
	mov	2(sp), r0
	mov	4(sp), r1
	xor	r1, r0
	rts	pc

/ 0x2DFD: бит 1 от (lo ^ hi) вдвигается в бит 15 (rcr word)
_rand16:
	mov	_rand_state, r0
	mov	r0, r1
	swab	r1
	xor	r1, r0
	asr	r0
	asr	r0
	ror	_rand_state
	mov	_rand_state, r0
	rts	pc

/ 0x2E10
_rand_seed:
	mov	2(sp), r0
	bne	1f
	mov	$0175131, r0		/ 0xFA59
1:	mov	r0, _rand_state
	rts	pc

	.bss
	.even
_rand_state:	.space 2

/ void smk_set(uint16_t code): режим и страница СМК-512 (строб, код, снятие строба — только MOV)
	.globl _smk_set
	.text
_smk_set:
	mov	2(sp), r0
	mov	$6, @$0177130
	mov	r0, @$0177130
	mov	$0, @$0177130
	rts	pc

/ int __mulhi3(int a, int b): младшее слово произведения сдвигами-сложениями,
/ цикл кончается, когда множитель обнулился (прежняя версия всегда делала
/ 16 витков на стековом кадре и портила знак отрицательного произведения)
	.globl ___mulhi3
___mulhi3:
	mov	2(sp), r0
	mov	4(sp), r1
	cmp	r1, r0
	blos	1f
	mov	r0, r1			/ множитель — меньший
	mov	4(sp), r0
1:	mov	r2, -(sp)
	clr	r2
2:	tst	r1
	beq	4f
	clc
	ror	r1
	bcc	3f
	add	r0, r2
3:	asl	r0
	br	2b
4:	mov	r2, r0
	mov	(sp)+, r2
	rts	pc

/ uint16_t smk_probe(void): код раскладки, в которой запущена программа (060 —
/ Std10, 0160 — SYS, 0140 — Std11, страница 0), или 0, если СМК-512 нет. На
/ живой плате ПЗУ контроллера при включении ставит Std10 на БК-0010 и Std11 на
/ БК-0011М; в SYS оно накрывает и регистры 0177xxx, так что там работать нельзя. Раскладка узнаётся по метке в 0120000:
/ после переключения она видна только в той же раскладке. Страницы 0 и 1 —
/ системные (RAM-BIOS, резидент ДОС): пробные записи — в страницы 2 и 3.
	.globl _smk_probe
	.text
_smk_probe:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mfps	-(sp)
	mtps	$0340
	mov	@$4, -(sp)
	mov	@$6, -(sp)
	mov	sp, r1			/ стек на случай прерывания
	mov	$7f, @$4
	mov	$0340, @$6
	clr	r0
	mov	@$0120000, r2		/ слово в раскладке запуска
	mov	r2, r3
	com	r3			/ метка
	mov	r3, @$0120000
	mov	$6, @$0177130		/ Std10, страница 2
	mov	$064, @$0177130
	mov	$0, @$0177130
	mov	$0125252, @$0120000
	mov	$6, @$0177130		/ Std10, страница 3
	mov	$02064, @$0177130
	mov	$0, @$0177130
	mov	$052525, @$0120000
	mov	$6, @$0177130		/ снова страница 2
	mov	$064, @$0177130
	mov	$0, @$0177130
	cmp	@$0120000, $0125252
	bne	8f			/ страницы не различаются — платы нет
	mov	$6, @$0177130		/ Std10, страница 0?
	mov	$060, @$0177130
	mov	$0, @$0177130
	mov	$060, r0
	cmp	@$0120000, r3
	beq	2f
	mov	$6, @$0177130		/ SYS, страница 0?
	mov	$0160, @$0177130
	mov	$0, @$0177130
	mov	$0160, r0
	cmp	@$0120000, r3
	beq	2f
	mov	$6, @$0177130		/ Std11 (БК-0011М: в 0120000 её собственное ОЗУ)?
	mov	$0140, @$0177130
	mov	$0, @$0177130
	mov	$0140, r0
	cmp	@$0120000, r3
	beq	2f
	mov	$6, @$0177130		/ не нашлась: Std10, страница 0
	mov	$060, @$0177130
	mov	$0, @$0177130
	mov	$060, r0
	br	9f
2:	mov	r2, @$0120000		/ вернуть слово
	br	9f
8:	mov	r2, @$0120000		/ платы нет: слово — на место
	clr	r0
9:	mov	(sp)+, @$6
	mov	(sp)+, @$4
	mtps	(sp)+
	mov	(sp)+, r3
	mov	(sp)+, r2
	rts	pc
7:	mov	r1, sp			/ платы нет: снять кадр прерывания
	clr	r0
	br	9b

/ uint16_t tmr_elapsed(void): обновить счёт времени, вернуть прошедшие отсчёты
/ таймера БК (3 МГц / 128). Тики BIOS PC — в четвертях отсчёта (5149 на тик),
/ кадры CGA 1/60 с — в восьмых (3125 на кадр), проходы цикла PC — в отсчётах.
	.globl _tmr_elapsed, _tmr_prev, _tick_acc, _tick_cnt, _pass_acc, _rt_ph8, _rt_frame
_tmr_elapsed:
	mov	@$0177710, r1
	mov	_tmr_prev, r0
	mov	r1, _tmr_prev
	sub	r1, r0			/ d = prev - cur
	cmp	r0, $15000		/ после долгой паузы (загрузка) — не копить
	blos	1f
	mov	$15000, r0
1:	add	r0, _pass_acc
	mov	r0, r1
	asl	r1
	asl	r1
	add	_tick_acc, r1
2:	cmp	r1, $5149
	blo	3f
	sub	$5149, r1
	inc	_tick_cnt
	br	2b
3:	mov	r1, _tick_acc
	mov	r0, r1
	cmp	r1, $2048
	bhis	6f
4:	asl	r1
	asl	r1
	asl	r1
	add	_rt_ph8, r1
5:	cmp	r1, $3125
	blo	7f
	sub	$3125, r1
	inc	_rt_frame
	br	5b
7:	mov	r1, _rt_ph8
	rts	pc
6:	sub	$2048, r1		/ по 2048 отсчётов, чтобы восьмые не переполнились
	add	$16384, _rt_ph8
8:	cmp	_rt_ph8, $3125
	blo	9f
	sub	$3125, _rt_ph8
	inc	_rt_frame
	br	8b
9:	cmp	r1, $2048
	bhis	6b
	br	4b

	.bss
	.even
_tmr_prev:	.space 2
_tick_acc:	.space 2
_tick_cnt:	.space 2
_pass_acc:	.space 2
_rt_ph8:	.space 2
_rt_frame:	.space 2
	.text

/ void tile8x2(uint8_t *dst, const uint8_t *src, uint16_t stride): плитка
/ 8 строк x 2 байта (подряд в src) в буфер со строками по stride байт
	.globl _tile8x2
_tile8x2:
	mov	r2, -(sp)
	mov	4(sp), r0
	mov	6(sp), r1
	mov	010(sp), r2
	dec	r2
	.rept	8
	movb	(r1)+, (r0)+
	movb	(r1)+, (r0)
	add	r2, r0
	.endr
	mov	(sp)+, r2
	rts	pc
