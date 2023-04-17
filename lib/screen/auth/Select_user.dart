import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gharbeti/screen/RentScreen/UserScreen.dart';
import 'package:gharbeti/screen/auth/HouseForm.dart';
import 'package:gharbeti/screen/auth/login_Screen.dart';
import 'package:gharbeti/screen/auth/stepperexample.dart';
import 'package:gharbeti/screen/home/BottomNavigationBar.dart';
import 'package:gharbeti/widget/CustomButton.dart';
import 'package:gharbeti/widget/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/Custom_text.dart';
import 'UserForm.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({Key? key}) : super(key: key);

  @override
  State<UserSelectionScreen> createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      body: SafeArea(
        child: Container(
          height: 850.h,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                  height: 380.0.h,
                  width: MediaQuery.of(context).size.width,
                  child: SvgPicture.asset(
                    'assets/images/Rectangle 28.svg',
                    fit: BoxFit.fill,
                  )),
              Positioned.fill(
                  top: 70.h,

                  // left: MediaQuery.of(context).size.width*0.30,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: CustomText(
                          text: 'लगइन  गर्नुहोस ',
                          fontWeight: FontWeight.w700,
                          size: 40.0.sp,
                          color: Colors.white))),
              Positioned(
                top: 200.h,
                child: Column(
                  children: [
                    CustomBox(
                      title: 'Login as Gharbeti',
                      image: 'assets/images/Group.svg',
                      onPressed: () => Get.off(() => HouseInfoForm()),
                    ),
                    SizedBox(height: 30.0.h),
                    CustomBox(
                      title: 'Login as User',
                      image: 'assets/images/Asset 2 1.svg',
                      onPressed: () => Get.off(() => UserForm()),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBox extends StatelessWidget {
  String? title;
  String? image;
  final Function()? onPressed;
  CustomBox(
      {Key? key, required this.title, required this.image, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
      child: Container(
        height: 290.h,
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
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0).h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                image!,
                height: 140.h,
              ),
              SizedBox(height: 20.0.h),
              CustomButton(
                text: '$title',
                onPressed: onPressed,
                height: 135.h,
                width: 35.w,
              )
            ],
          ),
        ),
      ),
    );
  }
}
