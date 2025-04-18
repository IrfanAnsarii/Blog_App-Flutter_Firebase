plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // Firebase plugin
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // Flutter Gradle plugin
}

android {
    namespace = "com.example.blog.blog"
    compileSdk = flutter.compileSdkVersion

    // Specify the required NDK version
    ndkVersion = "27.0.12077973"  // Explicitly setting the NDK version

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.blog.blog"
        minSdk = 23  // Set minSdkVersion to 23 to support firebase_auth plugin
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")  // Signing configuration
        }
    }
}

flutter {
    source = "../.."  // Specify the location of the Flutter SDK
}
