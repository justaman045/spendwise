// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// TODO: Reduce Lines of Code
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
        return windows;
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
    apiKey: 'AIzaSyAs9DQ4cbuoZEBE5tGAdKnRSqJdOEG59Wg',
    appId: '1:436894081806:web:1d85356af4b8228a48ad5f',
    messagingSenderId: '436894081806',
    projectId: 'spendwise-eef57',
    authDomain: 'spendwise-eef57.firebaseapp.com',
    storageBucket: 'spendwise-eef57.appspot.com',
    measurementId: 'G-G02E6CHPP7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVCotiuS8GEej_FYeYMBpT4kbMvLdRif0',
    appId: '1:436894081806:android:de80525cf27d160848ad5f',
    messagingSenderId: '436894081806',
    projectId: 'spendwise-eef57',
    storageBucket: 'spendwise-eef57.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBW2bYzN_BfTIlW6BDH9ux7QFCWnbfK1c4',
    appId: '1:436894081806:ios:acebd30098acd7ad48ad5f',
    messagingSenderId: '436894081806',
    projectId: 'spendwise-eef57',
    storageBucket: 'spendwise-eef57.appspot.com',
    iosBundleId: 'app.vercel.justaman045.spendwise',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBW2bYzN_BfTIlW6BDH9ux7QFCWnbfK1c4',
    appId: '1:436894081806:ios:acebd30098acd7ad48ad5f',
    messagingSenderId: '436894081806',
    projectId: 'spendwise-eef57',
    storageBucket: 'spendwise-eef57.appspot.com',
    iosBundleId: 'app.vercel.justaman045.spendwise',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAs9DQ4cbuoZEBE5tGAdKnRSqJdOEG59Wg',
    appId: '1:436894081806:web:1efac36e87336e3c48ad5f',
    messagingSenderId: '436894081806',
    projectId: 'spendwise-eef57',
    authDomain: 'spendwise-eef57.firebaseapp.com',
    storageBucket: 'spendwise-eef57.appspot.com',
    measurementId: 'G-JTFC4BTWYF',
  );
}
