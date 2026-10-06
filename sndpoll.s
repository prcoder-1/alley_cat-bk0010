/ void snd_poll(void): тон во время работы цикла. У БК нет генератора тона,
/ поэтому текущий тон (tone_div) звучит, только пока его играет процессор.
/ Блиттер между строками зовёт этот опрос (вектор _gfx_poll в HI), цикл сцены —
/ между этапами: после 4 длин куска работы вставляется кусок тона (не короче
/ 3 периодов и 20 отсчётов таймера). Все регистры сохраняются.
	.globl _snd_poll, _snd_poll_init, _snd_pass, _snd_pass_idle, _tone_div, _tone_sq, _umulhi, _snd_idle
	PASS_MAX = 1100			/ проход не длиннее тика (1287 отсчётов) с запасом
	.text
_snd_poll:
	cmp	pl_due, @$0177710	/ таймер считает вниз: срок, когда счёт <= pl_due
	bmi	9f			/ знак разности по модулю 2^16 (не blt: переполнение)
	tst	_tone_div
	bne	4f
	mov	@$0177710, pl_due	/ тишина: срок не должен устаревать (сравнение по кругу)
	rts	pc
4:	mov	r0, -(sp)
	mov	r1, -(sp)
	cmp	_tone_div, pl_div
	beq	1f
	mov	_tone_div, r1
	mov	r1, pl_div
	mov	r1, r0			/ кусок: 3 периода = div / 17 отсчётов
	clrb	r0
	swab	r0
	asr	r1
	asr	r1
	asr	r1
	asr	r1
	sub	r0, r1
	cmp	r1, $20
	bhis	2f
	mov	$20, r1
2:	mov	r1, pl_len
	asl	r1
	asl	r1
	mov	r1, pl_gap
	mov	$5511, -(sp)		/ полупериод как в snd.c (half_period)
	mov	pl_div, -(sp)
	jsr	pc, _umulhi
	cmp	(sp)+, (sp)+
	sub	$9, r0
	bhi	3f
	mov	$1, r0
3:	mov	r0, pl_hp
1:	mov	pl_len, -(sp)
	mov	pl_hp, -(sp)
	jsr	pc, _tone_sq
	cmp	(sp)+, (sp)+
	mov	@$0177710, r0
	sub	pl_gap, r0
	mov	r0, pl_due
	mov	(sp)+, r1
	mov	(sp)+, r0
9:	rts	pc

/ void snd_poll_init(void): срок — сейчас (после смены сцены pl_due устарел)
_snd_poll_init:
	mov	@$0177710, pl_due
	rts	pc

/ void snd_pass(void): начало прохода цикла сцены
_snd_pass:
	mov	@$0177710, ps_t0
	rts	pc

/ void snd_pass_idle(void): тон в простое (snd_idle) добивает проход до PASS_MAX,
/ но не больше 4*48 отсчётов: тяжёлый проход (драка) не растягивается за тик —
/ тон в нём даёт snd_poll
_snd_pass_idle:
	mov	ps_t0, r0
	sub	@$0177710, r0		/ прошло с начала прохода
	sub	$PASS_MAX, r0
	bhis	9f
	neg	r0
	asr	r0
	asr	r0
	cmp	r0, $48
	blos	1f
	mov	$48, r0
1:	mov	r0, -(sp)
	jsr	pc, _snd_idle
	tst	(sp)+
9:	rts	pc

	.data
pl_due:	.word 0
pl_div:	.word 0
pl_hp:	.word 0
pl_len:	.word 0
pl_gap:	.word 0
ps_t0:	.word 0
