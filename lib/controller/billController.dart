import 'dart:convert';
import 'dart:io';

import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti/controller/roomController.dart';
import 'package:gharbeti/model/ApiService.dart';
import 'package:gharbeti/model/BillModeL.dart';
import 'package:gharbeti/screen/RentScreen/BillScreen.dart';
import 'package:gharbeti/utils/sharedPreferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/ApiConfig.dart';
import '../screen/home/BottomNavigationBar.dart';
import '../services/remote_Service.dart';
import '../utils/notification.dart';
import '../widget/CustomButton.dart';
import '../widget/CustomTextField.dart';
import '../widget/color.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:http/http.dart' as http;

class BillController extends GetxController {
  final controller = Get.put(RoomController());
  var formKey = GlobalKey<FormState>();
  var formKey1 = GlobalKey<FormState>();
  String fixedamount = '-';
  int value = 1;
  bool showTextField = false;
  var buttonVisible = true.obs;
  // String? numOfRooms;
  // String? rentAmount;
  // String? waterCharges;
  // String? wasteCharges;
  var numOfRooms = ''.obs;
  var rentAmount = ''.obs;
  var waterCharges = ''.obs;
  var wasteCharges = ''.obs;
  var electricity = ''.obs;
  TextEditingController dateController = TextEditingController();
  final TextEditingController oldUnitController = TextEditingController();
  final TextEditingController newUnitController = TextEditingController();
  final TextEditingController electricityChargeController = TextEditingController();
  final TextEditingController fixedController = TextEditingController();
  final TextEditingController chargeController = TextEditingController();
  final TextEditingController totalPrice = TextEditingController();

  FlutterLocalNotificationsPlugin localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  initializeNotifications() async {
    var initializeAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializeIOS = DarwinInitializationSettings();
    var initSettings = InitializationSettings(android: initializeAndroid);
    await localNotificationsPlugin.initialize(initSettings);
  }

  Future singleNotification(DateTime datetime, String message, String subtext,
      int hashcode,
      { String? sound}) async {
    var androidChannel = AndroidNotificationDetails(
      'channel-id',
      'channel-name',
      importance: Importance.max,
      priority: Priority.max,
    );

    var iosChannel = DarwinNotificationDetails();
    var platformChannel = NotificationDetails(android: androidChannel);
    localNotificationsPlugin.periodicallyShow(
        hashcode, message, subtext, RepeatInterval.everyMinute, platformChannel,
        payload: hashcode.toString());
  }


