#ifndef THEORY_H
#define THEORY_H

#include "SMTLIB/BufferRef.h"
#include "SMTLIB/Float.h"
#include <stdio.h>

extern __device__ int solved;
extern volatile int finished_dev;

#define VARSIZE 16


__device__ void LLVMFuzzerTestOneInput(const uint8_t *data, size_t size,
                                       uint8_t *out);

#endif
