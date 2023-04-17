import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gharbeti/controller/ExitController.dart';
import 'package:gharbeti/screen/RentScreen/FreeRoomScreen.dart';
import 'package:gharbeti/screen/RentScreen/PendingRent.dart';
import 'package:gharbeti/screen/auth/login_Screen.dart';
import 'package:gharbeti/screen/auth/stepperexample.dart';
import 'package:gharbeti/screen/home/ThirdScreen.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:gharbeti/widget/color.dart';
import 'package:workmanager/workmanager.dart';
import 'HomeScreen.dart';
import 'ProfileScreen.dart';
import 'SecondScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {

  final controller = Get.put(ExitController());
  int currentTab= 0;
  bool allowClose = false;

  final List<Widget> screens = [
    HomeScreen(),
    ProfileScreen(),
    PendingRentScreen(),
    ThirdScreen()
  ];

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();
  bool _doubleTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(

          onWillPop: () async{
            if(_doubleTapped) {
              Get.off(()=>LoginScreen());
              return true;
            }
            _doubleTapped = true;
            Get.showSnackbar(
              GetSnackBar(
                title: 'EXIT',
                message: 'Tap again to exit.',
                backgroundColor: AppColor.primarycolor,
                duration: const Duration(seconds: 2),
              ),
            );
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     backgroundColor: AppColor.primarycolor,
            //     content: Text('Tap again to exit'),
            //     duration: Duration(seconds: 2),
            //   ),
            // );

            Timer(Duration(seconds: 2), () {
              _doubleTapped = false;
            });

            return false;
          },
          child: PageStorage(bucket: bucket, child: currentScreen,)),

      bottomNavigationBar: Container(
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          // notchMargin: 10,
          child: Container(

            // padding: EdgeInsets.only(left: 8.0, right: 8.0),
              height: 60.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButtonScreen(currentScreens: HomeScreen(), onPressed: (){
                    setState(() {
                      currentScreen = HomeScreen();
                      currentTab= 0;
                    });
                  },
                    path: 'assets/images/Home.svg',
                    color: currentTab==0? AppColor.primarycolor: Color(0xFFB3B3B3),
                    color1: currentTab == 0 ? AppColor.primarycolor : Colors.white,
                    width: currentTab == 0 ? 5.w :5.w,
                  ),
                  MaterialButtonScreen(currentScreens: PendingRentScreen(), onPressed: (){
                    setState(() {
                      currentScreen= PendingRentScreen();
                      currentTab = 1 ;
                    });
                  },
                    path: 'assets/images/bottomNav2.svg',
                    color: currentTab==1? AppColor.primarycolor: Color(0xFFB3B3B3),
                    color1: currentTab == 1 ? AppColor.primarycolor : Colors.white,
                    width: currentTab == 1 ? 5.w :5.w,
                  ),
                  MaterialButtonScreen(currentScreens: ThirdScreen(), onPressed: (){
                    setState(() {
                      currentScreen = ThirdScreen();
                      currentTab = 2;
                    });
                  },
                    path: 'assets/images/inactive.svg',
                    color: currentTab==2? AppColor.primarycolor :  Color(0xFFB3B3B3),
                    color1: currentTab == 2 ? AppColor.primarycolor : Colors.white,
                    width: currentTab == 2 ? 5.w :5.w ,
                  ),
                  MaterialButtonScreen(currentScreens: ProfileScreen(), currentTab: 3, onPressed: () {
                    setState(() {
                      currentScreen = ProfileScreen();
                      currentTab = 3 ;
                    });
                  },
                    path: 'assets/images/inactive1.svg',
                    color: currentTab==3? AppColor.primarycolor : Color(0xFFB3B3B3),
                    color1: currentTab == 3 ? AppColor.primarycolor : Colors.white ,
                    width: currentTab == 3 ? 5.w :5.w,
                  ),
                ],
              )
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton(

            backgroundColor: AppColor.primarycolor,
            child: Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> FreeRoomScreen()));

            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked

    );
  }
}
class MaterialButtonScreen extends StatelessWidget {
  // bool allowClose = false;
  
  // final List<Widget> screens = [
  //   HomeScreen(),
  //   ProfileScreen(),
  //   PendingRentScreen()
  // ];
  final Widget? svgPicture;
  final String? path;
  final Color? color;
  final Color? color1;
   Widget? currentScreens;
  final Function()? onPressed;
  int? currentTab;
  double? width;
  MaterialButtonScreen({Key? key, this.color1, this.color, this.path, this.svgPicture, required this.currentScreens, this.onPressed, this.currentTab, this.width}) : super(key: key);

  // Widget? currentScreen;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40.w,
      onPressed: onPressed,
      child: Column(


        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(path!, height: 25.h, color: color,),
          SizedBox(height: 2.0.h,),
          // color:currentTab==currentTab? AppColor.primarycolor : Color(0xFFB3B3B3),
          Container(
            height: 5.h,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: color1,
                // color:currentTab == currentTab ? AppColor.primarycolor : Colors.white
            ),
          ),
        ],
      ),
    );
  }
}



