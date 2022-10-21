#if defined(__linux__) || defined(__APPLE__)
#include "unix/unix-context.h"
#endif

#if defined(_WIN32)
#include "win/win-context.h"
#endif


void cdk_getcontext(uctx_t* ucp) {

	_getcontext(ucp);
}

void cdk_setcontext(const uctx_t* ucp) {

	_setcontext(ucp);
}

void cdk_swapcontext(uctx_t *oucp, const uctx_t *ucp) {

	_swapcontext(oucp, ucp);
}

void cdk_makecontext(uctx_t *ucp, void (*func)(void*), void* arg) {

	_makecontext(ucp, func, arg);
}
