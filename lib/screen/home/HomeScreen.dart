import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gharbeti/model/HomeModel.dart';
import 'package:gharbeti/screen/RentScreen/FreeRoomScreen.dart';
import 'package:gharbeti/screen/RentScreen/PendingRent.dart';
import 'package:gharbeti/utils/sharedPreferences.dart';
import 'package:gharbeti/widget/CustomTextField.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import '../../main.dart';
import '../../widget/color.dart';
import 'package:get/get.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// Future showNotification() async {
//   // int rndmIndex = Random().nextInt(StaticVars().smallDo3a2.length - 1);
//
//   AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     '1',
//     'BillInfo',
//     importance: Importance.max,
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
//   await flutterLocalNotificationsPlugin.show(
//     1,
//     'Bill Info',
//     'Please Pay the Bill',
//     platformChannelSpecifics,
//   );
// }
//
// void callbackDispatcher() {
//   // initial notifications
//   var initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   var initializationSettingsIOS = DarwinInitializationSettings();
//
//   var initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsIOS,
//   );
//
//   // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   WidgetsFlutterBinding.ensureInitialized();
//
//   flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//   );
//
//   Workmanager().executeTask((task, inputData) {
//     showNotification();
//     return Future.value(true);
//   });
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedVal = 'Ghar 1';
  var items = ['Ghar 1', 'Ghar 2'];
  String? username;
  // String? formattedDate;
  @override
  void initState() {
    // Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    initializeDateFormatting();
    getPrefs();

    // TODO: implement initState
    super.initState();
  }

  void getPrefs() async {
    setState(()  {
      username =  SharedData.getUserName();
    });

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   username = prefs.getString('UserName');
    // });
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    print(DateFormat('EEEE').format(date));
    String weekDay = DateFormat('EEEE').format(date);
    NepaliDateTime currentTime = NepaliDateTime.now();
    final formatter = NepaliDateFormat('d MMMM, y');
    final formattedDate = formatter.format(currentTime);
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                  height: 480.0.h,
                  width: MediaQuery.of(context).size.width,
                  child: SvgPicture.asset(
                    'assets/images/Rectangle 35.svg',
                    fit: BoxFit.fill,
                  )),
              Positioned(
                  top: 20.0.h,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.sp,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello ${username}',
                              style: GoogleFonts.poppins(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Text(
                              '${_selectedVal} is inactive',
                              style: GoogleFonts.poppins(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Text(
                              '${weekDay}, ${formattedDate}',
                              style: GoogleFonts.poppins(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Text(
                              'You are managing ${_selectedVal}',
                              style: GoogleFonts.poppins(
                                  fontSize: 18.0.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                        child: SizedBox(
                          height: 40.h,
                          width: 110.w,
                          child: DropdownButtonFormField(
                            value: _selectedVal,
                            items: items
                                .map((e) => DropdownMenuItem(
                                    child: Text(
                                      e,
                                      style: GoogleFonts.poppins(
                                          fontSize: 16.0.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    value: e))
                                .toList(),
                            onChanged: (val) async {
                              setState(
                                () {
                                  setState(() {
                                    _selectedVal = val as String;
                                  });
                                },
                              );
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColor.primarycolor,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.r, 0, 0, 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0.w, color: AppColor.primarycolor),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(6.0).w,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              Positioned(
                top: 160.0.h,
                child: Container(
                    height: 410.h,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => PendingRentScreen());
                                },
                                child: CustomBox(
                                  title: 'Pending Rent',
                                  number: 2,
                                )),
                            CustomBox(
                              title: 'Completed Rent',
                              number: 5,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        Row(
                          children: [
                            CustomBox(
                              title: 'Occupied Rooms',
                              number: 9,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => FreeRoomScreen());
                                },
                                child: CustomBox(
                                  title: 'Free Rooms',
                                  number: 2,
                                ))
                          ],
                        ),
                      ],
                    )),
              ),
              Positioned(
                  top: 500.h,
                  child: Container(
                    height: 260.h,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: contents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0.h)
                                .w,
                            child: Container(
                              height: 60.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0)
                                          .w,
                                      child: Text(
                                          contents[index].title.toString())),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0)
                                        .w,
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 18.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBox extends StatelessWidget {
  int? number;
  String? title;
  CustomBox({Key? key, this.title, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0).w,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12.0).w),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0).h,
          child: Column(
            children: [
              Text(
                '${number}',
                style: GoogleFonts.poppins(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10.0.h,
              ),
              Text(
                title!,
                style: GoogleFonts.poppins(
                    fontSize: 18.0, fontWeight: FontWeight.w300),
              )
            ],
          ),
        ),
      ),
    );
  }
}
