# Flutter Blog App
This is a Flutter blog application designed for mobile devices. It connects to a google firebase backend. 
It provides features like viewing blogs, adding new blogs, changing existing blogs, creating an own user profile and displaying some sensor data. 

Demonstration: https://youtu.be/PeSxmyEsaQs

## File tree
```bash
C:.
│   firebase_options.dart
│   main.dart
│   routes.dart
│
├───models
│       blogpost.dart
│       blogpost.g.dart
│       category.dart
│       category.g.dart
│       comment.dart
│       comment.g.dart
│       profile.dart
│       profile.g.dart
│
├───providers
│       profile_provider.dart
│       theme_provider.dart
│
├───screens
│   ├───blogpost
│   │       blogpost.dart
│   │       blogpost_create.dart
│   │       blogpost_delete.dart
│   │       blogpost_detail.dart
│   │       blogpost_edit_dialog.dart
│   │       blogpost_item.dart
│   │
│   ├───home
│   │       home.dart
│   │
│   ├───login
│   │       login.dart
│   │       login_button_google.dart
│   │       login_button_guest.dart
│   │       login_button_signin.dart
│   │       login_button_signup.dart
│   │       login_email_field.dart
│   │       login_forgot_password_button.dart
│   │       login_password_field.dart
│   │
│   ├───profile
│   │       profile.dart
│   │       profile_edit.dart
│   │
│   ├───sensors
│   │       sensordatacard.dart
│   │       sensors.dart
│   │
│   └───shared
│           error.dart
│           loading.dart
│           navigation_bar.dart
│
├───services
│       auth.dart
│       firestore.dart
│       sensors.dart
│
└───settings
        theme.dart
```

# Project Structure
- ``models``: Contains the model classes used to map the data fetched from firebase. 
- ``providers``: Contains classes that manage states and provide data throughout the app. 
- ``screens``: Contains all screens and UI elements of the app.
- ``services``: Contains classes used for authorising users to firebase, connecting to the firebase database and storage bucket.
- ``settings``: Contains files thatr store settings. 


# Prerequisites
This application is build for Android API 33 (Android 13 Tiramisu 2022), with the minimum supported version being Android API 28 (Android 9, Pie 2018).
If run on an Android emulator, make sure to use a system IOS that includes the Google Play Services. 

The specific device and ISO configuration this app was tested on is:
- Google Pixel 8 Pro, API TiramisuPrivacySandbox x86_64, Android 14.0 (Google Play)

Other device and system configuration may work, but they can be more prone to errors and bugs. 

**SKD Versions:** 
- Dart SDK version: 3.5.1 (stable) (Tue Aug 13 21:02:17 2024 +0000) on "windows_x64"
- Flutter SDK version: 3.24.1 (stable) (Tue Aug 20 16:46:00 2024 +0000) on "windows_x64"

# Setup and Installation
No further setup is needed if the prerequisites are met. 
To run the app, clone the github repository and execute the following commands.
```
flutter pub get
```

```
flutter run
```

# Personal Feedback
I had fun while making this app and learned quite a lot. It is my first flutter app overall. 
I spend quite some time on UX design, but I am not very good at it for now. There are a lot of things to improve and to tweek. The time run out but I may develop this further into the future. Goal would be to create a flutter blog demo app that others can learn from and that is easy to understand. It would require additional work. Improving the code and it's structure, implementing logging, better error handling and splitting up widgets to they can be reused more often. Non the less, I am happy with the result. 