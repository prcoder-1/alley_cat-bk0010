/ Графика: вывод в координатах CGA 320x200 на экран БК 256x256 (сжатие 4/5 по X).
/
/ Байт БК j содержит пиксели CGA 5j..5j+3 (каждый пятый пиксель CGA выпадает).
/ Спрайты хранятся в геометрии CGA (байт = 4 пикселя), но в порядке бит БК
/ (пиксель 0 в битах 0-1), поэтому байт БК со сдвигом s пикселей — это
/ младший байт ((b[k] | b[k+1]<<8) >> 2s).
/
/ pos  = строка<<8 | столбец CGA (0..79)
/ size = строк<<8 | ширина в байтах CGA (1..40)
/
/ Вывод строки — один проход: байт источника читается один раз, байт БК
/ собирается в регистре, снятие фона и операция идут сразу в видеопамять.
/ Команды операции вписываются в цикл (слоты S0..S3, SC) при смене режима.
/
/ Против мерцания: gfx_restore откладывается; следующий вывод восстанавливает
/ старые строки вперемежку со своими — строку y прямо перед рисованием строки y.
/ Если объект поднимается (буфер фона тот же), строки идут снизу вверх, чтобы
/ снятие нового фона не затёрло ещё не восстановленный старый.

	.globl _gfx_blit, _gfx_restore, _gfx_save, _gfx_span, _gfx_fillu, _text_glyph, _gfx_flush
	.globl _gfx_scroll16, _tone_sq, _umulhi
	.globl _gfx_j0, _gfx_je, _gfx_rel0, _gfx_ntint, _gfx_mode
	.globl _gfx_j0c, _gfx_jec, _gfx_rel0c, _gfx_init

	VRAM = 040000
	ROW0 = 28			/ 200 строк картинки по центру окна 256
	/ общие для всех страниц, в ОЗУ БК за ядром
	kmask = 036600			/ KEY: маска непрозрачных пикселей, индекс — байт со знаком
	scrbuf = 037000			/ промежуточный буфер фона
	SCR_N = 160

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

/ void gfx_init(void): таблица kmask (один раз, страница с HI включена)
_gfx_init:
	mov	r2, -(sp)
	clr	r0
1:	mov	r0, r1
	asr	r1
	bis	r0, r1
	bic	$0177652, r1		/ & 0x55: ненулевые пиксели
	mov	r1, r2
	asl	r2
	bis	r2, r1
	movb	r0, r2
	movb	r1, kmask(r2)
	inc	r0
	cmp	r0, $256
	bne	1b
	mov	(sp)+, r2
	rts	pc

/ r0 = r1 * r2 (r2 <= 255)
mul:	clr	r0
1:	tst	r2
	beq	9f
	asr	r2
	bcc	2f
	add	r1, r0
2:	asl	r1
	br	1b
9:	rts	pc

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
	jsr	pc, flush
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

/ void gfx_restore(pos, size, const uint8_t *buf): вернуть фон (отложенно, см. выше)
_gfx_restore:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	r5, -(sp)
	jsr	pc, flush
	mov	012(sp), pend_pos
	mov	014(sp), pend_size
	mov	016(sp), pend_buf
	jmp	ret4

/ void gfx_flush(void): выполнить отложенное стирание
_gfx_flush:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	r5, -(sp)
	jsr	pc, flush
	jmp	ret4

flush:
	tst	pend_buf
	beq	9f
	jsr	pc, oldset
	jsr	pc, rsall
9:	rts	pc

/ отложенное стирание -> o_* (сверху вниз); снимает pend_buf; o_left = 0, если не видно
oldset:
	mov	pend_buf, o_buf
	clr	pend_buf
	clr	o_left
	mov	$077777, o_key
	mov	pend_pos, r0
	mov	pend_size, r1
	jsr	pc, geom
	tst	g_nb
	ble	9f
	jsr	pc, masks
	mov	g_addr, o_vram
	mov	g_nb, o_nb
	mov	g_nb, o_db
	mov	g_rows, o_left
	mov	$64, o_dv
	mov	g_mfirst, o_mf
	mov	g_mfirst, o_nmf
	com	o_nmf
	mov	g_mlast, o_ml
	mov	g_mlast, o_nml
	com	o_nml
	clr	r0
	bisb	pend_pos+1, r0
	mov	r0, o_key
