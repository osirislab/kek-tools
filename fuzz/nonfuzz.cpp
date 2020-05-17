#include <stdio.h>
#include <dlfcn.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include "gif.h"

using createGifInfoFromFile_t = GifInfo*(*)(JNIEnv*, FILE*, long long);

void *getHandle()
{
    static void* handle = nullptr;
    if (handle != nullptr)
        return handle;

    //handle = dlopen("libpl_droidsonroids_gif.so", RTLD_LAZY);
    handle = dlopen("./libpl_droidsonroids_gif.so", RTLD_LAZY);
    if (handle == NULL)
    {
        fprintf(stderr, "dlopen failed: %s\n", dlerror());
    }
    return handle;
}

size_t filesize(const char* fn)
{
    struct stat st;
    if (stat(fn, &st) == 0)
        return st.st_size;
    return -1;
}

int main(int argc, char** argv)
{
    if (argc < 2)
    {
        printf("Need file argument\n");
        return 1;
    }

    void* handle = getHandle();

    FILE *f = fopen(argv[1], "r");
    size_t Size = filesize(argv[1]);

    if (Size < 6)
        return 1;
    // Convert fuzz data into FILE* object
    //FILE *f = fmemopen((void*)Data, Size, "r");

    JNIEnv *env = (JNIEnv*)0x1337;

    createGifInfoFromFile_t createGifInfoFromFile = (createGifInfoFromFile_t) dlsym(handle, "createGifInfoFromFile");
    //GifInfo *info = createGifInfoFromFile(env, f, Size);

    return 0;
}
