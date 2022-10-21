#include <stdint.h>
#include <stddef.h>
#include <stdarg.h>

#if defined(_WIN32)
typedef struct _mctx_t{

	uint64_t rcx;
	uint64_t rdx;
	uint64_t r8;
	uint64_t r9;

	uint64_t rdi;
	uint64_t rsi;
	uint64_t rbx;
	uint64_t rbp;
	uint64_t r10;
	uint64_t r11;
	uint64_t r12;
	uint64_t r13;
	uint64_t r14;
	uint64_t r15;

	uint64_t rip;
	uint64_t rsp;
}mctx_t;
#endif

#if defined(__linux__) || defined(__APPLE__)
#if defined(__aarch64__)
//for macosx m1 chip
#endif

#if defined(__amd64__)
typedef struct _mctx_t {

	uint64_t rdi;
	uint64_t rsi;
	uint64_t rdx;
	uint64_t rcx;
	uint64_t r8;
	uint64_t r9;

	uint64_t rbx;
	uint64_t rbp;
	uint64_t r10;
	uint64_t r11;
	uint64_t r12;
	uint64_t r13;
	uint64_t r14;
	uint64_t r15;

	uint64_t rip;
	uint64_t rsp;
} mctx_t;
#endif
#endif

typedef struct uctx_t {

	mctx_t uc_mctx;
	
	struct {
		void*	sp;
		size_t	sz;
	} uc_stack;

	struct uctx_t* uc_link;

} uctx_t;

