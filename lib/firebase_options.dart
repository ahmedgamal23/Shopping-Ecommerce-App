// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBFtgQU7wRLP1s0rS039UfHmhQdkOIw9qk',
    appId: '1:264817825404:web:2528fd4734ee0742ac5bf9',
    messagingSenderId: '264817825404',
    projectId: 'shopping-ecommerce-app-5efa9',
    authDomain: 'shopping-ecommerce-app-5efa9.firebaseapp.com',
    storageBucket: 'shopping-ecommerce-app-5efa9.appspot.com',
    measurementId: 'G-05TP3P9849',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbX9vELtF9KZJXiosaphYYT22a3q3tVb0',
    appId: '1:264817825404:android:afeb5f11c3a5a502ac5bf9',
    messagingSenderId: '264817825404',
    projectId: 'shopping-ecommerce-app-5efa9',
    storageBucket: 'shopping-ecommerce-app-5efa9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4lUDTtc5uUTy4TGpD63gYgvBFf_oNapA',
    appId: '1:264817825404:ios:f914b39ee96c14a2ac5bf9',
    messagingSenderId: '264817825404',
    projectId: 'shopping-ecommerce-app-5efa9',
    storageBucket: 'shopping-ecommerce-app-5efa9.appspot.com',
    iosBundleId: 'com.example.shoppingEcommerceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4lUDTtc5uUTy4TGpD63gYgvBFf_oNapA',
    appId: '1:264817825404:ios:5e2b84a1e666ae41ac5bf9',
    messagingSenderId: '264817825404',
    projectId: 'shopping-ecommerce-app-5efa9',
    storageBucket: 'shopping-ecommerce-app-5efa9.appspot.com',
    iosBundleId: 'com.example.shoppingEcommerceApp.RunnerTests',
  );
}
