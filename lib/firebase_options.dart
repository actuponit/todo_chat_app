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
    apiKey: 'AIzaSyBihSCkTkFduCKCxKGlSVEYMQLsVwtxnmc',
    appId: '1:222203623140:web:4a9fc7c37f34691551def1',
    messagingSenderId: '222203623140',
    projectId: 'mobile-challenge-e888b',
    authDomain: 'mobile-challenge-e888b.firebaseapp.com',
    databaseURL: 'https://mobile-challenge-e888b-default-rtdb.firebaseio.com',
    storageBucket: 'mobile-challenge-e888b.appspot.com',
    measurementId: 'G-Y5KB5188B9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNsbdEtQbyoC4ysOg_13TbRuQYKH4-zQ0',
    appId: '1:222203623140:android:6383183dc021692251def1',
    messagingSenderId: '222203623140',
    projectId: 'mobile-challenge-e888b',
    databaseURL: 'https://mobile-challenge-e888b-default-rtdb.firebaseio.com',
    storageBucket: 'mobile-challenge-e888b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2IMiZhCkOFD7BUsgN1c0JQL6vhQS69yg',
    appId: '1:222203623140:ios:6b4f49b2bc4e296651def1',
    messagingSenderId: '222203623140',
    projectId: 'mobile-challenge-e888b',
    databaseURL: 'https://mobile-challenge-e888b-default-rtdb.firebaseio.com',
    storageBucket: 'mobile-challenge-e888b.appspot.com',
    iosBundleId: 'com.example.todoChatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA2IMiZhCkOFD7BUsgN1c0JQL6vhQS69yg',
    appId: '1:222203623140:ios:6b4f49b2bc4e296651def1',
    messagingSenderId: '222203623140',
    projectId: 'mobile-challenge-e888b',
    databaseURL: 'https://mobile-challenge-e888b-default-rtdb.firebaseio.com',
    storageBucket: 'mobile-challenge-e888b.appspot.com',
    iosBundleId: 'com.example.todoChatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBihSCkTkFduCKCxKGlSVEYMQLsVwtxnmc',
    appId: '1:222203623140:web:b97fc30716345ae051def1',
    messagingSenderId: '222203623140',
    projectId: 'mobile-challenge-e888b',
    authDomain: 'mobile-challenge-e888b.firebaseapp.com',
    databaseURL: 'https://mobile-challenge-e888b-default-rtdb.firebaseio.com',
    storageBucket: 'mobile-challenge-e888b.appspot.com',
    measurementId: 'G-9T5ECKHT0V',
  );

}