SMTLIB/%.o: SMTLIB/%.cu
	$(MAKE) -C SMTLIB

INCLUDE = -I.
NVCC_FLAGS = --expt-relaxed-constexpr -DJFS_RUNTIME_FAILURE_CALLS_ABORT -dc -std=c++11 $(INCLUDE)

%.o: %.cu
	nvcc $(NVCC_FLAGS) -c $< -o $@

smtlib-objs =  SMTLIB/Core.o
smtlib-objs += SMTLIB/Logger.o
smtlib-objs += SMTLIB/NativeFloat.o
smtlib-objs += SMTLIB/Messages.o
smtlib-objs += SMTLIB/Float.o
smtlib-objs += SMTLIB/NativeBitVector.o

smt: theory.o smt.o aes.o $(smtlib-objs)
	nvcc -I. $^ -o $@

theory.cu: theory.smt
	docker run -it --rm -v $(shell pwd):/out -u $(shell id -u):$(shell id -g) \
		delcypher/jfs_build:fse_2019 /home/user/jfs/build/bin/jfs-smt2cxx \
		/out/theory.smt | \
			sed 's/return 0;/out[i]=0; return;/' | \
			sed 's/abort();/out[i]=1;solved=1;return;/' | \
			sed 's/extern "C" int/__device__ void/' | \
			sed 's/if (size != 32)/int i=blockIdx.x*blockDim.x+threadIdx.x;if(size < VARSIZE)/' | \
			sed 's/size_t size/size_t size, uint8_t* out/' | \
			sed 's/jfs_warning("Wrong sized input tried.\\n");//' | \
			sed 's/SMTLIB\/BitVector.h/SMTLIB\/BufferRef.h/' | \
			sed 's/#include/\/\/ #include/' | \
			sed 's/\/\/ Begin program/#include "theory.h"/' | \
			clang-format > theory.cu

all: smt

clean:
	rm -f *.o SMTLIB/*.o theory.cu smt
