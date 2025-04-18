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
    apiKey: 'AIzaSyBXRdPgTXshqeS-QOgpkCNvRKJ2nJ_a6GM',
    appId: '1:397559384827:web:103d27448378b2d5ac7e5e',
    messagingSenderId: '397559384827',
    projectId: 'blog-a064a',
    authDomain: 'blog-a064a.firebaseapp.com',
    storageBucket: 'blog-a064a.firebasestorage.app',
    measurementId: 'G-8BQSZ58NMP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPLmACm9d89j1-HfFnu7V-5D9dSDGlvLY',
    appId: '1:397559384827:android:e0ee7d6ccd6d6653ac7e5e',
    messagingSenderId: '397559384827',
    projectId: 'blog-a064a',
    storageBucket: 'blog-a064a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwKGyUYZlNQLPdnUrjs6eDCG1gIpcNuL8',
    appId: '1:397559384827:ios:7999b4388bf3f587ac7e5e',
    messagingSenderId: '397559384827',
    projectId: 'blog-a064a',
    storageBucket: 'blog-a064a.firebasestorage.app',
    iosClientId: '397559384827-d9spsohkvkjs6cqn00l0jqqcrl266sun.apps.googleusercontent.com',
    iosBundleId: 'com.example.blog.blog',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwKGyUYZlNQLPdnUrjs6eDCG1gIpcNuL8',
    appId: '1:397559384827:ios:7999b4388bf3f587ac7e5e',
    messagingSenderId: '397559384827',
    projectId: 'blog-a064a',
    storageBucket: 'blog-a064a.firebasestorage.app',
    iosClientId: '397559384827-d9spsohkvkjs6cqn00l0jqqcrl266sun.apps.googleusercontent.com',
    iosBundleId: 'com.example.blog.blog',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBXRdPgTXshqeS-QOgpkCNvRKJ2nJ_a6GM',
    appId: '1:397559384827:web:d523a98a03b7f875ac7e5e',
    messagingSenderId: '397559384827',
    projectId: 'blog-a064a',
    authDomain: 'blog-a064a.firebaseapp.com',
    storageBucket: 'blog-a064a.firebasestorage.app',
    measurementId: 'G-PKSHSTQT44',
  );
}
