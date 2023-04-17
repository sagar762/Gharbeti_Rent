//
// import 'dart:convert';
//
// import 'package:gharbeti/model/BillModeL.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'ApiConfig.dart';
//
//
// class ApiService {
//   static Future<List<BillModeL>?> getBill() async {
//     // final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String uid = prefs.getString('rentId').toString();
//     print(uid);
//     final response = await http.get(Uri.parse(ApiConfig.baseUrl+'api/bill?rent_id='+uid));
//     if(response.statusCode == 200) {
//       var convertedJsonData = jsonDecode(response.body);
//       print(convertedJsonData);
//       return (convertedJsonData as List).map((e) => BillModeL.fromJson(e)).toList();
//       // var result = jsonDecode(response.body);
//       // BillModeL _billModel = BillModeL.fromJson(jsonDecode(response.body));
//       // print(response.body);
//       // billList.add(BillModeL(id: _billModel.id, uuid: _billModel.uuid, rentId: _billModel.rentId, nepaliBillCreateDate: _billModel.nepaliBillCreateDate, englishBillCreateDate: _billModel.englishBillCreateDate, nepaliBillEndDate: _billModel.nepaliBillEndDate, englishBillEndDate: _billModel.englishBillEndDate, nepaliBillPaidDate:_billModel.nepaliBillPaidDate, englishBillPaidDate: _billModel.englishBillPaidDate, additionalCharge: _billModel.additionalCharge, totalCharge:_billModel.totalCharge, pendingAmount: _billModel.pendingAmount, creditAmount: _billModel.creditAmount, paidAmount: _billModel.paidAmount, paidStatus: _billModel.paidStatus, electricUnit:_billModel.electricUnit, electricUnitCharge: _billModel.electricUnitCharge, fixedElectricCharge: _billModel.fixedElectricCharge, isActive: _billModel.isActive, createdAt: _billModel.createdAt, updatedAt: _billModel.updatedAt));
//       // print(billList.value);
//       // billList.add(RentModel(
//       //     name: _rentModel.name,
//       //     email: _rentModel.email,
//       //     phoneNumber: _rentModel.phoneNumber,
//       //     address: _rentModel.address,
//       //     city: _rentModel.city),
//       // );
//       // bill_list= List.from(billList);
//       // isLoading.value=false;
//       // update();
//     } else {
//       // Get.snackbar('Error Loading data', 'Server responsed');
//       return null;
//     }
//   }
//   // static var client = http.Client();
//   //
//   //
//   // static Future<List<BillModeL>> getBills() async {
//   //   String? jsonString;
//   //   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String uid = prefs.getString('rentId').toString();
//   //   print(uid);
//   //   final response = await http.get(Uri.parse(ApiConfig.baseUrl+'api/bill?rent_id='+uid));
//   //   if(response.statusCode == 200) {
//   //      jsonString = response.body;
//   //     return billModeLFromJson(jsonString);
//   //   }
//   //   return billModeLFromJson(jsonString!);
//   }
//
//   // var billList = <BillModeL>[].obs;
//   // var isLoading = true.obs;
//   // List<BillModeL> bill_list= [];
//
