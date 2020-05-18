#include "gif.h"

int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size)
{
    if (Size < 6)
        return 0;
    if ((strncmp((char*)Data, "GIF87a", 6) != 0) &&
        (strncmp((char*)Data, "GIF89a", 6) != 0))
        return 0;

    FILE *f = fmemopen((void*)Data, Size, "r");

    createGifInfoFromFile(NULL, f, (long long) Size);

    return 0;
}

