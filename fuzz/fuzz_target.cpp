#include <dlfcn.h>
#include <string.h>
#include "gif.h"

extern "C"
{

using createGifInfoFromFile_t = GifInfo*(*)(JNIEnv*, FILE*, long long);

void *getHandle()
{
    static void* handle = nullptr;
    if (handle != nullptr)
        return handle;

    handle = dlopen("libpl_droidsonroids_gif.so", RTLD_LAZY);
    return handle;
}

int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size)
{
    if (Size < 6)
        return 1;
    if ((strncmp((char*)Data, "GIF87a", 6) != 0) &&
        (strncmp((char*)Data, "GIF89a", 6) != 0))
        return 1;

    void* handle = getHandle();

    // Convert fuzz data into FILE* object
    FILE *f = fmemopen((void*)Data, Size, "r");

    JNIEnv *env = (JNIEnv*)0x1337;

    createGifInfoFromFile_t createGifInfoFromFile = (createGifInfoFromFile_t) dlsym(handle, "createGifInfoFromFile");
    GifInfo *info = createGifInfoFromFile(env, f, Size);

    return 0;
}

}
