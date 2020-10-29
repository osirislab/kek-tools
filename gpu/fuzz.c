#include "test.h"
#include <stdio.h>

void init() {}

int LLVMFuzzerTestOneInput(const uint8_t *data, size_t len) {
  test(data, len);
  return 0;
}
