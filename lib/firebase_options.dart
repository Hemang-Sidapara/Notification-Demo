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
    apiKey: 'AIzaSyAoam8J5GTWurc3FQoa462vSI1W-883Fpg',
    appId: '1:30847027493:web:f649c3cf57da69640e32cc',
    messagingSenderId: '30847027493',
    projectId: 'chatdemo-2d5f3',
    authDomain: 'chatdemo-2d5f3.firebaseapp.com',
    storageBucket: 'chatdemo-2d5f3.appspot.com',
    measurementId: 'G-1LQYYH3G0B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZ578kq6Cnt6UsUECowo9qsvBY7SpHdmU',
    appId: '1:30847027493:android:9ff9ffc75f6f10870e32cc',
    messagingSenderId: '30847027493',
    projectId: 'chatdemo-2d5f3',
    storageBucket: 'chatdemo-2d5f3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgToSapKKh5KHAjknjOFww-brvJWxzw4A',
    appId: '1:30847027493:ios:899cc9e6a17b7ae40e32cc',
    messagingSenderId: '30847027493',
    projectId: 'chatdemo-2d5f3',
    storageBucket: 'chatdemo-2d5f3.appspot.com',
    iosClientId: '30847027493-i23u2jvq43ojlkm65qdqkt3mrlodn960.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatDemoUsingSocket',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDgToSapKKh5KHAjknjOFww-brvJWxzw4A',
    appId: '1:30847027493:ios:899cc9e6a17b7ae40e32cc',
    messagingSenderId: '30847027493',
    projectId: 'chatdemo-2d5f3',
    storageBucket: 'chatdemo-2d5f3.appspot.com',
    iosClientId: '30847027493-i23u2jvq43ojlkm65qdqkt3mrlodn960.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatDemoUsingSocket',
  );
}
