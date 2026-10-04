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
