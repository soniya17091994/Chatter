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
    apiKey: 'AIzaSyDB8hc4EaHVk5c3_5Q6jQVIUbikMdcKBM4',
    appId: '1:10829871675:web:6cad98f052d17abf9d7a1e',
    messagingSenderId: '10829871675',
    projectId: 'chatterapp-9a86b',
    authDomain: 'chatterapp-9a86b.firebaseapp.com',
    storageBucket: 'chatterapp-9a86b.appspot.com',
    measurementId: 'G-TGZDM3Z8S7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAtdEvyg-w7pGhKXVhHqhTRVga8EnHPE3o',
    appId: '1:10829871675:android:97487557fe61e55c9d7a1e',
    messagingSenderId: '10829871675',
    projectId: 'chatterapp-9a86b',
    storageBucket: 'chatterapp-9a86b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwQCnTYoNteUGSBYAZ7V48rrNyWBJAGhA',
    appId: '1:10829871675:ios:d0698fc4f23cb2ab9d7a1e',
    messagingSenderId: '10829871675',
    projectId: 'chatterapp-9a86b',
    storageBucket: 'chatterapp-9a86b.appspot.com',
    iosBundleId: 'com.example.chatter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAwQCnTYoNteUGSBYAZ7V48rrNyWBJAGhA',
    appId: '1:10829871675:ios:21f17107f3be18529d7a1e',
    messagingSenderId: '10829871675',
    projectId: 'chatterapp-9a86b',
    storageBucket: 'chatterapp-9a86b.appspot.com',
    iosBundleId: 'com.example.chatter.RunnerTests',
  );
}
