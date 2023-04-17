
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gharbeti/model/ApiConfig.dart';
import 'package:gharbeti/screen/home/ProfileScreen.dart';
import 'package:gharbeti/utils/sharedPreferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../screen/home/BottomNavigationBar.dart';
import '../widget/color.dart';

class SteperController extends GetxController {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  TextEditingController gharbetiName = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController numberOfRoomController = TextEditingController();
  TextEditingController electricityController = TextEditingController();
  TextEditingController waterController = TextEditingController();
  TextEditingController wasteController = TextEditingController();
  TextEditingController extraChargeController = TextEditingController();
  TextEditingController gharbetiEmailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController1 = TextEditingController();
  TextEditingController wifiController = TextEditingController();
  TextEditingController otherServicesController = TextEditingController();
  int index = 0;
  String base64Image = "";



  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

   // static final formKey = GlobalKey<FormState>();
  String image = '';

  // String image = '';
  //  String selectedImagePath = '';

  void getprefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    addressController.text = prefs.getString('textaddress') ?? '';
  }
  void CreateGharbeti(BuildContext context, {String? gharbetiName, String? user_name, String? houseNumber, String? numberOfRooms, String? userEmail, String? city, String? location, String? id, String? phoneNumber, String? address, String? imagePath}) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final User = 'api/ghar';
    id = prefs.getString('id');
    user_name= SharedData.getUserName();
    phoneNumber = SharedData.getPhoneNumber();
    address = SharedData.getUserCity();
    imagePath = prefs.getString('ImagePath')!;
    userEmail = SharedData.getEmail();
    print(id);
    try{
      var body = jsonEncode({'ghar_name': gharbetiName, 'ghar_number': houseNumber, 'user_email': userEmail, 'user_location':location, 'user_city': city, 'user_id':id, 'ghar_location':addressController.text, 'user_name': user_name, 'user_phone':phoneNumber, 'user_address':address, 'bill_image':imagePath});
      var response = await http.post(Uri.parse(ApiConfig.baseUrl+User),headers: {HttpHeaders.contentTypeHeader: "application/json"}, body: body);
      if(response.statusCode==201){
        final id = extractidFromResponse(response.body).toString();
        final uid = extractgharbetiuidFromResponse(response.body).toString();
        prefs.setString('gharbhetiId', id).toString();
        prefs.setString('gharbetiuid', uid).toString();
        // print(prefs.getString('gharbetiuid'));
        // print(prefs.getString('gharbhetiId'));
        print(response.body);
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Success',
            message: 'Ghar created Successfully',
            backgroundColor: AppColor.primarycolor,
            duration:  Duration(seconds: 3),
          ),
        );
        Get.to(()=>BottomNavigationBarScreen());

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
    } catch(e){
      print(e);
    }
  }

  static String extractidFromResponse(String responseBody) {
    final decodedResponse = json.decode(responseBody);
    return decodedResponse['gharbheti']['id'].toString();
  }
  static String extractgharbetiuidFromResponse(String responseBody) {
    final decodedResponse = json.decode(responseBody);
    return decodedResponse['gharbheti']['uuid'].toString();
  }

  // void CreateGharbeti(BuildContext context, {String? gharbetiName, String? user_name, String? houseNumber, String? numberOfRooms, String? userEmail, String? city, String? location, String? id, String? phoneNumber, String? address, String? imagePath}) async{
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final User = 'api/ghar';
  //   id = prefs.getString('id');
  //   user_name= SharedData.getUserName();
  //   phoneNumber = SharedData.getPhoneNumber();
  //   address = SharedData.getUserCity();
  //   imagePath = prefs.getString('ImagePath')!;
  //   userEmail = SharedData.getEmail();
  //   print(id);
  //   try{
  //     var body = jsonEncode({'ghar_name': gharbetiName, 'ghar_number': houseNumber, 'user_email': userEmail, 'user_location':location, 'user_city': city, 'user_id':id, 'ghar_location': addressController.text, 'user_name': user_name, 'user_phone':phoneNumber, 'user_address':address, 'bill_image':imagePath});
  //     var response = await http.post(Uri.parse(ApiConfig.baseUrl+User),headers: {HttpHeaders.contentTypeHeader: "application/json"}, body: body);
  //     if(response.statusCode==201){
  //       final id = extractidFromResponse(response.body).toString();
  //       prefs.setString('gharbhetiId', id).toString();
  //       print(prefs.getString('gharbhetiId'));
  //       print(response.body);
  //       Get.showSnackbar(
  //         const GetSnackBar(
  //           title: 'Success',
  //           message: 'Ghar created Successfully',
  //           backgroundColor: AppColor.primarycolor,
  //           duration:  Duration(seconds: 3),
  //         ),
  //       );
  //     } else {
  //       Get.showSnackbar(
  //           GetSnackBar(
  //           title: 'Failed',
  //           message: '${response.body}',
  //           backgroundColor: Colors.red,
  //           duration: const Duration(seconds: 3),
  //         ),
  //       );
  //     }
  //   } catch(e){
  //     print(e);
  //   }
  // }
  //
  // static String extractidFromResponse(String responseBody) {
  //   final decodedResponse = json.decode(responseBody);
  //   return decodedResponse['gharbheti']['id'].toString();
  // }


  void createSettings(BuildContext context, {String? user_id, String? ghar_id, String? no_of_rooms, String? electricity_rate, String? water, String? waste, String? wifi, String? otherServices}) async {
    final settings ="api/setting";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ghar_id = prefs.getString('gharbhetiId');
    user_id = prefs.getString('id');
    print(user_id);
    try{
      print("called");
      var body = jsonEncode({ "ghar_id": ghar_id, "user_id": user_id, "no_of_rooms" : no_of_rooms, "electricity_rate":electricity_rate, "water":water, "waste":waste, "wifi":wifi, "otherServices":otherServices});
      var response = await http.post(Uri.parse(ApiConfig.baseUrl+settings),headers: {HttpHeaders.contentTypeHeader: "application/json"}, body: body);
      if(response.statusCode==201) {
        prefs.setInt('ElectricityUnit', int.parse(electricity_rate!));
        print(prefs.getInt('ElectricityUnit'));
        await SharedData.setElectricity(electricity_rate);
        await SharedData.setWaste(waste);
        await SharedData.setWater(water);
        await SharedData.setWifi(wifi);
        await SharedData.setOtherServices(otherServices);

        final uid = extractuidFromResponse(response.body).toString();
        prefs.setString('gharuid', uid).toString();
        print(prefs.getString('gharuid'));
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Success',
            message: 'Ghar settings created Successfully',
            backgroundColor: AppColor.primarycolor,
            duration:  Duration(seconds: 3),
          ),
        );
        Get.off(()=>BottomNavigationBarScreen());
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
    } catch(e){
      print(e.toString());
    }
  }
  String extractuidFromResponse(String responseBody) {
    final decodedResponse = json.decode(responseBody);
    return decodedResponse['otherService']['uuid'].toString();
  }

  void updateGhar(BuildContext context, {String? no_of_rooms, String? electricity_rate, String? water, String? waste, String? wifi, String? otherServices}) async {
    final putGharSettings = "api/setting/";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('gharuid').toString();
    print(uid);
    var body = jsonEncode({"no_of_rooms":no_of_rooms, "electricity_rate":electricity_rate, "water": water, "waste" : waste, "wifi": wifi, "otherServices": otherServices});
    var response = await http.put(Uri.parse(ApiConfig.baseUrl+putGharSettings+uid), headers: {HttpHeaders.contentTypeHeader: "application/json"}, body: body);
    if(response.statusCode == 202) {
      prefs.setString('electricity', electricity_rate!);
      prefs.setString('water', water!);
      prefs.setString('wifi', wifi!);
      prefs.setString('waste', waste!);
      prefs.setString('otherServices', otherServices!);
      Get.showSnackbar(
        GetSnackBar(
          title: 'Success',
          message: 'Ghar Updated Successfull',
          backgroundColor: AppColor.primarycolor,
          duration: const Duration(seconds: 3),
        ),
      );
      update();
      Get.to(()=>BottomNavigationBarScreen());
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