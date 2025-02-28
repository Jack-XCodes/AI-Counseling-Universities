# rafiki_ai

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
---------------------------------------------------------------------------------------
# RafikiAI Frontend

This is the frontend for RafikiAI, an AI-powered counseling platform for Kenyan university students, built using Flutter for Android and web platforms. It provides a text-only, ChatGPT-like interface, integrating with the Python/Flask backend via the Google Gemini Flash API (`gemini-1.5-flash-latest` or `gemini-2.0-flash`), designed to be free, simple, and collapse-proof for Kenya.

## Overview
The frontend handles:
- Text-based user input and display of RafikiAI responses for mental health, career guidance, and personal development.
- Real-time communication with the backend via HTTP requests (`/api/chat`, `/api/history`).
- Responsive UI for Android (emulator/devices) and web (Chrome), mimicking ChatGPT's flow.

## Prerequisites
- **Flutter 3.16.0+** (free from flutter.dev, install via `flutter --version`).
- **Git** (for cloning, free from git-scm.com).
- **Android Studio (optional)**: For Android emulator setup (free, collapse-proof for Kenya).
- **VS Code (optional)**: With Flutter and Dart extensions (free, collapse-proof for Kenya).
- **Internet Connection**: For Google Gemini API calls (free tier, 15 req/min, 1M tokens/month—register at ai.google.dev).

## Installation

### 1. Clone the Repository
Navigate to your desired directory and clone the RafikiAI repository:
```bash
git https://github.com/Jack-XCodes/AI-Counseling-Universities/
cd rafiki-ai-counseling/frontend
```

### 2. Install Flutter
- Install Flutter if not already installed (follow flutter.dev/install, Windows guide).
- Add Flutter to PATH:
  - Open Windows Environment Variables, add `C:\flutter\bin` to PATH (per previous steps).
- Verify:
  ```bash
  flutter --version
  ```

### 3. Install Dependencies
Install Flutter dependencies from `pubspec.yaml`:
```bash
flutter pub get
```
- `pubspec.yaml` includes:
  ```yaml
  dependencies:
    flutter:
      sdk: flutter
    http: ^1.2.1
  ```

### 4. Set Up Android Emulator (Optional for Android)
- Install Android Studio, create an AVD (e.g., Pixel6, Android 14.0, x86_64—free, collapse-proof).
- Start emulator:
  - Android Studio: Tools > Device Manager > Play button.
  - Or CMD:
    ```bash
    cd C:\Users\<YourUser>\AppData\Local\Android\Sdk\emulator
    emulator -avd Pixel6
    ```

## Running the Frontend
Run on Android emulator or web:
- **Android**:
  - Ensure emulator is running, select device in VS Code/Android Studio:
    ```bash
    flutter run
    ```
  - Or in VS Code: Command Palette (Ctrl+Shift+P) > "Flutter: Select Device" > Choose emulator, press F5.
- **Web**:
  ```bash
  flutter run -d chrome
  ```