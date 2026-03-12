# Proguard rules for Isar
-keep class io.isar.** { *; }
-keep class * extends io.isar.IsarObject { *; }
-keep class * extends io.isar.IsarLink { *; }
-keep interface io.isar.** { *; }

# Flutter rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
