#include "gif.h"

int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size)
{
    if (Size < 6)
        return 0;
    if ((strncmp((char*)Data, "GIF87a", 6) != 0) &&
        (strncmp((char*)Data, "GIF89a", 6) != 0))
        return 0;

    FILE *f = fmemopen((void*)Data, Size, "r");

    GifInfo* gif = createGifInfoFromFile(NULL, f, (long long) Size);

    if (gif == NULL)
    {
        fclose(f);
        return 0;
    }


    //Render all the frames once
    while (gif->currentIndex < gif->gifFilePtr->ImageCount)
    {
        void *pixels;
        lockPixels(NULL, NULL, gif, &pixels);
        DDGifSlurp(gif, true, false);
        if (gif->currentIndex == 0)
        {
            prepareCanvas(pixels, gif);
        }
        uint_fast32_t duration = getBitmap(pixels, gif);
        free(pixels);
        //unlockPixels_(NULL, &pixels);
    }


    if (gif == NULL)
    {
        fclose(f);
        return 0;
    }

    cleanUp(gif);
    fclose(f);

    return 0;
}

