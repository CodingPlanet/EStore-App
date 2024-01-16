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
    apiKey: 'AIzaSyBk9rqZ6vghA5_ZfAOTm0tk5l4qxHzsTvE',
    appId: '1:786039599810:web:3ccf044ce873f4dd38015b',
    messagingSenderId: '786039599810',
    projectId: 'estore-app-b51e7',
    authDomain: 'estore-app-b51e7.firebaseapp.com',
    storageBucket: 'estore-app-b51e7.appspot.com',
    measurementId: 'G-FWC8C42LF0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChrww3jNWgKGNphInES1Mm3fCFvObwGk4',
    appId: '1:786039599810:android:69bd497e19d65d0a38015b',
    messagingSenderId: '786039599810',
    projectId: 'estore-app-b51e7',
    storageBucket: 'estore-app-b51e7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOGbJM8Z6j4dUO0U23e0mIhfecYA40iEU',
    appId: '1:786039599810:ios:aac1c13638cd3f9c38015b',
    messagingSenderId: '786039599810',
    projectId: 'estore-app-b51e7',
    storageBucket: 'estore-app-b51e7.appspot.com',
    iosClientId: '786039599810-l9vdtfi5jmu7p3vhcocbt5jrtl396tn8.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecom',
  );
}
