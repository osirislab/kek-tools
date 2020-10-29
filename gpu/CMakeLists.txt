cmake_minimum_required(VERSION 3.4.1)

set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(CUDA_HOST_COMPILER /usr/bin/gcc-9)
set(CUDA_TOOLKIT_ROOT_DIR /opt/cuda-10.2)

project(kek)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(CUDA_VERBOSE_BUILD ON)

enable_language(CUDA)
find_package(CUDA)

project(test)
cuda_add_library(test SHARED test.h test.cu)
target_compile_options(test PUBLIC)
target_include_directories(test PUBLIC test.h)
set_target_properties(test PROPERTIES PUBLIC_HEADER test.h)


cuda_add_executable(pwnbois_fuzz)
target_link_libraries(pwnbois_fuzz test)
target_sources(pwnbois_fuzz PRIVATE fuzz.c)

target_compile_options(pwnbois_fuzz PUBLIC
  -fsanitize=fuzzer
  -fno-omit-frame-pointer
  -fprofile-instr-generate)
set_target_properties(pwnbois_fuzz PROPERTIES LINK_FLAGS -fsanitize=fuzzer)

