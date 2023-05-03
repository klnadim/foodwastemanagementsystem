import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User not granted permission');
    } else {
      AppSettings.openNotificationSettings();
      print('User not granted permission');
    }
  }

  Future selectNotification(payload) async {
    //Handle notification tapped logic here
  }
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        "channelName",
        "channelDescription",
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id, channel.name, channel.description,
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');
    // var iosInitializationSettings = DarwinIni

    var initializationSetting =
        InitializationSettings(android: androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onSelectNotification: selectNotification,
    );
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }

      showNotification(message);
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();

    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print("Refresh");
    });
  }

// //Another Notification testing

//   void registerDeviceForFCM() {
//     // Request permission for iOS devices
//     messaging.requestPermission();

//     // Configure FirebaseMessaging for Android devices
//     messaging.getToken().then((token) {
//       print('FCM Token: $token');
//       // Save the token to your Firestore database or use it to send push notifications
//     });
//   }

//   void saveFCMToken(String userId, String token) {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .update({'fcmToken': token});
//   }

//   void listenToCollection(String userId) {
//     FirebaseFirestore.instance
//         .collection('foodRequest')
//         .where('userId', isEqualTo: userId)
//         .snapshots()
//         .listen((snapshot) {
//       // Handle changes to the collection here
//       // If a new document is added to the collection, send a notification to the user's device
//     });
//   }

//   void sendNotificationToUser(String userId, String title, String body) {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .get()
//         .then((doc) {
//       String fcmToken = doc['fcmToken'];

//       if (fcmToken != null) {
//         // Set up the message data

//         // final message = RemoteMessage(

//         //   notification: RemoteNotification(
//         //     title: title,
//         //     body: body,
//         //   ),
//         //   data: {
//         //     'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//         //     'id': '1',
//         //     'status': 'done'
//         //   },
//         //   token: fcmToken,
//         // );

//         // Send the message to the user's device
//         messaging.sendMessage(data: {
//           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//           'id': '1',
//           'status': 'done'
//         }, messageId: fcmToken);
//       }
//     });
//   }
}
