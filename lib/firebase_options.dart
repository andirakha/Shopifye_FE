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
    apiKey: 'AIzaSyD-KPVpCsibZyVyARsQWRUAluCdfTUY8JY',
    appId: '1:272282240586:web:f92e3b05a41b2526d008b3',
    messagingSenderId: '272282240586',
    projectId: 'shopifye-e5e59',
    authDomain: 'shopifye-e5e59.firebaseapp.com',
    storageBucket: 'shopifye-e5e59.appspot.com',
    measurementId: 'G-W31GDZ0ZCB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkdoUVjwKjIvDLisI2xLGQ7b3Q0aPXXFQ',
    appId: '1:272282240586:android:f36f971cfdb7e4b8d008b3',
    messagingSenderId: '272282240586',
    projectId: 'shopifye-e5e59',
    storageBucket: 'shopifye-e5e59.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCfEyMQpd-DAGiKoa163EsPAkLCgHOpkOY',
    appId: '1:272282240586:ios:e905a5178d3135efd008b3',
    messagingSenderId: '272282240586',
    projectId: 'shopifye-e5e59',
    storageBucket: 'shopifye-e5e59.appspot.com',
    iosBundleId: 'com.example.shopifyeECommerce',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCfEyMQpd-DAGiKoa163EsPAkLCgHOpkOY',
    appId: '1:272282240586:ios:352914fd623d563ed008b3',
    messagingSenderId: '272282240586',
    projectId: 'shopifye-e5e59',
    storageBucket: 'shopifye-e5e59.appspot.com',
    iosBundleId: 'com.example.shopifyeECommerce.RunnerTests',
  );
}