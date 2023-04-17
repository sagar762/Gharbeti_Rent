import 'package:gharbeti/model/BillModeL.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/ApiConfig.dart';

class RemoteService {
  Future<List<BillModeL>?> getBills() async {
    var client = http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('rentId') ?? '';
    print(uid);
    final response = await client.get(Uri.parse(ApiConfig.baseUrl+'api/bill?rent_id='+ uid));
    if(response.statusCode == 200) {
      var json = response.body;
      return billModeLFromJson(json);
    }
  }
}