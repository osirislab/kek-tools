cmake_minimum_required(VERSION 3.4.1)

set(CMAKE_VERBOSE_MAKEFILE on)
set(can_use_assembler TRUE)
enable_language(ASM)


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

target_compile_options(pwnbois_fuzz PUBLIC -fsanitize=address,fuzzer -fno-omit-frame-pointer)
set_target_properties(pwnbois_fuzz PROPERTIES LINK_FLAGS -fsanitize=address,fuzzer)

