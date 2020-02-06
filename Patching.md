### How to Patch

`apktool d base.apk -o extracted`

Go to `extracted/AndroidManifest.xml`.

Make sure it has Internet perms: `<uses-permission android:name="android.permission.INTERNET"/>`

Find main activity

```
<activity android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|screenSize|smallestScreenSize|uiMode" android:hardwareAccelerated="false" android:label="@string/launcher_app_name" android:name="com.whatsapp.Main" android:theme="@style/Theme.App.Launcher">
    <intent-filter android:label="@string/launcher_app_name">
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
        <category android:name="android.intent.category.MULTIWINDOW_LAUNCHER"/>
    </intent-filter>
</activity>
```

`LAUNCHER` means it runs when the icon is clicked. So we'll want to load frida here.

Go to `smali/com/whatsapp/Main.smali`

Insert the following above `<init>`

```
# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "frida-gadget"
    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    return-void
.end method
```

If a `<clinit>` already exists, put the frida loading lines below `.locals`. Keep in mind `.locals` defines how many variables you have. Add +1 and use a variable number not in use if necessary.

Now insert the appropriate frida library in lib. The frida library version and your frida versions should match.

```
$ frida --version
12.8.10
$ cp libfrida-gadgets/frida-gadget-12.8.10-android-arm64.so extracted/lib/arm64-v8a/libfrida-gadget.so
```

Now you have to repackage the apk.

```
apktool b extracted -o repackaged.jar #Recompile
jarsigner -sigalg SHA1withRSA -digestalg SHA1 -keystore androidhackers.keystore repackaged.apk androidhackers #Sign
jarsigner -verify repackaged.apk # Verify signed
zipalign 4 repackaged.apk repackaged-final.apk # Zipalign, as android requires
```

Then to install unto the device:
```
adb uninstall com.whatsapp #remove old copy
adb install repackaged-final.apk
```

