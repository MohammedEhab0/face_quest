plugins {
    id("com.android.application")
    kotlin("android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.child_game"
    compileSdk = flutter.compileSdkVersion.toInt()
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.child_game"
        versionCode = flutter.versionCode.toInt()
        versionName = flutter.versionName
        minSdk = flutter.minSdkVersion.toInt().coerceAtLeast(24)
        targetSdk = flutter.targetSdkVersion.toInt()
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

// Dependencies block MUST be outside the android block
dependencies {
    // 1. ARCORE LIBRARY (Core requirement for Android AR)
    // Use the latest stable ARCore dependency
    implementation("com.google.ar:core:1.42.0")

    // 2. SCENEFORM LIBRARY (3D Rendering for AR, recommended community fork)
    // Kotlin uses 'val' for variable declaration
    val sceneformVersion = "1.23.0"

    // Provides the core 3D scene graph components
    implementation("com.gorisse.thomas.sceneform:core:$sceneformVersion")

    // Provides the UX elements (like ArFragment) and utilities
    implementation("com.gorisse.thomas.sceneform:sceneform:$sceneformVersion")
}