9:	rts	pc

rsall:	tst	o_left
	beq	9f
	jsr	pc, rs1
	br	rsall
9:	rts	pc

/ вернуть одну строку старого фона; в крайних байтах — только пиксели внутри
/ прямоугольника CGA (соседние принадлежат другим объектам). r3, r4 не трогает
rs1:	mov	o_buf, r0
	mov	o_vram, r1
	mov	o_nb, r2
	movb	(r0)+, r5
	bic	o_nmf, r5
	bicb	o_mf, (r1)
	bisb	r5, (r1)+
	dec	r2
	beq	3f
	dec	r2
	beq	2f
1:	movb	(r0)+, (r1)+
	sob	r2, 1b
2:	movb	(r0)+, r5
	bic	o_nml, r5
	bicb	o_ml, (r1)
	bisb	r5, (r1)+
3:	add	o_db, o_buf
	add	o_dv, o_vram
	inc	o_key
	dec	o_left
	bne	4f
	mov	$077777, o_key		/ строк больше нет
4:	rts	pc

/ void gfx_scroll16(uint8_t *row, uint16_t left): 16 строк по 64 байта сдвинуть
/ на байт вправо (row[i] = row[i-1]) или влево (row[i] = row[i+1]); край не трогается
_gfx_scroll16:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	r5, -(sp)
	jsr	pc, flush
	mov	012(sp), r3
	mov	$16, r4
	tst	014(sp)
	bne	5f
	add	$64, r3
1:	mov	r3, r0
	mov	r3, r1
	dec	r1
	mov	$9, r2
2:	movb	-(r1), -(r0)
	movb	-(r1), -(r0)
	movb	-(r1), -(r0)
	movb	-(r1), -(r0)
	movb	-(r1), -(r0)
	movb	-(r1), -(r0)
	movb	-(r1), -(r0)
	sob	r2, 2b
	add	$64, r3
	sob	r4, 1b
	jmp	ret4
5:	mov	r3, r0
	mov	r3, r1
	inc	r1
	mov	$9, r2
2:	movb	(r1)+, (r0)+
	movb	(r1)+, (r0)+
	movb	(r1)+, (r0)+
	movb	(r1)+, (r0)+
	movb	(r1)+, (r0)+
	movb	(r1)+, (r0)+
	movb	(r1)+, (r0)+
	sob	r2, 2b
	add	$64, r3
	sob	r4, 5b
	jmp	ret4

/ void gfx_fillu(pos, size, uint8_t pattern): заливка однотонным байтом (все 4 пикселя
/ одного цвета, т.е. образец не зависит от сдвига) — словами
_gfx_fillu:
	mov	r2, -(sp)
	mov	r3, -(sp)
	mov	r4, -(sp)
	mov	r5, -(sp)
	jsr	pc, flush
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
	/ края: образец внутри маски (VRAM = VRAM & ~m | образец & m)
	mov	g_mfirst, r1
	com	r1
	mov	r5, r0
	bic	r1, r0
	mov	r0, f_pf
	mov	g_mlast, r1
	com	r1
	mov	r5, r0
	bic	r1, r0
	mov	r0, f_pl
	mov	g_addr, r3
	mov	g_rows, r0
1:	mov	r3, r1
	mov	g_nb, r2
	bicb	g_mfirst, (r1)
	bisb	f_pf, (r1)+
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
4:	bicb	g_mlast, (r1)
	bisb	f_pl, (r1)+
