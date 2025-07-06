Project Title & Description


Features

Splash screen

Firebase Email/Password login

Sign-up screen

Post screen (after login)

Auto-redirect based on login status

Logout functionality

Screens in the App

SplashScreen: checks login status

LoginScreen: existing users login

SignUpScreen: new users register

PostScreen: home screen after successful login

Firebase Setup

Connect Firebase project


Enable Email/Password in Firebase Auth

How the Navigation Works

If user already logged in → Splash → PostScreen

If not logged in → Splash → LoginScreen

If user taps Sign up → goes to SignUpScreen

After login/signup → goes to PostScreen

Packages Used

firebase_auth

firebase_core

fluttertoast (or any utility library)

Basic Folder Structure

css
Copy
Edit
lib/
├── splash_screen.dart
├── login_screen.dart
├── signup_screen.dart
├── post_screen.dart
├── utils/
│   └── utils.dart
└── main.dart