import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  static SharedPreferences? prefs;

  static getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  //email
static Future setEmail(var email) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs?.setString('email', email);
}
static String getEmail() => prefs?.getString('email') ?? '';

  //userName
static Future setUserName(var userName) async {
  prefs = await SharedPreferences.getInstance();
  return await prefs?.setString('userName', userName);
}
static String getUserName() => prefs?.getString('userName') ?? '';

//City
static Future setUserCity(var city) async {
  prefs = await SharedPreferences.getInstance();
  return await prefs?.setString('city', city);
}
static String getUserCity() => prefs?.getString('city') ?? '';

//phoneNumber

static Future setPhoneNumber(var phoneNumber) async {
  prefs = await SharedPreferences.getInstance();
  return await prefs?.setString('phoneNumber', phoneNumber);
}
static String getPhoneNumber() => prefs?.getString('phoneNumber') ?? '';

//electricity
static Future setElectricity(var electricity) async {
  prefs = await SharedPreferences.getInstance();
  return await prefs?.setString('electricity', electricity);
}
static String getElectricity() => prefs?.getString('electricity') ?? '';

//water
  static Future setWater(var water) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs?.setString('water', water);
  }
  static String getWater() => prefs?.getString('water') ?? '';

  //waste
  static Future setWaste(var waste) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs?.setString('waste', waste);
  }
  static String getWaste() => prefs?.getString('waste') ?? '';

  //wifi
  static Future setWifi(var wifi) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs?.setString('wifi', wifi);
  }
  static String getWifi() => prefs?.getString('wifi') ?? '';

  //otherServices
  static Future setOtherServices(var otherServices) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs?.setString('otherServices', otherServices);
  }
  static String getOtherServices() => prefs?.getString('otherServices') ?? '';

  //numOfRooms
static Future setNumOfRooms(var numOfRooms) async {
  prefs = await SharedPreferences.getInstance();
  return await prefs?.setString('numOfRooms', numOfRooms);
}
static String getNumOfRooms() => prefs?.getString('numOfRooms') ?? '';

//price
static Future setRoomPrice(var price) async {
  prefs = await SharedPreferences.getInstance();
  return await prefs?.setString('price', price);
}
static String getRoomPrice() => prefs?.getString('price') ?? '';

}