5:	add	$64, r3
	sob	r0, 1b
	jmp	ret4

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
	mov	012(sp), a_pos
	mov	014(sp), a_size
	mov	016(sp), a_src
	mov	020(sp), a_save
	mov	022(sp), a_mode
	mov	024(sp), a_stride
	mov	a_pos, r0
	mov	a_size, r1
	jsr	pc, geom
	tst	g_nb
	bgt	1f
	jsr	pc, flush
	jmp	ret4
1:	jsr	pc, masks
	jsr	pc, patch
	mov	g_addr, n_vr
	mov	g_nb, n_nb
	mov	g_rows, n_rows
	/ края: исправлять, если маска неполная
	mov	g_mfirst, r0
	mov	r0, n_mf
	mov	r0, n_nmf
	com	n_nmf
	clr	n_fixf
	cmp	r0, $0377
	beq	1f
	inc	n_fixf
1:	mov	g_mlast, r0
	mov	r0, n_ml
	mov	r0, n_nml
	com	n_nml
	clr	n_fixl
	cmp	r0, $0377
	beq	1f
	cmp	g_nb, $1
	beq	1f
	inc	n_fixl
1:	mov	a_stride, r1
	bne	1f
	mov	g_w, r1
1:	cmp	r1, $1			/ 1 = повторять одну строку
	bne	1f
	clr	r1
1:	mov	r1, s_step
	/ начало строки источника: k0 = rel0>>2; вход по фазе rel0&3 (с 2 и 3 —
	/ байт k0 уже в регистре переноса, читать с k0+1)
	mov	g_rel0, r0
	mov	r0, r1
	asr	r1
	asr	r1
	add	a_src, r1
	cmp	g_step, $4
	bne	1f
	mov	$PC_, r2		/ обрезка 1:1: без сдвигов
	br	2f
1:	bic	$0177774, r0
	asl	r0
	mov	ents(r0), r2
	cmp	r0, $4
	blt	2f
	inc	r1
2:	mov	r1, s_row
	mov	r2, entry
	mov	a_save, sv
	clr	sv_adj
	mov	$64, vr_step
	clr	r0
	bisb	a_pos+1, r0
	mov	r0, key			/ номер строки по ходу вывода
	clr	scr_on
	/ отложенное стирание
	clr	o_left
	mov	$077777, o_key
	tst	pend_buf
	bne	1f
	jmp	go
1:	jsr	pc, oldset
	tst	o_left
	beq	1f
	tst	a_save
	bne	2f
1:	jmp	go
2:
	/ пересекаются ли буферы фона: старый [pb, pe), новый [s, se)
	mov	o_nb, r1
	mov	o_left, r2
	jsr	pc, mul
	add	o_buf, r0
	mov	r0, t_pe
	mov	n_nb, r1
	mov	n_rows, r2
	jsr	pc, mul
	mov	r0, t_sz
	add	a_save, r0
	cmp	r0, o_buf
	blos	go
	cmp	a_save, t_pe
	bhis	go
	cmp	a_save, o_buf
	bne	scr
	/ тот же буфер: вниз и не шире — сверху вниз; вверх и не уже — снизу вверх
	cmp	key, o_key
	blt	1f
	cmp	n_nb, o_nb
	blos	go
	cmp	key, o_key
	beq	desc
	br	scr
1:	cmp	n_nb, o_nb
	bhis	desc
scr:	cmp	t_sz, $SCR_N
	bhi	1f
	mov	$scrbuf, sv
	inc	scr_on
	br	go
1:	jsr	pc, rsall		/ не помещается: стереть заранее
	br	go

