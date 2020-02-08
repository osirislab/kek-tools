.class public final LX/2hl;
.super Ljava/lang/Object;
.source ""


# static fields
.field public static final A03:[B


# instance fields
.field public A00:I

.field public A01:Z

.field public final A02:[B


# direct methods
.method public static constructor <clinit>()V
    .locals 2

    const-string v1, "PkTwKSZqUfAUyR0rPQ8hYJ0wNsQQ3dW1+3SCnyTXIfEAxxS75FwkDf47wNv/c8pP3p0GXKR6OOQmhyERwx74fw1RYSU10I4r1gyBVDbRJ40pidjM41G1I1oN"

    const/4 v0, 0x0

    .line 312564
    invoke-static {v1, v0}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v0

    sput-object v0, LX/2hl;->A03:[B

    return-void
.end method

.method public constructor <init>([B)V
    .locals 0

    .line 312565
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 312566
    iput-object p1, p0, LX/2hl;->A02:[B

    return-void
.end method

.method public static A00(Landroid/content/Context;Ljava/lang/String;)LX/2hl;
    .locals 7

    const-string v5, "UTF-8"

    .line 312567
    const-class v2, LX/2hl;

    new-instance v3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 312568
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    .line 312569
    if-eqz v1, :cond_6

    const-string v0, "com.whatsapp"

    .line 312570
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 312571
    :try_start_0
    invoke-virtual {v1, v5}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/io/ByteArrayOutputStream;->write([B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_5

    const-string v0, "/res/drawable-hdpi/about_logo.png"

    .line 312572
    invoke-virtual {v2, v0}, Ljava/lang/Class;->getResourceAsStream(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v4

    if-nez v4, :cond_0

    const-string v0, "/res/drawable-hdpi-v4/about_logo.png"

    .line 312573
    invoke-virtual {v2, v0}, Ljava/lang/Class;->getResourceAsStream(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v4

    :cond_0
    if-nez v4, :cond_1

    const-string v0, "/res/drawable-xxhdpi-v4/about_logo.png"

    .line 312574
    invoke-virtual {v2, v0}, Ljava/lang/Class;->getResourceAsStream(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v4

    :cond_1
    if-nez v4, :cond_2

    .line 312575
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    .line 312576
    new-instance v4, Landroid/util/DisplayMetrics;

    invoke-direct {v4}, Landroid/util/DisplayMetrics;-><init>()V

    .line 312577
    invoke-virtual {v4}, Landroid/util/DisplayMetrics;->setToDefaults()V

    const/high16 v0, 0x3fc00000    # 1.5f

    .line 312578
    iput v0, v4, Landroid/util/DisplayMetrics;->density:F

    const/high16 v1, 0x3fc00000    # 1.5f

    const/16 v0, 0xf0

    .line 312579
    iput v0, v4, Landroid/util/DisplayMetrics;->densityDpi:I

    .line 312580
    iput v1, v4, Landroid/util/DisplayMetrics;->scaledDensity:F

    .line 312581
    int-to-float v0, v0

    iput v0, v4, Landroid/util/DisplayMetrics;->xdpi:F

    .line 312582
    iput v0, v4, Landroid/util/DisplayMetrics;->ydpi:F

    .line 312583
    new-instance v2, Landroid/content/res/Resources;

    .line 312584
    invoke-virtual {v6}, Landroid/content/res/Resources;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    invoke-virtual {v6}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    invoke-direct {v2, v1, v4, v0}, Landroid/content/res/Resources;-><init>(Landroid/content/res/AssetManager;Landroid/util/DisplayMetrics;Landroid/content/res/Configuration;)V

    .line 312585
    const v0, 0x7f080077

    invoke-virtual {v2, v0}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object v4

    :cond_2
    if-eqz v4, :cond_6

    const/16 v0, 0x2000

    new-array v2, v0, [B

    .line 312586
    :try_start_1
    invoke-virtual {v4, v2}, Ljava/io/InputStream;->read([B)I

    move-result v1

    :goto_0
    const/4 v0, -0x1

    const/4 v6, 0x0

    if-eq v1, v0, :cond_3

    .line 312587
    invoke-virtual {v3, v2, v6, v1}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 312588
    invoke-virtual {v4, v2}, Ljava/io/InputStream;->read([B)I

    move-result v1

    goto :goto_0
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 312589
    :cond_3
    :try_start_2
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 312590
    :catch_0
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    .line 312591
    sget-object v2, LX/2hl;->A03:[B

    const/16 v1, 0x80

    const/16 v0, 0x200

    .line 312592
    invoke-static {v3, v2, v1, v0}, LX/1PQ;->A07([B[BII)Ljavax/crypto/SecretKey;

    move-result-object v1

    .line 312593
    invoke-interface {v1}, Ljavax/crypto/SecretKey;->getEncoded()[B

    :try_start_3
    const-string v0, "HMACSHA1"

    .line 312594
    invoke-static {v0}, Ljavax/crypto/Mac;->getInstance(Ljava/lang/String;)Ljavax/crypto/Mac;

    move-result-object v4
    :try_end_3
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_3 .. :try_end_3} :catch_2

    .line 312595
    :try_start_4
    invoke-virtual {v4, v1}, Ljavax/crypto/Mac;->init(Ljava/security/Key;)V
    :try_end_4
    .catch Ljava/security/InvalidKeyException; {:try_start_4 .. :try_end_4} :catch_2

    .line 312596
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    .line 312597
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const/4 v2, 0x0

    if-eqz v0, :cond_4

    .line 312598
    :try_start_5
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const/16 v0, 0x40

    invoke-virtual {v1, v3, v0}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_5
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_5 .. :try_end_5} :catch_1

    move-result-object v0

    .line 312599
    iget-object v2, v0, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    .line 312600
    :catch_1
    :cond_4
    if-eqz v2, :cond_6

    .line 312601
    array-length v1, v2

    if-eqz v1, :cond_6

    .line 312602
    :goto_1
    if-ge v6, v1, :cond_5

    aget-object v0, v2, v6

    .line 312603
    invoke-virtual {v0}, Landroid/content/pm/Signature;->toByteArray()[B

    move-result-object v0

    .line 312604
    invoke-virtual {v4, v0}, Ljavax/crypto/Mac;->update([B)V

    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 312605
    :cond_5
    invoke-static {p0}, LX/1PQ;->A0H(Landroid/content/Context;)[B

    move-result-object v0

    .line 312606
    invoke-virtual {v4, v0}, Ljavax/crypto/Mac;->update([B)V

    .line 312607
    :try_start_6
    invoke-virtual {p1, v5}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    :try_end_6
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_6 .. :try_end_6} :catch_2

    move-result-object v0

    .line 312608
    invoke-virtual {v4, v0}, Ljavax/crypto/Mac;->update([B)V

    .line 312609
    new-instance v1, LX/2hl;

    invoke-virtual {v4}, Ljavax/crypto/Mac;->doFinal()[B

    move-result-object v0

    # Here we change thingy
    sget-object v0, LX/2hl;->A03:[B
    invoke-virtual {v4, v0}, Ljavax/crypto/Mac;->update([B)V
    invoke-virtual {v4}, Ljavax/crypto/Mac;->doFinal()[B
    move-result-object v0

    invoke-direct {v1, v0}, LX/2hl;-><init>([B)V

    return-object v1

    :catch_2
    move-exception v1

    .line 312610
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0, v1}, Ljava/lang/AssertionError;-><init>(Ljava/lang/Object;)V

    throw v0

    .line 312611
    :catch_3
    :try_start_7
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 312612
    :catchall_0
    move-exception v0

    .line 312613
    :try_start_8
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_4

    .line 312614
    :catch_4
    throw v0

    .line 312615
    :catch_5
    move-exception v1

    .line 312616
    new-instance v0, Ljava/lang/Error;

    invoke-direct {v0, v1}, Ljava/lang/Error;-><init>(Ljava/lang/Throwable;)V

    throw v0

    .line 312617
    :cond_6
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 2

    if-eq p0, p1, :cond_0

    if-eqz p1, :cond_1

    .line 312618
    const-class v1, LX/2hl;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v1, p0, LX/2hl;->A02:[B

    check-cast p1, LX/2hl;

    iget-object v0, p1, LX/2hl;->A02:[B

    invoke-static {v1, v0}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    return v0

    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method public hashCode()I
    .locals 2

    .line 312619
    iget-boolean v0, p0, LX/2hl;->A01:Z

    if-eqz v0, :cond_0

    .line 312620
    iget v0, p0, LX/2hl;->A00:I

    return v0

    .line 312621
    :cond_0
    iget-object v0, p0, LX/2hl;->A02:[B

    invoke-static {v0}, Ljava/util/Arrays;->hashCode([B)I

    move-result v1

    iput v1, p0, LX/2hl;->A00:I

    const/4 v0, 0x1

    .line 312622
    iput-boolean v0, p0, LX/2hl;->A01:Z

    .line 312623
    return v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 312624
    iget-object v1, p0, LX/2hl;->A02:[B

    const/4 v0, 0x2

    invoke-static {v1, v0}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
