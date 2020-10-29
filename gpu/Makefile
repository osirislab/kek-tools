

all: clean
	cmake -Bbuild -DCUDA_HOST_COMPILER=/usr/bin/gcc-9 .
	cmake --build build

maybe:
	nvcc -c -arch=sm_75 test.cu
	clang test.o fuzz.c -o test -L/opt/cuda/lib64 -lcudart -lcuda -fsanitize=fuzzer -fno-omit-frame-pointer -fprofile-instr-generate

clean:
	rm -rf build
