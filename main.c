#include "cdk-context.h"
#include <stdio.h>
#include <stdlib.h>
#ifdef __linux__
//#include <unistd.h>
#else
#include <windows.h>
#endif
#include <time.h>

//#define TEST

static uctx_t uctx_main, uctx_func1, uctx_func2;
int64_t count = 10000000;

#define USEC                        (1000000UL)
#define MSEC                        (1000UL)

uint64_t cdk_timespec_get(void) {

	struct timespec tsc;
	if (!timespec_get(&tsc, TIME_UTC)) { return 0; }

	return (tsc.tv_sec * MSEC + tsc.tv_nsec / USEC);
}

static void func1(void *param)
{
#ifdef TEST
	while (count-- > 0)
	{
		cdk_swapcontext(&uctx_func1, &uctx_func2);
	}
#else
	printf("func1: started\n");
	printf("func1: swapcontext(&uctx_func1, &uctx_func2)\n");
	cdk_swapcontext(&uctx_func1, &uctx_func2);
	printf("func1: returning\n");
#endif
}

void func2(void* param)
{
#ifdef TEST
	while (count-- > 0)
	{
		cdk_swapcontext(&uctx_func2, &uctx_func1);
	}
#else
	int a = 10;
	printf("func2: started: %s\n", param);
	printf("func2: swapcontext(&uctx_func2, &uctx_func1)\n");
	cdk_swapcontext(&uctx_func2, &uctx_func1);
	printf("func2: returning\n");
#endif
}

int main(int argc, char *argv[])
{
	char func1_stack[16384];
	char func2_stack[16384];

	cdk_getcontext(&uctx_func1);
	uctx_func1.uc_stack.sp = func1_stack;
	uctx_func1.uc_stack.sz = sizeof(func1_stack);
	uctx_func1.uc_link = &uctx_main;
	cdk_makecontext(&uctx_func1, func1, NULL);

	cdk_getcontext(&uctx_func2);
	uctx_func2.uc_stack.sp = func2_stack;
	uctx_func2.uc_stack.sz = sizeof(func2_stack);
	uctx_func2.uc_link = &uctx_func1;
	cdk_makecontext(&uctx_func2, func2, "hello");

	printf("main: swapcontext(&uctx_main, &uctx_func2)\n");

	uint64_t start = cdk_timespec_get();
	cdk_swapcontext(&uctx_main, &uctx_func2);
	uint64_t end = cdk_timespec_get();
	//printf("switch 10000000 cost: %llums\n", end - start);

	printf("main: exiting\n");
	exit(EXIT_SUCCESS);
}