desc:	mov	n_rows, r2		/ новый — с последней строки
	dec	r2
	mov	r2, -(sp)
	mov	s_step, r1
	jsr	pc, mul
	add	r0, s_row
	neg	s_step
	mov	(sp), r2
	mov	n_nb, r1
	jsr	pc, mul
	add	r0, sv
	mov	(sp)+, r2
	add	r2, key
	neg	key
	jsr	pc, x64
	add	r0, n_vr
	mov	$-64, vr_step
	mov	n_nb, r0
	asl	r0
	neg	r0
	mov	r0, sv_adj
	mov	o_left, r2		/ старый — тоже
	dec	r2
	mov	r2, -(sp)
	mov	o_nb, r1
	jsr	pc, mul
	add	r0, o_buf
	mov	(sp)+, r2
	add	r2, o_key
	neg	o_key
	jsr	pc, x64
	add	r0, o_vram
	mov	$-64, o_dv
	mov	o_nb, o_db
	neg	o_db

go:
row:	mov	key, r3		/ старые строки до текущей включительно
	cmp	r3, o_key
	blt	2f
1:	jsr	pc, rs1
	cmp	r3, o_key
	bge	1b
2:	mov	n_vr, r3
	tst	n_fixf
	beq	1f
	movb	(r3), e0
1:	tst	n_fixl
	beq	1f
	mov	r3, r0
	add	n_nb, r0
	movb	-1(r0), e1
1:	mov	s_row, r1
	mov	sv, r4
	mov	n_nb, r5
	jmp	@entry

/ Строка: r1 — источник, r3 — экран, r4 — фон, r5 — байт БК, r0 — байт,
/ r2 — перенос (байт источника, нужный следующей фазе)
ents:	.word P0, P1, E2, E3
E2:	movb	-1(r1), r2
	swab	r2
	clrb	r2
	br	P2
E3:	movb	-1(r1), r2
	swab	r2
	clrb	r2
	br	P3
P0:	movb	(r1)+, r0		/ B0
S0:	.word 0, 0, 0, 0, 0, 0
	dec	r5
	beq	exit
P1:	clr	r0			/ B1 | B2<<8 >> 2
	bisb	(r1)+, r0
	movb	(r1)+, r2
	swab	r2
	clrb	r2
	bis	r2, r0
	asr	r0
	asr	r0
S1:	.word 0, 0, 0, 0, 0, 0
	dec	r5
	beq	exit
P2:	swab	r2			/ B2 | B3<<8 >> 4
	movb	(r1)+, r0
	swab	r0
	clrb	r0
	bis	r0, r2
	mov	r2, r0
	asr	r0
	asr	r0
	asr	r0
	asr	r0
S2:	.word 0, 0, 0, 0, 0, 0
	dec	r5
	beq	exit
P3:	clrb	r2			/ B3 | B4<<8 >> 6
	swab	r2
	movb	(r1)+, r0
	swab	r0
	clrb	r0
	bis	r2, r0
	asl	r0
	asl	r0
	swab	r0
S3:	.word 0, 0, 0, 0, 0, 0
	dec	r5
	bne	P0
	br	exit
PC_:	movb	(r1)+, r0
SC:	.word 0, 0, 0, 0, 0, 0
	dec	r5
	bne	PC_

exit:	mov	r4, sv
	add	sv_adj, sv
	mov	n_vr, r3		/ края: пиксели вне прямоугольника — прежние
	tst	n_fixf
	beq	1f
	movb	e0, r0
	bic	n_mf, r0
	bicb	n_nmf, (r3)
	bisb	r0, (r3)
1:	tst	n_fixl
	beq	1f
	add	n_nb, r3
	movb	e1, r0
	bic	n_ml, r0
	bicb	n_nml, -(r3)
	bisb	r0, (r3)
1:	add	vr_step, n_vr
	add	s_step, s_row
	inc	key
	dec	n_rows
	beq	1f
	jmp	row
1:	jsr	pc, rsall
	tst	scr_on
	beq	9f
	mov	$scrbuf, r0
	mov	a_save, r1
	mov	t_sz, r2
1:	movb	(r0)+, (r1)+
	sob	r2, 1b
9:	jmp	ret4

/ r0 = r2 * 64
x64:	mov	r2, r0
	asl	r0
	asl	r0
	asl	r0
	asl	r0
	asl	r0
	asl	r0
	rts	pc

