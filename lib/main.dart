import 'package:chat_demo_using_socket/message_chat_screen.dart';
import 'package:chat_demo_using_socket/messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeMessaging();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _openChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MessageChatScreen(user: _nameController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.maybeOf(context)!.size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 100),
              children: <Widget>[
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width * 0.80,
                                child: TextField(
                                  controller: _nameController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 20),
                                  keyboardType: TextInputType.text,
                                  maxLength: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          width: size.width * 0.80,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange,
                            ),
                            onPressed: _openChat,
                            child: const Text('Go to Chat', style: TextStyle(fontSize: 20, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


// import 'package:chat_demo_using_socket/callkit/app_router.dart';
// import 'package:chat_demo_using_socket/callkit/navigation_service.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:uuid/uuid.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
//   showCallkitIncoming(Uuid().v4());
// }
//
// Future<void> showCallkitIncoming(String uuid) async {
//   var params = <String, dynamic>{
//     'id': uuid,
//     'nameCaller': 'Hien Nguyen',
//     'appName': 'Callkit',
//     'avatar': 'https://i.pravatar.cc/100',
//     'handle': '0123456789',
//     'type': 0,
//     'duration': 30000,
//     'textAccept': 'Accept',
//     'textDecline': 'Decline',
//     'textMissedCall': 'Missed call',
//     'textCallback': 'Call back',
//     'extra': <String, dynamic>{'userId': '1a2b3c4d'},
//     'headers': <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
//     'android': <String, dynamic>{
//       'isCustomNotification': true,
//       'isShowLogo': false,
//       'isShowCallback': false,
//       'ringtonePath': 'system_ringtone_default',
//       'backgroundColor': '#0955fa',
//       'backgroundUrl': 'https://i.pravatar.cc/500',
//       'actionColor': '#4CAF50'
//     },
//     'ios': <String, dynamic>{
//       'iconName': 'CallKitLogo',
//       'handleType': '',
//       'supportsVideo': true,
//       'maximumCallGroups': 2,
//       'maximumCallsPerCallGroup': 1,
//       'audioSessionMode': 'default',
//       'audioSessionActive': true,
//       'audioSessionPreferredSampleRate': 44100.0,
//       'audioSessionPreferredIOBufferDuration': 0.005,
//       'supportsDTMF': true,
//       'supportsHolding': true,
//       'supportsGrouping': false,
//       'supportsUngrouping': false,
//       'ringtonePath': 'system_ringtone_default'
//     }
//   };
//   await FlutterCallkitIncoming.showCallkitIncoming(params);
// }
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   var _uuid;
//   var _currentUuid;
//
//   late final FirebaseMessaging _firebaseMessaging;
//
//   @override
//   void initState() {
//     super.initState();
//     _uuid = Uuid();
//     initFirebase();
//     WidgetsBinding.instance?.addObserver(this);
//     //Check call when open app from terminated
//     checkAndNavigationCallingPage();
//   }
//
//   getCurrentCall() async {
//     //check current call from pushkit if possible
//     var calls = await FlutterCallkitIncoming.activeCalls();
//     if (calls is List) {
//       if (calls.isNotEmpty) {
//         print('DATA: $calls');
//         this._currentUuid = calls[0]['id'];
//         return calls[0];
//       } else {
//         this._currentUuid = "";
//         return null;
//       }
//     }
//   }
//
//   checkAndNavigationCallingPage() async {
//     var currentCall = await getCurrentCall();
//     if (currentCall != null) {
//       NavigationService.instance
//           .pushNamedIfNotCurrent(AppRoute.callingPage, args: currentCall);
//     }
//   }
//
//   @override
//   Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
//     print(state);
//     if (state == AppLifecycleState.resumed) {
//       //Check call when open app from background
//       checkAndNavigationCallingPage();
//     }
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance?.removeObserver(this);
//     super.dispose();
//   }
//
//   initFirebase() async {
//     await Firebase.initializeApp();
//     _firebaseMessaging = FirebaseMessaging.instance;
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       print(
//           'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');
//       this._currentUuid = _uuid.v4();
//       showCallkitIncoming(this._currentUuid);
//     });
//     var token = await _firebaseMessaging.getAPNSToken();
//     print("Device Token APNS: $token");
//     await _firebaseMessaging.getToken().then((token) {
//       print('Device Token FCM: $token');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.light(),
//       onGenerateRoute: AppRoute.generateRoute,
//       initialRoute: AppRoute.homePage,
//       navigatorKey: NavigationService.instance.navigationKey,
//       navigatorObservers: <NavigatorObserver>[
//         NavigationService.instance.routeObserver
//       ],
//     );
//   }
//
//   Future<void> getDevicePushTokenVoIP() async {
//     var devicePushTokenVoIP =
//     await FlutterCallkitIncoming.getDevicePushTokenVoIP();
//     print(devicePushTokenVoIP);
//   }
// }