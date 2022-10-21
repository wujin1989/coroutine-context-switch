.globl _getcontext
_getcontext:
	movq	%rcx,		0(%rcx)
	movq	%rdx,		8(%rcx)
	movq	%r8,		16(%rcx)
	movq	%r9,		24(%rcx)

	movq	%rdi,		32(%rcx)
	movq	%rsi,		40(%rcx)
	movq	%rbx,		48(%rcx)
	movq	%rbp,		56(%rcx)
	movq	%r10,		64(%rcx)
	movq	%r11,		72(%rcx)
	movq	%r12,		80(%rcx)
	movq	%r13,		88(%rcx)
	movq	%r14,		96(%rcx)
	movq	%r15,		104(%rcx)

	movq	0(%rsp),	%r15
	movq	%r15,		112(%rcx)

	leaq	8(%rsp),	%r15
	movq	%r15,		120(%rcx)

	movq	104(%rcx),	%r15
	ret


.globl _setcontext
_setcontext:
	movq	8(%rcx),	%rdx
	movq	16(%rcx),	%r8
	movq	24(%rcx),	%r9

	movq	32(%rcx),	%rdi
	movq	40(%rcx),	%rsi
	movq	48(%rcx),	%rbx
	movq	56(%rcx),	%rbp
	movq	64(%rcx),	%r10
	movq	72(%rcx),	%r11
	movq	80(%rcx),	%r12
	movq	88(%rcx),	%r13
	movq	96(%rcx),	%r14
	movq	104(%rcx),	%r15

	movq	120(%rcx),	%rsp
	pushq	112(%rcx)

	movq	0(%rcx),	%rcx
	ret


.globl _swapcontext
_swapcontext:
	movq	%rcx,		0(%rcx)
	movq	%rdx,		8(%rcx)
	movq	%r8,		16(%rcx)
	movq	%r9,		24(%rcx)

	movq	%rdi,		32(%rcx)
	movq	%rsi,		40(%rcx)
	movq	%rbx,		48(%rcx)
	movq	%rbp,		56(%rcx)
	movq	%r10,		64(%rcx)
	movq	%r11,		72(%rcx)
	movq	%r12,		80(%rcx)
	movq	%r13,		88(%rcx)
	movq	%r14,		96(%rcx)
	movq	%r15,		104(%rcx)

	movq	0(%rsp),	%r15
	movq	%r15,		112(%rcx)

	leaq	8(%rsp),	%r15
	movq	%r15,		120(%rcx)

	movq	104(%rcx),	%r15


	movq	0(%rdx),	%rcx
	movq	16(%rdx),	%r8
	movq	24(%rdx),	%r9

	movq	32(%rdx),	%rdi
	movq	40(%rdx),	%rsi
	movq	48(%rdx),	%rbx
	movq	56(%rdx),	%rbp
	movq	64(%rdx),	%r10
	movq	72(%rdx),	%r11
	movq	80(%rdx),	%r12
	movq	88(%rdx),	%r13
	movq	96(%rdx),	%r14
	movq	104(%rdx),	%r15

	movq	120(%rdx),	%rsp
	pushq	112(%rdx)

	movq	8(%rdx),	%rdx
	ret


.globl _trampoline
_trampoline:
	movq	%rbx,		%rsp
	movq	0(%rsp),	%rcx
	testq	%rcx,		%rcx
	je	__exit
	call	_setcontext
__exit:
	movq	$0,			%rcx
	call	exit
