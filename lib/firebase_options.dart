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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAZTrkv1i1P_m_iE9KnBREQINEYSTSbIDk',
    appId: '1:576004268310:web:1cc7ea52a4fd8c166eb037',
    messagingSenderId: '576004268310',
    projectId: 'dene-c80db',
    authDomain: 'dene-c80db.firebaseapp.com',
    storageBucket: 'dene-c80db.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAo2XH0YutpRohc-l2ZkbBe7Frtwsup4SM',
    appId: '1:576004268310:android:bd2fdcb68fae6af76eb037',
    messagingSenderId: '576004268310',
    projectId: 'dene-c80db',
    storageBucket: 'dene-c80db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAo_VwfynGaQSXPEZzLKenP0XuzJ1ZvYAM',
    appId: '1:576004268310:ios:101763b2658fdd836eb037',
    messagingSenderId: '576004268310',
    projectId: 'dene-c80db',
    storageBucket: 'dene-c80db.appspot.com',
    iosClientId: '576004268310-ceom18b9qbnhmmidla24vhl55ui3nb9s.apps.googleusercontent.com',
    iosBundleId: 'com.example.deneme',
  );
}
