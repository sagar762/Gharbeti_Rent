import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gharbeti/controller/loginController.dart';
import 'package:gharbeti/screen/auth/HouseForm.dart';
import 'package:gharbeti/screen/auth/stepperexample.dart';
import 'package:gharbeti/widget/CustomButton.dart';
import 'package:gharbeti/widget/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../widget/Custom_text.dart';
import 'login_Screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({Key? key}) : super(key: key);

  // get keyboardType => null;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String code = '';
  final controller = Get.put(LoginController());

  // Telephony telephony = Telephony.instance;
  // OtpFieldController otpbox = OtpFieldController();

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
    print('OTP Listen is called');
  }


  // void dispose() {
  //   SmsAutoFill().unregisterListener();
  //   controller.otpController.dispose();
  //   super.dispose();
  // }
  // void onClose() {
  //
  //   controller.otpController!.dispose();
  //   SmsAutoFill().unregisterListener();
  //   super.onClose();
  // }

  void initState() {
    // _listenSmsCode();
    controller.codeController.text = '+977';
    _listenSmsCode();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final defaultPinTheme = PinTheme(
    //   width: 56.w,
    //   height: 56.h,
    //   // textStyle: const TextStyle(
    //   //   fontSize: 20,
    //   //   color: Color.fromRGBO(30, 60, 87, 1),
    //   // ),
    //   decoration: BoxDecoration(
    //     color: Color(0xFFF4F3F3),
    //     borderRadius: BorderRadius.circular(12).w,
    //   ),
    // );
    var otp = '';
    String codeValue = '';
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      body: SingleChildScrollView(
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
                        SizedBox(
                          height: 20.0.h,
                        ),
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
                            'Enter OTP',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 24.0.sp),
                          ),
                          SizedBox(
                            height: 25.0.h,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0).h,
                            child: Obx(()=>
                              PinFieldAutoFill(
                                controller: controller.otpController,
                                currentCode: controller.messageOtpCode.value,
                                // currentCode: controller.otpController.text,
                                cursor: Cursor(
                                  width: 2.w,
                                  height: 20.h,
                                  color: Colors.grey,
                                  radius: Radius.circular(1),
                                  enabled: true,
                                ),
                                autoFocus: true,
                                decoration: UnderlineDecoration(
                                  textStyle: TextStyle(
                                      fontSize: 20.sp, color: Colors.black),
                                  lineHeight: 2,
                                  lineStrokeCap: StrokeCap.square,
                                  bgColorBuilder: PinListenColorBuilder(
                                      Colors.grey.shade200, Colors.grey.shade200),
                                  colorBuilder:
                                      const FixedColorBuilder(Colors.transparent),
                                ),
                                //     decoration:
                                //     UnderlineDecoration(
                                //       textStyle: TextStyle(fontSize: 20, color: Colors.black),
                                //   colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                                // ),
                                codeLength: 6,
                                onCodeSubmitted: (value) {
                                },
                                onCodeChanged: (value) {
                                  controller.messageOtpCode.value =value!;
                                    // controller.otpController.text = value!;

                                  // Get.off(()=>BottomNavigationBarScreen());
                                },
                              ),
                            ),
                          ),
                          CustomButton(
                            text: 'Verify',
                            onPressed: () async {
                              controller.getOTP();
                              // Get.off(() => HouseInfoForm());
                              // controller.getOTP();
                            },
                            height: 135.h,
                            width: 35.w,
                          ),
                          SizedBox(
                            height: 10.0.h,
                          ),
                          Column(children: [
                            Text(
                              'Didn\'t Receive code?',
                              style: GoogleFonts.poppins(
                                  fontSize: 18.0.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => LoginScreen());
                                },
                                child: Text(
                                  'Resend Code',
                                  style: GoogleFonts.poppins(
                                      fontSize: 18.0.sp,
                                      color: AppColor.primarycolor,
                                      fontWeight: FontWeight.w600),
                                ))
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
