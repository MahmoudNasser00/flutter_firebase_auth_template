# Flutter Firebase Auth Template

Production-ready Flutter starter template for authentication with Firebase, built with a feature-first structure and BLoC state management.

## ✨ What this template includes

- Email/password authentication (sign up, sign in, reset password).
- Google Sign-In.
- Auth gate using `FirebaseAuth.instance.authStateChanges()`.
- User profile screen backed by Cloud Firestore.
- Edit profile flow (name, phone, image).
- Image picking from gallery.
- Image upload support via Cloudinary.
- Reusable auth UI components and responsive helpers.

## 🧱 Tech stack

- **Flutter** + **Dart**
- **Firebase Core / Auth / Firestore / Storage**
- **flutter_bloc** + **equatable**
- **google_sign_in**
- **image_picker**
- **cloudinary_public**
- **flutter_screenutil**

## 📁 Project structure

```text
lib/
  core/
    responsive/
    services/
    utils/
    widgets/
  features/
    auth/
      cubit/
      data/
      domain/
      views/
      widgets/
    models/
```

## 🚀 Getting started

### 1) Prerequisites

- Flutter SDK installed.
- A Firebase project.
- Android Studio / Xcode for platform setup.

### 2) Clone and install dependencies

```bash
git clone <your-repo-url>
cd flutter_firebase_auth_template
flutter pub get
```

### 3) Configure Firebase

This template initializes Firebase using:

```dart
await Firebase.initializeApp();
```

So you need to configure platform files manually (or with FlutterFire CLI), including:

- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

And make sure Firebase is correctly wired in Android/iOS build files.

### 4) Enable auth providers in Firebase Console

- Email/Password
- Google

### 5) Firestore setup

Create a `users` collection with document IDs equal to authenticated `uid`. Example fields used in the app:

- `name` (string)
- `phone` (string)
- `email` (string)
- `image` (string URL)

### 6) Cloudinary setup (for profile image upload)

Update Cloudinary credentials before using uploads:

- `cloud_name`
- `upload_preset`

> Current placeholders exist in `edit_profile_view.dart`; replace them with your actual values.

### 7) Run the app

```bash
flutter run
```

## 🧪 Useful commands

```bash
flutter analyze
flutter test
```

## 🎬 Demo

![App Demo Part 1](assets/Video_Player.gif)
![App Demo Part 2](assets/Video_Player1.gif)

## 📌 Notes

- This is a starter template; you can plug in your own routing, DI, and theme system.
- Consider adding secure environment management for API/secrets before production.

## 🤝 Contributing

PRs are welcome. Feel free to open issues for improvements and bug reports.

## 📄 License

Add your preferred license (MIT, Apache-2.0, etc.) in a `LICENSE` file.
