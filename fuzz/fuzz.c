#include "gif.h"

/*
int LLVMFuzzerInitialize(int argc, char **argv) {
    hack_onload();
}
*/

void init()
{
    static int initialized = 0;
    if (initialized == 0) {
        initialized = 1;

        JNI_Setup();

        JavaVM *vm = getVM();
        JNIEnv *env = getEnv();

        if (vm == NULL)
            __builtin_trap();
        if (env == NULL)
            __builtin_trap();

        JNI_OnLoad(vm, NULL);
    }
}

jobject create_bitmap(JNIEnv* env, jlong gif_info) {
    //replicating GifDrawable.java:231
    jclass Bitmap = (*env)->FindClass(env, "android/graphics/Bitmap");
    //from $ javap -s Bitmap.class #(unzip android.jar to find android/graphics/Bitmap.class)
    jmethodID createBitmap = (*env)->GetStaticMethodID(env, Bitmap, "createBitmap", "(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;");

    if (Bitmap == NULL)
        __builtin_trap();

    jclass BMConfig = (*env)->FindClass(env, "android/graphics/Bitmap/Config");
    jmethodID valueOf = (*env)->GetStaticMethodID(env, BMConfig, "valueOf", "(Ljava/lang/String;)Landroid/graphics/Bitmap$Config;");
    jstring argb_8888_s = (*env)->NewStringUTF(env, "ARGB_8888");

    if (BMConfig == NULL)
        __builtin_trap();
    if (valueOf == NULL)
        __builtin_trap();
    if (argb_8888_s == NULL)
        __builtin_trap();

    jobject argb_8888 = (*env)->CallStaticObjectMethod(env, BMConfig, valueOf, argb_8888_s);

    jint width = Java_pl_droidsonroids_gif_GifInfoHandle_getWidth(env, NULL, gif_info);
    jint height = Java_pl_droidsonroids_gif_GifInfoHandle_getHeight(env, NULL, gif_info);

    jobject bm = (*env)->CallStaticObjectMethod(env, Bitmap, createBitmap, width, height, argb_8888);
    return bm;
}

int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) {
    init();

    if (Size < 6)
        return 0;
    if ((strncmp((char *) Data, "GIF87a", 6) != 0) &&
        (strncmp((char *) Data, "GIF89a", 6) != 0))
        return 0;

    JNIEnv *env = getEnv();

    //FILE *f = fmemopen((void *) Data, Size, "r");
    //int fd = fileno(f);
    jobject bytebuffer = (*env)->NewDirectByteBuffer(env, Data, Size);


    //jlong info = Java_pl_droidsonroids_gif_GifInfoHandle_openNativeFileDescriptor(env, NULL, fd, 0);
    jlong info = Java_pl_droidsonroids_gif_GifInfoHandle_openDirectByteBuffer(env, NULL, bytebuffer);

    if (info == NULL) {
        //fclose(f);
        return 0;
    }

    //jobject bitmap = create_bitmap(env, info);
    jobject bitmap = NULL;
    for (int i = 0; i < 10; ++i)
    {
        Java_pl_droidsonroids_gif_GifInfoHandle_renderFrame(env, NULL, info, bitmap);
    }

    Java_pl_droidsonroids_gif_GifInfoHandle_free(env, NULL, info);

    //fclose(f);

    return 0;
}

/*
int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) {
  if (Size < 6)
    return 0;
  if ((strncmp((char *) Data, "GIF87a", 6) != 0) &&
      (strncmp((char *) Data, "GIF89a", 6) != 0))
    return 0;

  FILE *f = fmemopen((void *) Data, Size, "r");

  GifInfo *gif = createGifInfoFromFile(NULL, f, (long long) Size);

  if (gif == NULL) {
    fclose(f);
    return 0;
  }


  //Render all the frames once
  for (int i=0; i<10; ++i)  { //gif->currentIndex < gif->gifFilePtr->ImageCount)
    void *pixels;
    lockPixels(NULL, NULL, gif, &pixels);
    DDGifSlurp(gif, true, false);
    if (gif->currentIndex == 0) {
      prepareCanvas(pixels, gif);
    }
    uint_fast32_t duration = getBitmap(pixels, gif);
    free(pixels);
    //unlockPixels_(NULL, &pixels);
  }


  if (gif == NULL) {
    fclose(f);
    return 0;
  }

  cleanUp(gif);
  fclose(f);

  return 0;
}
*/
