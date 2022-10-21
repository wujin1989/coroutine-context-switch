#include "unix-context.h"
#include <stdlib.h>

void _makecontext(uctx_t *ucp, void (*func)(void*), void* arg) {

	uint64_t* sp;

	sp = (uint64_t*) ((uintptr_t)ucp->uc_stack.sp + ucp->uc_stack.sz);
	sp -= 1;
	sp = (uint64_t*) (((uintptr_t)sp & -16L) - 8);

	ucp->uc_mctx.rip = (uintptr_t) func;
	ucp->uc_mctx.rbx = (uintptr_t) &sp[1];
	ucp->uc_mctx.rsp = (uintptr_t) sp;
	ucp->uc_mctx.rdi = (uintptr_t) arg;

	sp[0] = (uintptr_t) &_trampoline;
	sp[1] = (uintptr_t) ucp->uc_link;
}



