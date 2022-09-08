import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';

final FirebaseMessaging _fcm = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
AndroidNotificationChannel? channel;

var data =  GetStorage();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;
var didReceiveLocalNotificationSubject;
var selectNotificationSubject;

initializeMessaging() async {
  await Firebase.initializeApp();

  await _fcm.setAutoInitEnabled(true);
  var token;

  // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'dispose_channel',
            channelKey: '10',
            channelName: 'Dispose notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      debug: true,
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  if (Platform.isIOS) {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission IOS : ${settings.authorizationStatus}');
    token = await _fcm.getAPNSToken();
    var fcmToken = await _fcm.getToken();
    print("iOS APN ::: $token");
    print("iOS FCM ::: $fcmToken");

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  } else {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission ANDROID : ${settings.authorizationStatus}');
    token = await _fcm.getToken();
    print('Android FCM ::: ${token.toString()}');

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("app_icon");
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
        int id,
        String? title,
        String? body,
        String? payload,
      ) async {
        didReceiveLocalNotificationSubject.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      });
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin?.initialize(initializationSettings, onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    selectedNotificationPayload = payload;
    selectNotificationSubject.add(payload);
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print("onMessage: $message");
    await onForeground(message);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

onForeground(RemoteMessage message) async {
  print("Notification Foreground");

  var bodyTopic = message.notification;
  print(message.toMap());
  print('topic Title :::: ${bodyTopic!.title}');
  print('topic Body :::: ${bodyTopic.body}');

  if (message.notification != null) {
    // const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //   "20",
    //   'topic_channel',
    //   channelDescription: 'topic_channel',
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   playSound: true,
    //   ticker: 'ticker',
    //   visibility: NotificationVisibility.public,
    //   channelShowBadge: true,
    //   icon: 'app_icon',
    // );
    // const IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
    //   presentAlert: true,
    //   presentBadge: true,
    //   presentSound: true,
    // );
    // const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    //
    // if (Platform.isAndroid) {
    //   flutterLocalNotificationsPlugin!.  (
    //     0,
    //     bodyTopic.title,
    //     bodyTopic.body,
    //     platformChannelSpecifics,
    //     payload: 'item x',
    //   );
    // }

    if(Platform.isAndroid){
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 10,
              channelKey: '10',
              title: 'Simple Notification',
              body: 'Simple body'
          )
      );
    }
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Notification Terminated");

  var bodyTopic = message.notification;
  print(message.toMap());
  print('topic Title :::: ${bodyTopic!.title}');
  print('topic Body :::: ${bodyTopic.body}');

  // const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //   "20",
  //   'topic_channel',
  //   channelDescription: 'topic_channel',
  //   importance: Importance.max,
  //   priority: Priority.high,
  //   playSound: true,
  //   ticker: 'ticker',
  //   visibility: NotificationVisibility.public,
  //   channelShowBadge: true,
  //   icon: 'app_icon',
  // );
  // const IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
  //   presentAlert: true,
  //   presentBadge: true,
  //   presentSound: true,
  // );
  // const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);
  // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //
  // if(Platform.isAndroid){
  //   flutterLocalNotificationsPlugin!.cancelAll();
  // }
  print("keyB1 :::: ${data.read("key")}");
  AwesomeNotifications().cancel(int.parse(data.read("key")));
  print("keyB2 :::: ${data.read("key")}");
  data.write("key", message.messageId!);
  print("keyA :::: ${data.read("key")}");
}
