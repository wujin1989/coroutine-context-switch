#ifndef __WIN_CONTEXT_H__
#define __WIN_CONTEXT_H__

#include "../cdk-types.h"
#include <stdlib.h>

extern void _getcontext(uctx_t* ucp);
extern void _setcontext(const uctx_t* ucp);
extern void _swapcontext(uctx_t *oucp, const uctx_t *ucp);
extern void _makecontext(uctx_t *ucp, void (*func)(void*), void* arg);
extern void _trampoline(void);

#endif /* __WIN_CONTEXT_H__ */
