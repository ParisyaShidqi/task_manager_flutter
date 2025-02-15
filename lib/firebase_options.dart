// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyD_YDr849-ViVkTW4pa3p406y4mjq07OjI',
    appId: '1:652870702671:web:a555877d6cf85f09bdfc3a',
    messagingSenderId: '652870702671',
    projectId: 'task-manager-ba88f',
    authDomain: 'task-manager-ba88f.firebaseapp.com',
    storageBucket: 'task-manager-ba88f.firebasestorage.app',
    measurementId: 'G-Q5W2RLNW9E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcD1ETMVaRXNqNP7izwL00a_NfDksiRBU',
    appId: '1:652870702671:android:ab956e2533fca0f1bdfc3a',
    messagingSenderId: '652870702671',
    projectId: 'task-manager-ba88f',
    storageBucket: 'task-manager-ba88f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDhQdJ55Nk73sV9ltjY8kUZpdYd7bRGce0',
    appId: '1:652870702671:ios:7ec7ef8e96587890bdfc3a',
    messagingSenderId: '652870702671',
    projectId: 'task-manager-ba88f',
    storageBucket: 'task-manager-ba88f.firebasestorage.app',
    iosBundleId: 'com.example.taskManager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDhQdJ55Nk73sV9ltjY8kUZpdYd7bRGce0',
    appId: '1:652870702671:ios:7ec7ef8e96587890bdfc3a',
    messagingSenderId: '652870702671',
    projectId: 'task-manager-ba88f',
    storageBucket: 'task-manager-ba88f.firebasestorage.app',
    iosBundleId: 'com.example.taskManager',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD_YDr849-ViVkTW4pa3p406y4mjq07OjI',
    appId: '1:652870702671:web:1356d0c6702759d2bdfc3a',
    messagingSenderId: '652870702671',
    projectId: 'task-manager-ba88f',
    authDomain: 'task-manager-ba88f.firebaseapp.com',
    storageBucket: 'task-manager-ba88f.firebasestorage.app',
    measurementId: 'G-RSQPT3TKL6',
  );
}
