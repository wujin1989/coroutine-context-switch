cmake_minimum_required(VERSION 3.16)

project(context)

#only support windows, linux, darwin(mac os)
if (CMAKE_SYSTEM_NAME MATCHES "Linux")
    message(STATUS "[cdk compile]: operation system type is ${CMAKE_SYSTEM_NAME}")
	enable_language(C ASM-ATT)
elseif (CMAKE_SYSTEM_NAME MATCHES "Windows")
    message(STATUS "[cdk compile]: operation system type is ${CMAKE_SYSTEM_NAME}")
	if (CMAKE_C_COMPILER_ID MATCHES "Clang")
		enable_language(C ASM-ATT)
	endif()
	if (CMAKE_C_COMPILER_ID MATCHES "MSVC")
		enable_language(C ASM_MASM)
	endif()
elseif (CMAKE_SYSTEM_NAME MATCHES "Darwin")
    message(STATUS "[cdk compile]: operation system type is ${CMAKE_SYSTEM_NAME}")
	enable_language(C ASM-ATT)
else ()
    message(FATAL_ERROR "[cdk compile]: operation system type is ${CMAKE_SYSTEM_NAME}, now not support")
endif()

if (CMAKE_SIZEOF_VOID_P EQUAL 8)
	message(STATUS "[cdk compile]: current os is 64bit!")
else()
	message(FATAL_ERROR "[cdk compile]: 32bit os isn't supported!")
endif()

#iso c standard, support c11 and later
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_C_STANDARD 11)

include_directories(. win unix)
	
set(HDRS 
	cdk-context.h
	cdk-types.h)
	
set(SRCS 
	cdk-context.c)
	
if(WIN32)
	
	list(APPEND SRCS 
		win/win-context.h
		win/win-context.c)

	if (CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "AMD64" OR CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "x86_64")
		if (CMAKE_C_COMPILER_ID MATCHES "Clang")
			list(APPEND SRCS win/win-context-amd64-att.s)
		elseif (CMAKE_C_COMPILER_ID MATCHES "MSVC")
			list(APPEND SRCS win/win-context-amd64-intel.asm)
		else()
			message(FATAL_ERROR "[cdk compile]: current compiler is ${CMAKE_C_COMPILER_ID}, now not support")
		endif()
	else()
		message(FATAL_ERROR "[cdk compile]: current architecture is ${CMAKE_HOST_SYSTEM_PROCESSOR}, now not support")
	endif()
	
endif()

if(UNIX)
	
	list(APPEND SRCS 
		unix/unix-context.h
		unix/unix-context.c)

	if (CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "AMD64" OR CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "x86_64")
		if (CMAKE_C_COMPILER_ID MATCHES "Clang" OR CMAKE_C_COMPILER_ID MATCHES "GNU")
			list(APPEND SRCS unix/unix-context-amd64-att.s)
		else()
			message(FATAL_ERROR "[cdk compile]: current compiler is ${CMAKE_C_COMPILER_ID}, now not support")
		endif()
	elseif (CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "aarch64")
		if (CMAKE_C_COMPILER_ID MATCHES "Clang" OR CMAKE_C_COMPILER_ID MATCHES "GNU")
			list(APPEND SRCS unix/unix-context-aarch64-att.s)
		else()
			message(FATAL_ERROR "[cdk compile]: current compiler is ${CMAKE_C_COMPILER_ID}, now not support")
		endif()
	else()
		message(FATAL_ERROR "[cdk compile]: current architecture is ${CMAKE_HOST_SYSTEM_PROCESSOR}, now not support")
	endif()
endif()

source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${HDRS})
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${SRCS})

add_executable(main main.c ${SRCS} ${HDRS})


