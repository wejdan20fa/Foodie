# Foodie — Local Setup

Foodie is a Flutter application that uses Firebase for user accounts and data storage, Gemini for AI-powered features, and recipe APIs for meal discovery. Follow these steps to run the application with your own service configuration.

## Requirements

- Flutter SDK and Dart
- Android Studio or another Flutter-compatible IDE
- Android emulator or physical device
- A Firebase project
- Gemini and Spoonacular API keys

## 1. Install Dependencies

Open a terminal in the project directory and run:

```bash
flutter pub get
```

## 2. Configure Firebase

1. Create a project in the [Firebase Console](https://console.firebase.google.com/).
2. Register the Android or iOS application in your Firebase project.
3. Set up **Firebase Authentication** (including the sign-in and phone-verification methods used by Foodie) and **Cloud Firestore** with appropriate access rules.
4. Install the [Firebase CLI](https://firebase.google.com/docs/cli) and sign in to your Firebase account.
5. Install the FlutterFire CLI and generate the app's Firebase configuration:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

The configuration command generates `lib/firebase_options.dart` and the platform files required for your Firebase project. The file included in this repository is a placeholder until this step is completed.

## 3. Configure API Keys

Foodie reads the Gemini and Spoonacular API keys from Dart compile-time definitions. Provide your own keys when running the application:

```bash
flutter run --dart-define=GEMINI_API_KEY=YOUR_GEMINI_API_KEY --dart-define=SPOONACULAR_API_KEY=YOUR_SPOONACULAR_API_KEY
```

These values are required for the features that call the corresponding services. Check the API provider documentation if an endpoint or model version needs updating.

## 4. Run the Application

Check for connected devices:

```bash
flutter devices
```

Run Foodie using the command in step 3 after Firebase is configured.

## Credential Security

Keep API keys out of Git commits and public documentation. Dart compile-time definitions simplify local configuration, but **they do not securely hide keys inside a released mobile application**. For deployed applications, keep provider credentials on a trusted backend and make authenticated requests from the Flutter app.
