import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharbeti/model/ApiConfig.dart';
import 'package:gharbeti/screen/auth/Select_user.dart';
import 'package:gharbeti/screen/auth/stepperexample.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;
import '../screen/auth/OtpScreen.dart';
// import '../screen/auth/login_Screen.dart';
import '../screen/home/BottomNavigationBar.dart';
import '../widget/color.dart';

class LoginController extends GetxController{
  var formKey1 = GlobalKey<FormState>();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final TextEditingController otpController = TextEditingController();
  var verify = ''.obs;
  int? _resendToken;
  var messageOtpCode = ''.obs;
  final FirebaseAuth auth =FirebaseAuth.instance;

  void onInit() async {
    super.onInit();
    print(SmsAutoFill().getAppSignature);
  }

  Future<void> sendOTP() async {
    // Get.off(()=>OTPScreen());
    if(formKey1.currentState!.validate()){

      await FirebaseAuth.instance.verifyPhoneNumber(

        phoneNumber: '${codeController.text+phoneNo.text}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) async{
          verify.value=verificationId;
          _resendToken = resendToken;
          print('called');
          Get.off(()=>OTPScreen());
        },
        forceResendingToken: _resendToken,
        timeout: const Duration(seconds: 25),
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verify.value;
        },
      );
      // print("App Signature : $appSignature");
    }

  }

  Future<void> getOTP() async {
    // Get.off(()=>SteperFormScreen());
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verify.value, smsCode: messageOtpCode.value);
      await auth.signInWithCredential(credential);
      Get.off(()=>UserSelectionScreen());

    } catch(e){
      print('error');
    }
  }
  
  void verifyPhoneNumber(BuildContext context, {String? PhoneNumber}) async{
    final phoneUrl = 'api/user/phone/check/verify';
    try{
      var body = jsonEncode({'phone_number':PhoneNumber});
      var response = await http.post(Uri.parse(ApiConfig.baseUrl +phoneUrl ),headers: {HttpHeaders.contentTypeHeader: "application/json"}, body: body);
      if(response.statusCode==200 && formKey1.currentState!.validate() ){
        var appSignature = await SmsAutoFill().getAppSignature;
        await FirebaseAuth.instance.verifyPhoneNumber(

          phoneNumber: '${codeController.text+phoneNo.text}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) async{
            verify.value=verificationId;
            // _resendToken = resendToken;
            Get.off(()=>OTPScreen());
            print('hello');
          },
          forceResendingToken: _resendToken,
          timeout: const Duration(seconds: 25),
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId = verify.value;
          },
        );
        print(appSignature);
        print(response.body);
        Get.showSnackbar(
          GetSnackBar(
            title: 'Please wait for an OTP code',
            message: '....',
            backgroundColor: AppColor.primarycolor,
            duration: const Duration(seconds: 5),
          ),
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        // Get.off(()=>UserSelectionScreen());
      } else if(PhoneNumber!.isEmpty) {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Failed',
            message: 'Please Enter your phoneNumber',
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      else {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Failed',
            message: 'Please Register your Phone Number',
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch(e) {
      print(e);
    }
  }

  void userSelect(BuildContext context, {String? firstPhoto, String? backPhoto, String? userId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('id');
    final url = 'api/userinfo';
    try{
      var body = jsonEncode({'citizenshipImage':firstPhoto, 'userImage': backPhoto, 'user_id':userId});
      var response = await http.post(Uri.parse(ApiConfig.baseUrl +url ),headers: {HttpHeaders.contentTypeHeader: "application/json"}, body: body);
      if(response.statusCode==201) {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Success',
            message: 'User Verified Successfull',
            backgroundColor: AppColor.primarycolor,
            duration: const Duration(seconds: 3),
          ),
        );
        Get.to(()=>BottomNavigationBarScreen());
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Failed',
            message: 'User Verified unSuccessfull',
            backgroundColor: AppColor.primarycolor,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch(e){
      print(e);
    }
  }
  String extractidFromResponse(String responseBody) {
    final decodedResponse = json.decode(responseBody);
    return decodedResponse['user']['id'].toString();
  }

  // void submit() async{
  //   if(FormKey.formKey1.currentState!.validate()){
  //     // Get.off(()=>OTPScreen());
  //     await FirebaseAuth.instance.verifyPhoneNumber(
  //
  //       phoneNumber: '${codeController.text+phoneNo.text}',
  //       verificationCompleted: (PhoneAuthCredential credential) {},
  //       verificationFailed: (FirebaseAuthException e) {},
  //       codeSent: (String verificationId, int? resendToken) async{
  //         verify=verificationId;
  //         _resendToken = resendToken;
  //         Get.off(()=>OTPScreen());
  //       },
  //       forceResendingToken: _resendToken,
  //       timeout: const Duration(seconds: 25),
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         verificationId = verify;
  //       },
  //     );
  //   }
  // }

// void onInit() async {
//     super.onInit();
//     print(await SmsAutoFill().getAppSignature);
//     await SmsAutoFill().listenForCode();
// }
//
// void onClose() {
//     super.onClose();
//     SmsAutoFill().unregisterListener();
// }
}