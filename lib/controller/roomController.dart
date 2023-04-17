import 'dart:convert';
import 'dart:io';
import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gharbeti/model/RentModel.dart';
import 'package:gharbeti/screen/auth/login_Screen.dart';
import 'package:gharbeti/utils/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import '../model/ApiConfig.dart';
import '../model/UserDetail.dart';
import '../screen/home/BottomNavigationBar.dart';
import '../widget/CustomButton.dart';
import '../widget/color.dart';

class RoomController extends GetxController {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController rentController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController fixedController = TextEditingController();
  final TextEditingController electricityChargeController = TextEditingController();
  final TextEditingController oldElectricityUnit = TextEditingController();
  TextEditingController wifiController = TextEditingController();
  TextEditingController otherServicesController = TextEditingController();
  TextEditingController electricityController = TextEditingController();
  TextEditingController waterController = TextEditingController();
  TextEditingController wasteController = TextEditingController();
  var userList = <RentModel>[].obs;
  var isLoading = true.obs;
  int value = 1;
  bool showTextField = false;
  // var formKey = GlobalKey<FormState>();
  // List<RentModel> user_list= [];
  String? phoneNumber ='';

  Future<void> showDatePicker(BuildContext context) async {
    picker.NepaliDateTime? _selectedDateTime =
    await picker.showMaterialDatePicker(
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000),
      lastDate: NepaliDateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
    );
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    NepaliDateTime nepaliDate = NepaliDateTime.parse(_selectedDateTime.toString());
    DateTime englishDate = nepaliDate.toDateTime();
    prefs.setString('englishDate', englishDate.toString());
    print(prefs.getString('englishDate'));
    // print(englishDate);
    // print(_selectedDateTime);

    if (_selectedDateTime != null) {

        dateController.text =
        '${_selectedDateTime.year}-${_selectedDateTime.month}-${_selectedDateTime.day}';
        // update();

    }
  }

  var userDetails = <UserDetail>[].obs;
  var loading = false.obs;


  getUserDetail() async {
    loading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('Ghar_id').toString();
   print(id);
    try{
      final response = await http.get(Uri.parse(ApiConfig.baseUrl+'api/rent?ghar_id='+id));
      print(response.body);
      if(response.statusCode == 200) {
        userDetails.value = List<UserDetail>.from(json.decode(response.body).map((x)=>UserDetail.fromJson(x))).toList();
        loading.value = false;
        print('called');
      }
    }catch(e){
      print('$e');
      Get.snackbar('title', '$e');
    }
  }

  RxMap mapResponse = {}.obs;

  Future<void> fetchUserData() async {
    isLoading.value = true;
    String text = searchController.text;
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumber = SharedData.getPhoneNumber();
    print(phoneNumber);
    final response = await http.get(Uri.parse(ApiConfig.baseUrl + 'api/user/phone_number/'+text));
    if(response.statusCode == 200) {
      mapResponse.value = json.decode(response.body);
      print(mapResponse.value);
      // RentModel _rentModel = RentModel.fromJson(jsonDecode(response.body));
      // print(response.body);
      // userList.add(RentModel(
      //      name: _rentModel.name,
      //     email: _rentModel.email,
      //     phoneNumber: _rentModel.phoneNumber,
      //     address: _rentModel.address,
      //     city: _rentModel.city),
      // );
      // user_list = List.from(userList);
      isLoading.value=false;
      // update();
      // searchController.clear();
    } else {
      // Get.snackbar('Error Loading data', 'Server responsed');
    }
  }

  void createRent(BuildContext context, {required String no_of_room, required String name, required String price, String? room_image, String? user_id, String? ghar_id, String? nepali_Date, String? english_Date, String? electric_reading_unit, String? fixed_electric_charge, String? per_electricity_rate_price, String? water, String? waste, String? wifi  }) async {
    DateTime now = DateTime.now();
    print(now);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ghar_id = prefs.getString('gharbhetiId');
    user_id = prefs.getString('id');
    room_image = prefs.getString('ImagePath');
    english_Date = prefs.getString('englishDate');
    final createRoom = 'api/rent';
    print('hello');
    try{
      var body = jsonEncode({'user_id':user_id, 'ghar_id':ghar_id, 'no_of_room':no_of_room, 'name':name, 'room_image':room_image, 'price':price, 'create_bill_date_nepali':nepali_Date, 'create_bill_date_english':english_Date, 'electric_reading_unit': electric_reading_unit, 'fixed_electric_charge': fixed_electric_charge, 'per_electricity_rate_price': per_electricity_rate_price, 'water':water, 'waste': waste, 'wifi': wifi});
      var response = await http.post(Uri.parse(ApiConfig.baseUrl+createRoom),headers: {HttpHeaders.contentTypeHeader: "application/json"}, body: body);
      if(response.statusCode == 201) {
        final id = extractidFromResponse(response.body).toString();
        final uid = extractuidFromResponse(response.body).toString();
        final gharid = extractgharidFromResponse(response.body).toString();
        prefs.setString('OldUnitReading', electric_reading_unit!);
        prefs.setString('UnitCharge', per_electricity_rate_price!);
        print(prefs.getString('UnitCharge'));
        print(prefs.getString('OldUnitReading'));
        prefs.setString('Ghar_id', gharid);
        print(prefs.getString('Ghar_id'));
        prefs.setString('billUid', uid);
        print(prefs.getString('billUid'));
        prefs.setString('rentId', id).toString();
        print(prefs.getString('rentId'));
        await SharedData.setNumOfRooms(no_of_room);
        await SharedData.setRoomPrice(price);
        // prefs.setString('numberOfRooms', no_of_room);
        // prefs.setString('rentAmount', price);
        // print(prefs.getString(price));
        // print(prefs.getString(no_of_room));
        print(response.body);
        Get.showSnackbar(
          GetSnackBar(
            title: 'Success',
            message: 'Rent Created Successfull',
            backgroundColor: AppColor.primarycolor,
            duration: const Duration(seconds: 5),
          ),
        );
        searchController.clear();
        namecontroller.clear();
        dateController.clear();
        roomController.clear();
        rentController.clear();

        // searchController.clear();
        Get.off(()=>BottomNavigationBarScreen());
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Failed',
            message: '${response.body}',
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String extractidFromResponse(String responseBody) {
    final decodedResponse = json.decode(responseBody);
    return decodedResponse['bill']['rent_id'].toString();
  }

  String extractgharidFromResponse(String responseBody) {
    final decodedResponse = json.decode(responseBody);
    return decodedResponse['rent']['ghar_id'].toString();
  }

  String extractuidFromResponse(String responseBody) {
    final decodedResponse = json.decode(responseBody);
    return decodedResponse['bill']['uuid'].toString();
  }




  void onInit() {
    // getUserDetail();
    fetchUserData();
    // getUserDetail();
    super.onInit();

  }

}