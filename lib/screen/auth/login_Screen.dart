import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gharbeti/controller/ExitController.dart';
import 'package:gharbeti/controller/loginController.dart';
import 'package:gharbeti/screen/auth/OtpScreen.dart';
import 'package:gharbeti/screen/auth/Select_user.dart';
import 'package:gharbeti/screen/auth/Signup_Screen.dart';
import 'package:gharbeti/screen/auth/stepperexample.dart';
import 'package:gharbeti/screen/home/BottomNavigationBar.dart';
import 'package:gharbeti/widget/CustomButton.dart';
import 'package:gharbeti/widget/Custom_text.dart';
import 'package:gharbeti/widget/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:workmanager/workmanager.dart';
//import 'package:sms_autofill/sms_autofill.dart';
import '../../main.dart';
import '../../utils/notification.dart';
import '../../validators/validators.dart';
import '../../widget/CustomTextField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool allowClose = false;
var phone = '';
int? resend_token;

class _LoginScreenState extends State<LoginScreen> {

  String? _currentAddress;
  Position? _currentPosition;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.off(() => LoginScreen());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) async {
      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    });
  }



  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();
  // Future<void> _requestPermission() async {
  //   // print('hello');
  //   // Request notification permissions
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.notification,
  //   ].request();
  //
  //   // Handle the result of the permissions request
  //   if (statuses[Permission.notification] != PermissionStatus.granted) {
  //     print('hello');
  //     // Permissions not granted, show error message or disable functionality
  //     return;
  //   }
  // }


  @override
  // static GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final controller = Get.put(LoginController());
  final exitController = Get.put(ExitController());
  @override
  void initState() {
    // _listenSmsCode();
    // _requestPermission();
    _getCurrentPosition();
    getPrefs();
    // getToken();
    // initInfo();
    // requestPermission();
    controller.codeController.text = '+977';
    // TODO: implement initState
    super.initState();
  }

  void getPrefs() async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

      prefs.setDouble('longitude',
          _currentPosition!.longitude) ??
          '';
      prefs.setDouble('latitude',
          _currentPosition!.latitude) ??
          '';
      print(prefs.getDouble('longitude'));


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      body: WillPopScope(
        onWillPop: exitController.onExit,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: controller.formKey1,
            child: Container(
              height: 850.h,
              child: Stack(
                children: [
                  Container(
                      height: 450.0.h,
                      width: MediaQuery.of(context).size.width,
                      child: SvgPicture.asset(
                        'assets/images/Rectangle 28.svg',
                        fit: BoxFit.fill,
                      )),
                  Positioned.fill(
                    top: 90.0.h,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0).w,
                        child: Column(
                          children: [
                            CustomText(
                              text: 'घरबेटी बा',
                              fontWeight: FontWeight.w700,
                              size: 40.0.sp,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                            CustomText(
                              text: 'घरभाडा अब नो चिन्ता',
                              fontWeight: FontWeight.w400,
                              size: 25.0.sp,
                              color: Colors.white,
                            ),
                            SizedBox(height: 20.0.h),
                            CustomText(
                                text: 'लगइन  गर्नुहोस ',
                                fontWeight: FontWeight.w700,
                                size: 30.0.sp,
                                color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 270.h,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
                      child: Container(
                        // margin: EdgeInsets.all(30.0),
                        height: 315.h,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0).w,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 15.0,
                                offset: Offset(
                                  0.0,
                                  0.75,
                                ),
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0).h,
                          child: Column(
                            children: [
                              Text(
                                'Login',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 30.0.sp),
                              ),
                              SizedBox(
                                height: 20.0.h,
                              ),
                              // CustomTextField(hint: 'Phone Number', prefixIcon: Icon(Icons.phone, color: AppColor.primarycolor,),),
                              CustomTextField(
                                  hint: 'Phone Number',
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: AppColor.primarycolor,
                                  ),
                                  textInputType: TextInputType.phone,
                                  controller: controller.phoneNo,
                                  validator: Validator.checkPhoneField),
                              SizedBox(
                                height: 20.0.h,
                              ),
                              Text(
                                'A five digit code will be sent to your mobile number',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0.sp),
                              ),
                              SizedBox(
                                height: 20.0.h,
                              ),
                              CustomButton(
                                text: 'Proceed',
                                onPressed: () async {
                                  // Get.off(()=> StepperScreen());
                                  // Get.off(()=>UserSelectionScreen());
                                  controller.verifyPhoneNumber(context,
                                      PhoneNumber: controller.phoneNo.text);
                                  // controller.sendOTP();
                                },
                                height: 135.h,
                                width: 35.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                      top: 650.h,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(children: [
                          Text(
                            'Don\'t have an account? ',
                            style: GoogleFonts.poppins(
                                fontSize: 20.0.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          TextButton(
                              onPressed: () async {
                                // _requestPermission();

                                Get.off(() => SignUpScreen());
                              },
                              child: Text(
                                'REGISTER',
                                style: GoogleFonts.poppins(
                                    fontSize: 18.0.sp,
                                    color: AppColor.primarycolor,
                                    fontWeight: FontWeight.w600),
                              ))
                        ]),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
