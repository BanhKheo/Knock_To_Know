plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.knock_to_know"
    
    // 1. CHANGE THIS: Force SDK 34
    compileSdk = 34 
    
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.knock_to_know"
        
        // 2. CHANGE THIS: Force Min SDK 23 (Required for many AI/Camera features)
        minSdk = 23 
        
        // 3. CHANGE THIS: Force Target SDK 34
        targetSdk = 34 
        
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}