#ifndef SMT_H
#define SMT_H

#include "SMTLIB/BufferRef.h"
#include "SMTLIB/Float.h"
#include "cuda_aes.h"

#define NUM_GPU 2

// Threads per block
#define N 1024
// Number of blocks
#define M 65536

// Size of all variables needed by the SMT formula, in bytes
#define VARSIZE 16

#define gpuErrchk(ans)                          \
  { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line,
                      bool abort = true);

#endif
