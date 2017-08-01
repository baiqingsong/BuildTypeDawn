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