  @override
  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Enter Payment Amount',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 20.0.sp),
          ),
          content: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                CustomTextField(
                  controller: totalPrice,
                  // enabled: false,
                  hint: 'Total Paid Amount',
                  prefixIcon:
                  SvgPicture.asset('assets/images/🦆 icon _cash_.svg'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      text: 'Cancel',
                      onPressed: () {
                        Get.back();
                      },
                      height: 135.h,
                      width: 30.w,
                    ),
                    SizedBox(width: 5.w,),
                    CustomButton(
                      text: 'Confirm',
                      onPressed: () async {
                        // final SharedPreferences prefs = await SharedPreferences.getInstance();
                        // prefs.remove('AdditionalCharge');
                        // prefs.remove('UnitElectricityCharge');
                        String price = totalPrice.text;
                        DateTime now = DateTime.now().toUtc().add(
                          Duration(minutes: 1),
                        );
                        singleNotification(
                          now,
                          "Bill Info",
                          "Please Pay a Bill",
                          98123871,
                          // RepeatInterval.everyMinute,

                        );
                        // buttonVisible.value = true;
                        // load.value = true;
                        // NotificationService().scheduleNotification(
                        //     scheduledNotificationDateTime: DateTime.now().add(Duration(seconds: 10)),
                        //   title: 'Bill Info',
                        //   body: 'Please Pay the Bill'
                        //
                        // );
                        NotificationService().showNotification(
                            title: 'Payment Success',
                            body: 'Rs $price has been paid successfully.');
                        // Get.showSnackbar(
                        //   GetSnackBar(
                        //     title: 'Successfull',
                        //     message: 'Payment is Success.',
                        //     backgroundColor: AppColor.primarycolor,
                        //     duration: const Duration(seconds: 3),
                        //   ),
                        // );

                        updateBillAmountPaid(context, total_amount: totalPrice.text);

                      },
                      height: 135.h,
                      width: 30.w,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    electricity.value = prefs.getString('UnitElectricityCharge') ?? '';
    print(electricity.value);
    waterCharges.value = SharedData.getWater();
    wasteCharges.value = SharedData.getWaste();
    numOfRooms.value = SharedData.getNumOfRooms();
    rentAmount.value = SharedData.getRoomPrice();
    print(waterCharges);
    print(wasteCharges);
  }

  Future<void> showDatePicker(BuildContext context) async {
    picker.NepaliDateTime? _selectedDateTime =
    await picker.showMaterialDatePicker(
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000),
      lastDate: NepaliDateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
    );

    print(_selectedDateTime);

    if (_selectedDateTime != null) {
      dateController.text =
      '${_selectedDateTime.year}-${_selectedDateTime.month}-${_selectedDateTime
          .day}';
      update();
    }
  }

  void createBill(BuildContext context, {String? rent_id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    rent_id = prefs.getString('RentId');
    final billCreate = 'api/bill';
    try {
      var body = jsonEncode({'rent_id': rent_id});
      var response = await http.post(Uri.parse(ApiConfig.baseUrl + billCreate),
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: body);
      if (response.statusCode == 201) {
        print(response.body);
        // Get.showSnackbar(
        //   GetSnackBar(
        //     title: 'Success',
        //     message: 'Bill Created Successfull',
        //     backgroundColor: AppColor.primarycolor,
        //     duration: const Duration(seconds: 5),
        //   ),
        // );
        // Get.off(() => BottomNavigationBarScreen());
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

  // var stringResponse = ''.obs;
  // Future apicall() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String uid = prefs.getString('rentID').toString();
  //   http.Response response;
  //   response = await http.get(Uri.parse(ApiConfig.baseUrl+'api/bill?rent_id='+uid));
  //   if(response.statusCode == 200) {
  //     stringResponse.value = response.body;
  //   }
  // }
  // RxList<BillModeL> billModels = <BillModeL>[].obs;
  // List<BillModeL> billModels = [];
  // var billModels = <BillModeL>[].obs;
  // var isLoading =true.obs;
  //
  // Future<void> getBill() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String uid = prefs.getString('rentId').toString();
  //   print(uid);
  //   final response = await http.get(Uri.parse(ApiConfig.baseUrl+'api/bill?rent_id='+uid));
  //   // var data = jsonDecode(response.body.toString());
  //   if(response.statusCode == 200) {
  //     BillModeL _billModel = BillModeL.fromJson(jsonDecode(response.body.toString()));
  //     billModels.add(BillModeL(id: _billModel.id, uuid: _billModel.uuid, rentId: _billModel.rentId, nepaliBillCreateDate: _billModel.nepaliBillCreateDate, englishBillCreateDate: _billModel.englishBillCreateDate, nepaliBillEndDate: _billModel.nepaliBillEndDate, englishBillEndDate: _billModel.englishBillEndDate, nepaliBillPaidDate:_billModel.nepaliBillPaidDate, englishBillPaidDate: _billModel.englishBillPaidDate, additionalCharge: _billModel.additionalCharge, totalCharge:_billModel.totalCharge, pendingAmount: _billModel.pendingAmount, creditAmount: _billModel.creditAmount, paidAmount: _billModel.paidAmount, paidStatus: _billModel.paidStatus, electricUnit:_billModel.electricUnit, electricUnitCharge: _billModel.electricUnitCharge, fixedElectricCharge: _billModel.fixedElectricCharge, isActive: _billModel.isActive, createdAt: _billModel.createdAt, updatedAt: _billModel.updatedAt));
  //     print(billModels);
  //     isLoading.value = true;
  //   } else {
  //     Get.snackbar('Error Loading', 'Server responded');
  //   }
  // }

  var billList = <BillModeL>[].obs;
  // var load = false.obs;
  // getData() async {
  //   billLists.value = (await RemoteService().getBills())!;
  //   if(billLists.value != null) {
  //     load.value=true;
  //   }
  // }

  //
  // getData() async {
  //   load.value = true;
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String uid = prefs.getString('rentId') ?? '';
  //   print(uid);
  //   try{
  //     final response = await http.get(Uri.parse(ApiConfig.baseUrl+'api/bill?rent_id='+uid));
  //     print(response.body);
  //     if(response.statusCode == 200) {
  //       var json = response.body;
  //       return billList.value.add(json as BillModeL);
  //         billModeLFromJson(json);
  //       // print('called');
  //       // billList.value = List<BillModeL>.from(json.decode(response.body).map((x)=>BillModeL.fromJson(x))).toList();
  //       // load.value = false;
  //       // print(billList.value[1].id);
  //       // // print(billList.value);
  //     }
  //   }catch(e){
  //     print('$e');
  //     Get.snackbar('title', '$e');
  //   }
  // }
  
  var billLists = <BillModeL>[].obs;
  //
  // Future<List<BillModeL>?> fetchBillModel() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String uid = prefs.getString('rentId') ?? '';
  //   print(uid);
  //   final response = await http.get(Uri.parse(ApiConfig.baseUrl+'api/bill?rent_id='+uid));
  //   if(response.statusCode==200) {
  //     BillModeL _billModel = BillModeL.fromJson(jsonDecode(response.body));
  //     billLists.add(BillModeL(id: _billModel.id, totalCharge: _billModel.totalCharge, paidAmount: _billModel.paidAmount, paidStatus: _billModel.paidStatus, creditAmount: _billModel.creditAmount, pendingAmount: _billModel.pendingAmount, englishBillCreateDate:_billModel.englishBillCreateDate));
  //     load.value = true;
  //     return billLists.value;
  //   }else {
  //     Get.snackbar('Error', 'Server Responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
  //   }
  //   return null;
  // }

  // Future<List<BillModeL>?> getBill() async {
  //   load.value = true;
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String uid = prefs.getString('rentId') ?? '';
  //   print(uid);
  //
  //     final response = await http.get(
  //         Uri.parse(ApiConfig.baseUrl + 'api/bill?rent_id=' + uid));
  //     var data = jsonDecode(response.body.toString());
  //     if(response.statusCode == 200) {
  //       for(Map<String, dynamic> index in data) {
  //         billLists.value.add(BillModeL.fromJson(index));
  //       }
  //       return billLists.value;
  //     } else {
  //       return null;
  //     }
  // }

  var isLoading=false.obs;
  RxMap<String, dynamic> data = RxMap<String, dynamic>({});
   getBillDetail() async {
    isLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('BillUid') ?? '';
    print(uid);
    var response = await http.get(Uri.parse(ApiConfig.baseUrl+'/api/bill/'+uid));
    if(response.statusCode == 200) {

      print('called');
      data.addAll(json.decode(response.body));
      // String hello = data['bill']['english_bill_create_date'];
      // print(hello);
      isLoading.value=false;
    }
  }


  void updateBill(BuildContext context,
      {String? electric_unit, String? extra_charge, String? fixed_electric_charge, String? nepali_paid_date}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('BillUid').toString();
    print(uid);
    final billCreate = 'api/bill/';
    var body = jsonEncode({
      'electric_ending_unit_reading': electric_unit,
      'nepali_bill_paid_date': nepali_paid_date,
      'additional_charge': extra_charge,
      'total_electricity_cost': fixed_electric_charge,
    });
    var response = await http.put(
        Uri.parse(ApiConfig.baseUrl + billCreate + uid),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: body);
    try {
      if (response.statusCode == 202) {
        prefs.setString('UnitElectricityCharge', electric_unit!);
        prefs.setString('AdditionalCharge', chargeController.text);
        print(prefs.getString('AdditionalCharge'));
        print(prefs.getString('UnitElectricityCharge'));
        // prefs.setString('ExtraCharge', extra_charge!);
        print('success');
        Get.showSnackbar(
          GetSnackBar(
            title: 'Success',
            message: 'Bill Updated Successfull',
            backgroundColor: AppColor.primarycolor,
            duration: const Duration(seconds: 5),
          ),
        );
        isLoading.value = true;
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BillScreen(title: 'Baisakh', name: 'Sgar')));
        // Get.off(()=>BillScreen(title: 'HEllo', name: 'ame'));

        // Navigator.pop(context);
        // Get.back();
        // Navigator.pop(context, data.value['bill']['additional_charge']);
        // update();
        // Get.back();
        // Get.back();
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

  void updateBillAmountPaid(BuildContext context,{String? total_amount}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('BillUid')?? '';
    var body = jsonEncode({
      'paidAmount': total_amount
    });
    var response = await http.put(
        Uri.parse(ApiConfig.baseUrl +'api/bill/paidAmount/' + uid),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: body);
    try{
      if(response.statusCode == 202) {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Success',
            message: 'Bill Paid Successfull',
            backgroundColor: AppColor.primarycolor,
            duration: const Duration(seconds: 5),
          ),
        );
        DateTime now = DateTime.now().toUtc().add(
          Duration(minutes: 1),
        );
        singleNotification(
          now,
          "Bill Info",
          "Please Pay a Bill",
          98123871,
          // RepeatInterval.everyMinute,

        );
        isLoading.value=true;
        // createBill(context);
        buttonVisible.value = true;
        // load.value = true;s
        Get.off(() => BottomNavigationBarScreen());
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Failed',
            message: 'Failed',
            backgroundColor: AppColor.primarycolor,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }catch(e) {
      print(e);
    }
  }

  void onInit() {
    super.onInit();
  }

}
