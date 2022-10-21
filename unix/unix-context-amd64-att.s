.globl _getcontext
_getcontext:
	movq	%rdi,		0(%rdi)
	movq	%rsi,		8(%rdi)
	movq	%rdx,		16(%rdi)
	movq	%rcx,		24(%rdi)
	movq	%r8,		32(%rdi)
	movq	%r9,		40(%rdi)
		
	movq	%rbx,		48(%rdi)
	movq	%rbp,		56(%rdi)
	movq	%r10,		64(%rdi)
	movq	%r11,		72(%rdi)
	movq	%r12,		80(%rdi)
	movq	%r13,		88(%rdi)
	movq	%r14,		96(%rdi)
	movq	%r15,		104(%rdi)
		
	movq	(%rsp),		%rcx
	movq	%rcx,		112(%rdi)

	leaq	8(%rsp),	%rcx
	movq	%rcx,		120(%rdi)

	movq	24(%rdi),	%rcx
	ret


.globl _setcontext
_setcontext:
	movq	8(%rdi),	%rsi
	movq	16(%rdi),	%rdx
	movq	24(%rdi),	%rcx
	movq	32(%rdi),	%r8
	movq	40(%rdi),	%r9
		
	movq	48(%rdi),	%rbx
	movq	56(%rdi),	%rbp
	movq	64(%rdi),	%r10
	movq	72(%rdi),	%r11
	movq	80(%rdi),	%r12
	movq	88(%rdi),	%r13
	movq	96(%rdi),	%r14
	movq	104(%rdi),	%r15
		
	movq	120(%rdi),	%rsp
	pushq	112(%rdi)

	movq	0(%rdi),	%rdi
	ret


.globl _swapcontext
_swapcontext:
	movq	%rdi,		0(%rdi)
	movq	%rsi,		8(%rdi)
	movq	%rdx,		16(%rdi)
	movq	%rcx,		24(%rdi)
	movq	%r8,		32(%rdi)
	movq	%r9,		40(%rdi)
		
	movq	%rbx,		48(%rdi)
	movq	%rbp,		56(%rdi)
	movq	%r10,		64(%rdi)
	movq	%r11,		72(%rdi)
	movq	%r12,		80(%rdi)
	movq	%r13,		88(%rdi)
	movq	%r14,		96(%rdi)
	movq	%r15,		104(%rdi)
		
	movq	(%rsp),		%rcx
	movq	%rcx,		112(%rdi)

	leaq	8(%rsp),	%rcx
	movq	%rcx,		120(%rdi)

	movq	24(%rdi),	%rcx


	movq	0(%rsi),	%rdi
	movq	16(%rsi),	%rdx
	movq	24(%rsi),	%rcx
	movq	32(%rsi),	%r8
	movq	40(%rsi),	%r9
		
	movq	48(%rsi),	%rbx
	movq	56(%rsi),	%rbp
	movq	64(%rsi),	%r10
	movq	72(%rsi),	%r11
	movq	80(%rsi),	%r12
	movq	88(%rsi),	%r13
	movq	96(%rsi),	%r14
	movq	104(%rsi),	%r15
		
	movq	120(%rsi),	%rsp
	pushq	112(%rsi)

	movq	8(%rsi),	%rsi
	ret


.globl _trampoline
_trampoline:
	movq	%rbx,		%rsp
	movq	(%rsp),		%rdi
	testq	%rdi,		%rdi
	je	__exit
	call	_setcontext
__exit:
	movq	$0,		%rdi
	call	exit