/ вписать снятие фона и операцию в слоты (если режим сменился)
patch:	mov	a_mode, r0
	asl	r0
	tst	a_save
	beq	1f
	inc	r0
1:	cmp	r0, cur_key
	bne	1f
	rts	pc
1:	mov	r0, cur_key
	mov	$slots, r5
2:	mov	(r5)+, r1
	bne	3f
	rts	pc
3:	mov	r1, r2
	add	$12, r2			/ конец слота
	tst	a_save
	beq	4f
	mov	$0111324, (r1)+		/ movb (r3),(r4)+
4:	mov	a_mode, r3
	asl	r3
	mov	optpl(r3), r3
	mov	(r3)+, r4
5:	mov	(r3)+, (r1)+
	sob	r4, 5b
	mov	r2, r4
	sub	r1, r4
	beq	2b
	cmp	r4, $2
	bne	6f
	mov	$0240, (r1)		/ nop
	br	2b
6:	asr	r4			/ br на конец слота
	dec	r4
	bis	$0400, r4
	mov	r4, (r1)
	br	2b

slots:	.word S0, S1, S2, S3, SC, 0
optpl:	.word t_copy, t_and, t_key, t_or, t_tint
/ операции над r0 в (r3)+: число слов, слова
t_copy:	.word 1, 0110023			/ movb r0,(r3)+
t_and:	.word 2, 0005100, 0140023		/ com r0; bicb r0,(r3)+
t_key:	.word 4, 0110000, 0146013, kmask, 0150023	/ movb r0,r0; bicb kmask(r0),(r3); bisb r0,(r3)+
t_or:	.word 1, 0150023			/ bisb r0,(r3)+
t_tint:	.word 5, 0005100, 0140013, 0043700, _gfx_ntint, 0150023	/ com r0; bicb r0,(r3); bic @#ntint,r0; bisb r0,(r3)+

/ первый байт: внутри при rel0 = -1,-2,-3 старшие 3,2,1 пикселя
lmask:	.byte 0374, 0360, 0300, 0
/ последний байт: внутри 1,2,3 младших пикселя
rmask:	.byte 03, 017, 077, 0

	.data
g_tj0:	.word _gfx_j0
g_tje:	.word _gfx_je
g_trel:	.word _gfx_rel0
g_step:	.word 5
pend_buf: .word 0		/ отложенное стирание: буфер фона (0 — нет)
t_level: .word 0
cur_key: .word -1		/ режим, вписанный в слоты (своя копия в каждой странице)

	.bss
	.even
_gfx_ntint: .space 2		/ ~(образец цвета подкраски)
g_addr:	.space 2
g_nb:	.space 2
g_rows:	.space 2
g_w:	.space 2
g_rel0:	.space 2
g_mfirst: .space 2
g_mlast: .space 2
f_pf:	.space 2
f_pl:	.space 2
pend_pos: .space 2
pend_size: .space 2
a_pos:	.space 2
a_size:	.space 2
a_src:	.space 2
a_save:	.space 2
a_mode:	.space 2
a_stride: .space 2
o_buf:	.space 2
o_vram:	.space 2
o_nb:	.space 2
o_db:	.space 2
o_dv:	.space 2
o_left:	.space 2
o_key:	.space 2
o_mf:	.space 2
o_nmf:	.space 2
o_ml:	.space 2
o_nml:	.space 2
n_vr:	.space 2
n_nb:	.space 2
n_rows:	.space 2
n_mf:	.space 2
n_nmf:	.space 2
n_ml:	.space 2
n_nml:	.space 2
n_fixf:	.space 2
n_fixl:	.space 2
s_row:	.space 2
s_step:	.space 2
entry:	.space 2
sv:	.space 2
sv_adj:	.space 2
vr_step: .space 2
key:	.space 2
scr_on:	.space 2
t_pe:	.space 2
t_sz:	.space 2
e0:	.space 2
e1:	.space 2
