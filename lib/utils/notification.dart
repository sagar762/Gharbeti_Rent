import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
    );
        // onDidReceiveLocalNotification:
        //     (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        // onDidReceiveNotificationResponse:
        //     (NotificationResponse notificationResponse) async {}
    );
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 2, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
  Future scheduleNotification(
      {int id = 2, String? title, String? body, String? payLoad, required DateTime scheduledNotificationDateTime}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }


}



class NotificationServices {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        // onDidReceiveLocalNotification:
        //     (int id, String? title, String? body, String? payload) async {}
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        // onDidReceiveNotificationResponse:
        //     (NotificationResponse notificationResponse) async {}
    );
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 2, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
      {int id = 2,
        String? title,
        String? body,
        String? payLoad,
        required DateTime scheduledNotificationDateTime}) async {
    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }
}
//
// import 'dart:async';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationService {
//   late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
//   var initializationSettings;
//
//   NotificationService() {
//     _initializeNotifications();
//   }
//
//   Future<void> _initializeNotifications() async {
//     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     initializationSettings = await _initializePlatformSpecifics();
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   Future<InitializationSettings> _initializePlatformSpecifics() async {
//     InitializationSettings initializationSettings =
//     InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: DarwinInitializationSettings(),
//     );
//     return initializationSettings;
//   }
//
//   Future<void> scheduleNotification(String title, String message,
//       int notificationId, DateTime scheduledDate) async {
//     await AndroidAlarmManager.initialize();
//     await AndroidAlarmManager.oneShotAt(
//       scheduledDate,
//       notificationId,
//       _showNotification,
//       alarmClock: true,
//       exact: true,
//       wakeup: true,
//     );
//   }
//
//   Future<void> _showNotification(int id) async {
//     await _flutterLocalNotificationsPlugin.show(
//       id,
//       'Notification Title',
//       'Notification Message',
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//             'channel_id', 'channel_name', ),
//       ),
//     );
//   }
// }
