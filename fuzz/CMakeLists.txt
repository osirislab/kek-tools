cmake_minimum_required(VERSION 3.4.1)

set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)

project(kek)
set(CMAKE_VERBOSE_MAKEFILE on)
set(can_use_assembler TRUE)
enable_language(ASM)
set(CMAKE_BUILD_TYPE Debug)



add_executable(pwnbois_fuzz "")
target_sources(pwnbois_fuzz PRIVATE dispose.c
                                    drawing.c
                                    gif.c
                                    decoding.c
                                    jni.c
                                    init.c
                                    exception.c
                                    time.c
                                    metadata.c
                                    surface.c
                                    control.c
                                    opengl.c
                                    bitmap.c
                                    giflib/dgif_lib.c
                                    giflib/openbsd-reallocarray.c
                                    giflib/gifalloc.c
                                    fuzz.c)

add_library(ljvm SHARED IMPORTED)
set_property(TARGET ljvm PROPERTY IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/lib/amd64/server/libjvm.so)

#i have no fucking clue how cmake works
target_link_libraries(pwnbois_fuzz ljvm -fsanitize=fuzzer,address
                                        -fprofile-instr-generate
                                        -fcoverage-mapping
                                        -g)

target_compile_options(pwnbois_fuzz PUBLIC -fsanitize=fuzzer,address
                                           -fno-omit-frame-pointer
                                           -fprofile-instr-generate
                                           -fcoverage-mapping
                                           -g)
set_target_properties(pwnbois_fuzz PROPERTIES LINK_FLAGS -fsanitize=fuzzer,address
                                                         -fno-omit-frame-pointer
                                                         -fprofile-instr-generate
                                                         -fcoverage-mapping
                                                         -g)

