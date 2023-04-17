// import 'dart:async';
// import 'dart:io';
// import 'dart:ui';
import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:get/get.dart';
import 'package:gharbeti/screen/RentScreen/BillScreen.dart';
import 'package:gharbeti/screen/RentScreen/FreeRoomScreen.dart';
import 'package:gharbeti/screen/auth/HouseForm.dart';
import 'package:gharbeti/screen/auth/OtpScreen.dart';
import 'package:gharbeti/screen/auth/SplashScreen.dart';
import 'package:gharbeti/screen/auth/login_Screen.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gharbeti/screen/auth/stepperexample.dart';
import 'package:gharbeti/screen/home/BottomNavigationBar.dart';
import 'package:gharbeti/screen/home/HomeScreen.dart';
import 'package:gharbeti/screen/home/ProfileScreen.dart';
import 'package:gharbeti/utils/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

import 'model/ApiConfig.dart';
import 'model/BillModeL.dart';


int? isViewed;
bool? seen;

// FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
//
// Future showNotification() async {
//   // int rndmIndex = Random().nextInt(StaticVars().smallDo3a2.length - 1);
//
//   AndroidNotificationDetails androidPlatformChannelSpecifics =
//   AndroidNotificationDetails(
//     '1',
//     'Bill Info',
//     importance: Importance.high,
//     priority: Priority.high,
//     playSound: true,
//     enableVibration: true,
//   );
//   var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
//     threadIdentifier: 'thread_id',
//   );
//   var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics);
//
//   await flutterLocalNotificationsPlugin?.show(
//     1,
//     'Bill Info',
//     'Please pay the Bill',
//     platformChannelSpecifics,
//   );
// }
//
// void callbackDispatcher() {
//   // initial notifications
//   var initializationSettingsAndroid =
//   AndroidInitializationSettings('@mipmap/ic_launcher');
//   var initializationSettingsIOS = DarwinInitializationSettings();
//
//   var initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsIOS,
//   );
//
//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   WidgetsFlutterBinding.ensureInitialized();
//
//   flutterLocalNotificationsPlugin?.initialize(
//     initializationSettings,
//   );
//
//   Workmanager().executeTask((task, inputData) {
//     showNotification();
//     return Future.value(true);
//   });
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // await Permission.notification.isDenied.then((value) {
  //   if (value) {
  //     Permission.notification.request();
  //   }
  // });
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Schedule a background task to send the notification
  // await FlutterBackground.scheduleTask(
  //   task: sendNotification,
  //   name: "Send Notification",
  //   initialDelay: Duration(seconds: 10),
  // );
  // await FirebaseMessaging.instance.getInitialMessage();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // late AppLifecycleState _notification;

  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   setState(() {
  //     _notification = state;
  //   });
  // }

  @override
  void initState() {

    // Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
  }
  // Future<List<BillModeL>> getUserBillDetails() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String uid = prefs.getString('rentId') ?? '';
  //   print(uid);
  //   final response = await http.get(Uri.parse(ApiConfig.baseUrl+'api/bill?rent_id='+uid));
  //   print(response.body);
  //   if(response.statusCode==200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((data) => BillModeL.fromJson(data)).toList();
  //   } else {
  //     throw Exception('Unexcepted error occured');
  //   }
  // }

  bool allowClose = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // initialRoute: isViewed == 0 || isViewed == null ? "first" : "/",
            // routes: {
            //   '/': (context) => SteperFormScreen(),
            //   "first": (context) => LoginScreen(),
            // },
            home: SplashScreen()
            // home: isViewed!=0 ? SteperFormScreen(): LoginScreen(),
            );
      },
    );
  }
}


// Future<void> _showNotification() async {
//   const androidDetails = AndroidNotificationDetails(
//     'channelId',
//     'channelName',
//     importance: Importance.high,
//     priority: Priority.high,
//   );
//
//   const iOSDetails = DarwinNotificationDetails();
//
//   const notificationDetails =
//   NotificationDetails(android: androidDetails, iOS: iOSDetails);
//
//   await FlutterLocalNotificationsPlugin().show(
//     0,
//     'Title',
//     'Message',
//     notificationDetails,
//   );
// }






// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// void main() async {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   FlutterLocalNotificationsPlugin localNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//   initializeNotifications() async {
//     var initializeAndroid = AndroidInitializationSettings('ic_launcher');
//     var initializeIOS = DarwinInitializationSettings();
//     var initSettings = InitializationSettings(android: initializeAndroid);
//     await localNotificationsPlugin.initialize(initSettings);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     initializeNotifications();
//   }
//
//   Future singleNotification(
//       DateTime datetime, String message, String subtext, int hashcode,
//       { String? sound}) async {
//     var androidChannel = AndroidNotificationDetails(
//       'channel-id',
//       'channel-name',
//       importance: Importance.max,
//       priority: Priority.max,
//     );
//
//     var iosChannel = DarwinNotificationDetails();
//     var platformChannel = NotificationDetails(android: androidChannel);
//     localNotificationsPlugin.schedule(
//         hashcode, message, subtext, datetime, platformChannel,
//         payload: hashcode.toString());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notification/Alarm Example'),
//       ),
//       body: Center(
//         child: Container(
//           child: Text('Notification App'),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.notifications),
//         onPressed: () async {
//           DateTime now = DateTime.now().toUtc().add(
//             Duration(minutes: 1),
//           );
//           await singleNotification(
//             now,
//             "Notification",
//             "This is a notification",
//             98123871,
//           );
//         },
//       ),
//     );
//   }
// }
