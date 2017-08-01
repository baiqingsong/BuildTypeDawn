# 混淆的使用

* [混淆设置](#混淆设置)
* [基本配置](#基本配置)
* [参考地址](#参考地址)


## 混淆设置
build.gradle中设置
```
    buildTypes {
        release {
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
        debug {
            minifyEnabled false
        }
    }
```

## 基本配置
proguard主要提供的功能有：
1. 压缩：Java源代码通常被编译为字节码，虽然字节码比源代码更加简洁，但它本身仍包含了很多无用的代码，Proguard通过分析字节码，去掉冗余代码。
2. 优化： 优化Java字节码，移除没有使用到的指令
3. 混淆： 使用无意义的字母对类名方法名，字段名进行重命名，达到混淆的效果
4. 预检验： 对上述处理的代码进行与监狱

基本配置：
```
-dontusemixedcaseclassnames #不使用大小写形式的混淆名
-dontskipnonpubliclibraryclasses #不跳过library的非public的类
-dontoptimize #不进行优化，优化可能会在某些手机上无法运行。
-dontpreverify #不进行预校验，该校验是java平台上的，对android没啥用处
-keepattributes *Annotation* #对注解中的参数进行保留
-keep public class com.deep.test.MainActivity #对某个class不进行混淆
-dontshrink #不缩减代码，需要注意，反射调用的代码会被认为是无用代码而删掉，所以要提前keep出来
-keepclassmembers enum * {
public static **[] values();
public static ** valueOf(java.lang.String);
} #保持枚举类中的属性不被混淆
-keepclassmemberspublic class xxx extends xxx{
void set*(***);
*** get*();
} #不混淆任何view子类的get和set方法。
-keepclassmembers class * implements android.os.Parcelable {
public static final android.os.Parcelable$Creator CREATOR;
} #aidl文件不能去混淆
-keep public class com.ebt.app.common.bean.Customer
#保留某个类名不被混淆
-keep public class com.ebt.app.common.bean.Customer { *;}
#保留类及其所有成员不被混淆
-keep public class com.ebt.app.common.bean.Customer {
static final;
private void get*();
} #只保留类名及其部分成员不被混淆
-keep class com.ebt.app.sync.** { *;}
#保留包路径下所有的类及其属性和方法
-keepclassmembers class **.R$* {
public static ;
} #资源类变量需要保留

```
关键字介绍：
* keep：包留类和类中的成员，防止他们被混淆
* keepnames:保留类和类中的成员防止被混淆，但成员如果没有被引用将被删除
* keepclassmembers:只保留类中的成员，防止被混淆和移除。
* keepclassmembernames:只保留类中的成员，但如果成员没有被引用将被删除。
* keepclasseswithmembers:如果当前类中包含指定的方法，则保留类和类成员，否则将被混淆。
* keepclasseswithmembernames:如果当前类中包含指定的方法，则保留类和类成员，如果类成员没有被引用，则会被移除。
* -dontwarn:忽视警告。
* -optimizationpasses 5：proguard对你的代码进行迭代优化的次数，首先要明白optimization 会对代码进行各种优化，每次优化后的代码还可以再次优化，所以就产生了 优化次数的问题，这里面的 passes 应该翻译成 ‘次数’
* -keepattributes Signature：避免混淆泛型。
* -keepattributes SourceFile,LineNumberTable：抛出异常时保留代码行号

注意事项：
* 反射用到的类不混淆(否则反射可能出现问题)；
* AndroidMainfest中的类不混淆，所以四大组件和Application的子类和Framework层下所有的类默认不会进行混淆。
自定义的View默认也不会被混淆；所以像网上贴的很多排除自定义View，或四大组件被混淆的规则在Android Studio中是无需加入的；
* 与服务端交互时，使用GSON、fastjson等框架解析服务端数据时，所写的JSON对象类不混淆，否则无法将JSON解析成对应的对象；
* 使用第三方开源库或者引用其他第三方的SDK包时，如果有特别要求，也需要在混淆文件中加入对应的混淆规则；
* 有用到WebView的JS调用也需要保证写的接口方法不混淆；
* Parcelable的子类和Creator静态成员变量不混淆，否则会产生Android.os.BadParcelableException异常
* 使用enum类型时需要注意避免以下两个方法混淆，因为enum类的特殊性

整理：
```
-dontusemixedcaseclassnames #不使用大小写形式的混淆名
-dontskipnonpubliclibraryclasses #不跳过library的非public的类
-dontoptimize #不进行优化，优化可能会在某些手机上无法运行。
-dontpreverify #不进行预校验，该校验是java平台上的，对android没啥用处
-keepattributes *Annotation* #对注解中的参数进行保留
-dontshrink #不缩减代码，需要注意，反射调用的代码会被认为是无用代码而删掉，所以要提前keep出来
#AndroidMainfest中的类不混淆，所以四大组件和Application的子类和Framework层下所有的类默认不会进行混淆。
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application {*;}
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends android.support.v4.**
-keep public class * extends android.support.v7.**
-keep public class * extends android.app.Fragment
#自定义的View默认也不会被混淆
-keep public class * extends android.view.View {*;}
-keepclassmemberspublic class xxx extends xxx{
void set*(***);
*** get*();
} #不混淆任何view子类的get和set方法。
#有用到WebView的JS调用也需要保证写的接口方法不混淆；
-keepattributes *JavascriptInterface*
#Parcelable的子类和Creator静态成员变量不混淆
-keepclassmembers class * implements android.os.Parcelable {
public static final android.os.Parcelable$Creator *;
}
#数据模型不要混淆
-keepnames class * implements java.io.Serializable
-keepclassmembers class * implements java.io.Serializable {*;}
#使用enum类型不进行混淆
-keepclassmembers enum * {
public static **[] values();
public static ** valueOf(java.lang.String);
}
#资源类变量需要保留
-keepclassmembers class **.R$* {
public static ;
}
#第三方包不进行混淆

#aidl文件不能去混淆

#对某个class不进行混淆
-keep public class com.dawn.buildtypedawn.MainActivity
#保留包路径下所有的类及其属性和方法
-keep class com.dawn.buildtypedawn.** { *;}

```

## 参考地址

[http://www.jianshu.com/p/b2aa88c9e2a6](http://www.jianshu.com/p/b2aa88c9e2a6 "参考地址")
