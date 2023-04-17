// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
//
// import '../../main.dart';
//
// class AlarmPage extends StatefulWidget {
//   @override
//   _AlarmPageState createState() => _AlarmPageState();
// }
//
// class _AlarmPageState extends State<AlarmPage> {
//   late  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//
//   @override
//   void initState() {
//     super.initState();
//     var initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOS = DarwinInitializationSettings();
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     // flutterLocalNotificationsPlugin.initialize(initializationSettings,
//     //     onDidReceiveNotificationResponse: onSelectNotification);
//   }
//
//   Future onSelectNotification(String payload) async {
//     if (payload != null) {
//       debugPrint('notification payload: $payload');
//     }
//   }
//
//   Future<void> _scheduleAlarm(DateTime scheduledNotificationDateTime) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'alarm_notif', 'Alarm notification',
//         icon: '@mipmap/ic_launcher',
//         sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
//         largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'));
//     var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
//         sound: 'a_long_cold_sting.wav',
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true);
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         'Alarm',
//         'Time to wake up!',
//         tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
//         platformChannelSpecifics,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Alarm'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             var now = DateTime.now();
//             var scheduledNotificationDateTime =
//             now.add(Duration(seconds: 10));
//             await _scheduleAlarm(scheduledNotificationDateTime);
//           },
//           child: Text('Set Alarm'),
//         ),
//       ),
//     );
//   }
// }