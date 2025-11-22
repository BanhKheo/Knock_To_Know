# knock_to_know

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## How To Run Project

To run this project, you need to set up your development environment. We recommend using **VS Code** for coding and **Android Studio** for the emulator/tools.

### 1. Install Flutter SDK
* Download Flutter for your OS here: [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
* Extract the zip file and add the `flutter/bin` folder to your computer's **Path** (Environment Variables).
* Run `flutter doctor` in your terminal to verify.

### 2. Setup VS Code (Recommended Editor)
VS Code is lightweight and great for Flutter development.

1.  **Download:** Install [Visual Studio Code](https://code.visualstudio.com/).
2.  **Install Extensions:**
    * Open VS Code.
    * Click on the **Extensions** icon (box icon on the left bar) or press `Ctrl+Shift+X`.
    * Search for **"Flutter"**.
    * Click **Install** (This will automatically install the Dart extension too).
    * *(Optional)* Install **"Awesome Flutter Snippets"** for faster coding.

### 3. Setup Android Studio (Required for Emulator)
Even if you use VS Code, you need Android Studio for the Android SDK and Emulator.

1.  **Download & Install:**
    * Go to [developer.android.com/studio](https://developer.android.com/studio).
    * Download and run the installer.
    * **Important:** During installation, check the box **"Android Virtual Device"**.

2.  **Setup Emulator (Virtual Phone):**
    * Open Android Studio.
    * Click on **"More Actions"** > **"Virtual Device Manager"**.
    * Click **"Create Device"** -> Choose a phone (e.g., Pixel 6).
    * Select a System Image (Android Version) and download it.
    * Finish and press the **Play (▶)** button to start the emulator.

---

Once your environment is ready, follow these steps to run the app

#### 1. Clone the respository
Open your terminal (or VS Code terminal) and run:
```bash
git clone [https://github.com/BanhKheo/Knock_To_Know.git](https://github.com/BanhKheo/Knock_To_Know.git)
```

#### 2. Go to the directory 
``` bash
cd KNOCK_TO_KNOW
```

#### 3. Install dependencies
``` bash
flutter pub get
```

#### 4. Run the app
- Make sure your Emulator is open 

1. Open **main.dart**
2. Press F5 (or go to **Run** )
3. Select your device in the bottom right conner if asked 
4. Using terminal
``` bash
flutter run
```

## ❓ Troubleshooting Installation

Common issues when setting up the environment and how to fix them.

### 1. ❌ Error: "'flutter' is not recognized as an internal or external command"
**Cause:** Your computer doesn't know where the Flutter SDK is located.
**Fix:** You need to add Flutter to your **PATH**.
* **Windows:**
    1.  Search for "Edit the system environment variables".
    2.  Click **Environment Variables**.
    3.  Under "User variables", find **Path** and click **Edit**.
    4.  Click **New** and paste the path to your `flutter\bin` folder (e.g., `C:\src\flutter\bin`).
    5.  Restart your terminal/computer.
* **Mac/Linux:** Check the [official guide](https://docs.flutter.dev/get-started/install/macos#update-your-path) to update your shell RC file (`.zshrc` or `.bashrc`).

### 2. ❌ Error: "Android toolchain - develop for Android devices" (cmdline-tools component is missing)
**Cause:** Android Studio didn't install the command-line tools by default.
**Fix:**
1.  Open **Android Studio**.
2.  Go to **Settings** (or Preferences on Mac) > **Languages & Frameworks** > **Android SDK**.
3.  Select the **SDK Tools** tab (middle tab).
4.  Check the box **"Android SDK Command-line Tools (latest)"**.
5.  Click **Apply** and wait for the download to finish.
6.  Run `flutter doctor` again.

### 3. ❌ Error: "Android license status unknown"
**Cause:** You haven't agreed to the Google agreements yet.
**Fix:**
Run this command in your terminal and type `y` (Yes) to all questions:
```bash
flutter doctor --android-licenses