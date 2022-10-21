#ifndef __CDK_CONTEXT_H__
#define __CDK_CONTEXT_H__

#include "cdk-types.h"

extern void cdk_getcontext(uctx_t* ucp);
extern void cdk_setcontext(const uctx_t* ucp);
extern void cdk_swapcontext(uctx_t* oucp, const uctx_t* ucp);
extern void cdk_makecontext(uctx_t* ucp, void (*func)(void*), void* arg);

#endif /* __CDK_CONTEXT_H__ */
