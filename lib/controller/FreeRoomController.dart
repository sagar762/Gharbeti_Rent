import 'dart:convert';

import 'package:get/get.dart';
import 'package:gharbeti/model/BillModeL.dart';
import 'package:gharbeti/model/UserDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../model/ApiConfig.dart';

class FreeRoomController extends GetxController {

  Future<List<BillModeL>> getUserBillDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('RentID') ?? '';
    print(uid);
    final response = await http.get(Uri.parse(ApiConfig.baseUrl+'api/bill?rent_id='+uid));
    print(response.body);
    if(response.statusCode==200) {
      List jsonResponse = json.decode(response.body);
      print(response.body);
      return jsonResponse.map((data) => BillModeL.fromJson(data)).toList();
    } else {
      throw Exception('Unexcepted error occured');
    }
  }

  Future<List<UserDetail>> getUserDetail() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('Ghar_id').toString();
    print(id);
    final response = await http.get(Uri.parse(ApiConfig.baseUrl+'api/rent?ghar_id='+id));
    print(response.body);
    if(response.statusCode == 200 ) {
      List responseJson = json.decode(response.body);
      print(response.body);
      return responseJson.map((data) => UserDetail.fromJson(data)).toList();
    } else {
      throw Exception('Unexcepted error occured');
    }
  }
}