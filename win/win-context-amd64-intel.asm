.code

extrn	exit:proc

_getcontext proc
	mov [rcx],			rcx
	mov [rcx + 8],		rdx
	mov [rcx + 16],		r8
	mov [rcx + 24],		r9

	mov	[rcx + 32],		rdi
	mov	[rcx + 40],		rsi
	mov	[rcx + 48],		rbx
	mov	[rcx + 56],		rbp
	mov	[rcx + 64],		r10
	mov	[rcx + 72],		r11
	mov	[rcx + 80],		r12
	mov	[rcx + 88],		r13
	mov	[rcx + 96],		r14
	mov	[rcx + 104],	r15

	mov	r15,			[rsp]
	mov	[rcx + 112],	r15

	lea	r15,			[rsp + 8]
	mov	[rcx + 120],	r15

	mov	r15,			[rcx + 104]
	ret
_getcontext endp

_setcontext	proc
	mov	rdx,		[rcx + 8]
	mov	r8,			[rcx + 16]
	mov	r9,			[rcx + 24]

	mov	rdi,		[rcx + 32]
	mov	rsi,		[rcx + 40]
	mov	rbx,		[rcx + 48]
	mov	rbp,		[rcx + 56]
	mov	r10,		[rcx + 64]
	mov	r11,		[rcx + 72]
	mov	r12,		[rcx + 80]
	mov	r13,		[rcx + 88]
	mov	r14,		[rcx + 96]
	mov	r15,		[rcx + 104]

	mov	rsp,		[rcx + 120]
	push			[rcx + 112]

	mov	rcx,		[rcx]
	ret
_setcontext endp	

_swapcontext proc
	mov [rcx],			rcx
	mov [rcx + 8],		rdx
	mov [rcx + 16],		r8
	mov [rcx + 24],		r9

	mov	[rcx + 32],		rdi
	mov	[rcx + 40],		rsi
	mov	[rcx + 48],		rbx
	mov	[rcx + 56],		rbp
	mov	[rcx + 64],		r10
	mov	[rcx + 72],		r11
	mov	[rcx + 80],		r12
	mov	[rcx + 88],		r13
	mov	[rcx + 96],		r14
	mov	[rcx + 104],	r15

	mov	r15,			[rsp]
	mov	[rcx + 112],	r15

	lea	r15,			[rsp + 8]
	mov	[rcx + 120],	r15

	mov	r15,			[rcx + 104]


	mov	rcx,			[rdx]
	mov	r8,				[rdx + 16]
	mov	r9,				[rdx + 24]

	mov	rdi,			[rdx + 32]
	mov	rsi,			[rdx + 40]
	mov	rbx,			[rdx + 48]
	mov	rbp,			[rdx + 56]
	mov	r10,			[rdx + 64]
	mov	r11,			[rdx + 72]
	mov	r12,			[rdx + 80]
	mov	r13,			[rdx + 88]
	mov	r14,			[rdx + 96]
	mov	r15,			[rdx + 104]

	mov	rsp,			[rdx + 120]
	push				[rdx + 112]

	mov	rdx,			[rdx + 8]
	ret
_swapcontext endp

_trampoline	proc
	mov		rsp,	rbx
	mov		rcx,	[rsp]
	test	rcx,	rcx
	je	__exit
	call	_setcontext
__exit:
	mov	rcx,		0
	call	exit
_trampoline	endp

end