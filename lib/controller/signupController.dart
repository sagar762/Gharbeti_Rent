import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:gharbeti/model/Class_ModeL.dart';
import 'package:gharbeti/screen/auth/HouseForm.dart';
import 'package:gharbeti/screen/auth/stepperexample.dart';
import 'package:gharbeti/screen/home/BottomNavigationBar.dart';
import 'package:gharbeti/screen/home/ProfileScreen.dart';
import 'package:gharbeti/utils/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharbeti/screen/auth/login_Screen.dart';
import 'package:gharbeti/widget/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/ApiConfig.dart';

class SignUpController extends GetxController{

  int _index = 0;
  var formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // final TextEditingController locationController = TextEditingController();
  TextEditingController? locationController;
  String? address;
  String? name;
  String? email;
  String? location;
  String? phoneNumber;
  void getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      name = prefs.getString('UserName');
      email = prefs.getString('Email');
      location = prefs.getString('Address');
      phoneNumber = prefs.getString('PhoneNumber');
      update();
  }

  static preferences() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString('address') ?? '';
  }
  void onInit() async {
    getPrefs();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // address = prefs.getString('address') ?? "";
    // locationController.text = address!;
    locationController = new TextEditingController (text: prefs.getString('address') ?? "");
    super.onInit();

  }
  final User = '/api/user';


  void createUser(BuildContext context, {String? address, String? city, String? name, String? email, String? mapLocation, String? phoneNumber}) async{
    String? userAddress;
    String? userId;

    try {
      var body = jsonEncode({'address': address, 'city': city, 'name': name, 'email': email, "phone_number": phoneNumber, 'map_location': mapLocation});
      var response = await http.post(Uri.parse(ApiConfig.baseUrl + User), headers: {HttpHeaders.contentTypeHeader: "application/json"}, body: body);
      // print(response.body.toString());
      if(response.statusCode==201 && formKey.currentState!.validate()){
        await SharedData.setEmail(email);
        await SharedData.setUserName(name);
        await SharedData.setPhoneNumber(phoneNumber);
        await SharedData.setUserCity(city);
        // print(SharedData.getEmail());
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        userAddress = prefs.setString('Address', address!).toString();
        print(prefs.getString('UserName'));
        print(prefs.getString('Email'));
        print(prefs.getString('City'));
        print(prefs.getString('PhoneNumber'));

        String responseBody = response.body.toString();
        final responseData = json.decode(response.body);
        final boolResponse = responseData['user']['isPhoneVerified'];
        prefs.setBool('isPhoneVerified', boolResponse);
        print(prefs.getBool('isPhoneVerified'));

        final id = extractidFromResponse(response.body).toString();
        userId = prefs.setString('id', id).toString();
        final uuid = extractuidFromResponse(response.body).toString();
        prefs.setString('uuid', uuid);
        Get.showSnackbar(
          GetSnackBar(
            title: 'Success',
            message: 'User Registered Successfully',
            backgroundColor: AppColor.primarycolor,
            duration: const Duration(seconds: 3),
          ),
        );
        Get.to(()=>LoginScreen(
        ));
        nameController.clear();
        phoneNoController.clear();
        houseController.clear();
        cityController.clear();
        emailController.clear();
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Failed',
            message: '${response.body}',
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }

    } catch(e) {
      print(e);
    }

  }

  String extractidFromResponse(String responseBody) {
    final decodedResponse = json.decode(responseBody);
    return decodedResponse['user']['id'].toString();
  }
  String extractuidFromResponse(String responseBody) {
    final decodedResponse = json.decode(responseBody);
    return decodedResponse['user']['uuid'].toString();
  }

  void updateProfile(BuildContext context, {String? name, String? email, String? phoneNumber, String? address}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uuid').toString();
    final putUser = "api/user/";
    var body = jsonEncode({"name":name, "email":email, "phone_number": phoneNumber, "address" : address});
    var response = await http.put(Uri.parse(ApiConfig.baseUrl+putUser+uuid), headers: {HttpHeaders.contentTypeHeader: "application/json"}, body: body);

    if(response.statusCode == 202) {
      prefs.setString('userName', name!);
      prefs.setString('email', email!);
      prefs.setString('Address', address!);
      prefs.setString('phoneNumber', phoneNumber!);
      // print(prefs.getString('UserName'));
      Get.showSnackbar(
        GetSnackBar(
          title: 'Success',
          message: 'User Updated Successfully',
          backgroundColor: AppColor.primarycolor,
          duration: const Duration(seconds: 3),
        ),
      );
      // Get.back();
      // Navigator.of(context).pop();
      Get.to(()=>BottomNavigationBarScreen());
      // update();
    } else {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Failed',
          message: '${response.body}',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }


}