// To parse this JSON data, do
//
//     final billDetaiL = billDetaiLFromJson(jsonString);

import 'dart:convert';

BillDetaiL billDetaiLFromJson(String str) => BillDetaiL.fromJson(json.decode(str));

String billDetaiLToJson(BillDetaiL data) => json.encode(data.toJson());

class BillDetaiL {
  BillDetaiL({
    required this.bill,
    required this.rent,
    required this.ghar,
    required this.user,
    required this.setting,
  });

  Bill bill;
  Rent rent;
  Ghar ghar;
  User user;
  Setting setting;

  factory BillDetaiL.fromJson(Map<String, dynamic> json) => BillDetaiL(
    bill: Bill.fromJson(json["bill"]),
    rent: Rent.fromJson(json["rent"]),
    ghar: Ghar.fromJson(json["ghar"]),
    user: User.fromJson(json["user"]),
    setting: Setting.fromJson(json["setting"]),
  );

  Map<String, dynamic> toJson() => {
    "bill": bill.toJson(),
    "rent": rent.toJson(),
    "ghar": ghar.toJson(),
    "user": user.toJson(),
    "setting": setting.toJson(),
  };
}

class Bill {
  Bill({
    required this.id,
    required this.uuid,
    required this.rentId,
    required this.nepaliBillCreateDate,
    required this.englishBillCreateDate,
    required this.nepaliBillEndDate,
    required this.englishBillEndDate,
    required this.nepaliBillPaidDate,
    required this.englishBillPaidDate,
    required this.additionalCharge,
    required this.totalCharge,
    required this.pendingAmount,
    required this.creditAmount,
    this.paidAmount,
    required this.paidStatus,
    this.electricUnit,
    required this.electricUnitCharge,
    this.fixedElectricCharge,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String uuid;
  int rentId;
  DateTime nepaliBillCreateDate;
  DateTime englishBillCreateDate;
  String nepaliBillEndDate;
  String englishBillEndDate;
  String nepaliBillPaidDate;
  String englishBillPaidDate;
  int additionalCharge;
  int totalCharge;
  int pendingAmount;
  int creditAmount;
  dynamic paidAmount;
  bool paidStatus;
  dynamic electricUnit;
  int electricUnitCharge;
  dynamic fixedElectricCharge;
  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
    id: json["id"],
    uuid: json["uuid"],
    rentId: json["rent_id"],
    nepaliBillCreateDate: DateTime.parse(json["nepali_bill_create_date"]),
    englishBillCreateDate: DateTime.parse(json["english_bill_create_date"]),
    nepaliBillEndDate: json["nepali_bill_end_date"],
    englishBillEndDate: json["english_bill_end_date"],
    nepaliBillPaidDate: json["nepali_bill_paid_date"],
    englishBillPaidDate: json["english_bill_paid_date"],
    additionalCharge: json["additional_charge"],
    totalCharge: json["total_charge"],
    pendingAmount: json["pending_amount"],
    creditAmount: json["credit_amount"],
    paidAmount: json["paidAmount"],
    paidStatus: json["paidStatus"],
    electricUnit: json["electric_unit"],
    electricUnitCharge: json["electric_unit_charge"],
    fixedElectricCharge: json["fixed_electric_charge"],
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "rent_id": rentId,
    "nepali_bill_create_date": "${nepaliBillCreateDate.year.toString().padLeft(4, '0')}-${nepaliBillCreateDate.month.toString().padLeft(2, '0')}-${nepaliBillCreateDate.day.toString().padLeft(2, '0')}",
    "english_bill_create_date": "${englishBillCreateDate.year.toString().padLeft(4, '0')}-${englishBillCreateDate.month.toString().padLeft(2, '0')}-${englishBillCreateDate.day.toString().padLeft(2, '0')}",
    "nepali_bill_end_date": nepaliBillEndDate,
    "english_bill_end_date": englishBillEndDate,
    "nepali_bill_paid_date": nepaliBillPaidDate,
    "english_bill_paid_date": englishBillPaidDate,
    "additional_charge": additionalCharge,
    "total_charge": totalCharge,
    "pending_amount": pendingAmount,
    "credit_amount": creditAmount,
    "paidAmount": paidAmount,
    "paidStatus": paidStatus,
    "electric_unit": electricUnit,
    "electric_unit_charge": electricUnitCharge,
    "fixed_electric_charge": fixedElectricCharge,
    "isActive": isActive,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Ghar {
  Ghar({
    required this.id,
    required this.uuid,
    required this.gharName,
    required this.gharNumber,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userAddress,
    required this.userCity,
    required this.userLocation,
    required this.gharLocation,
    required this.billImage,
    required this.isGharVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String uuid;
  String gharName;
  String gharNumber;
  int userId;
  String userName;
  String userEmail;
  String userPhone;
  String userAddress;
  String userCity;
  String userLocation;
  String gharLocation;
  String billImage;
  bool isGharVerified;
  DateTime createdAt;
  DateTime updatedAt;

  factory Ghar.fromJson(Map<String, dynamic> json) => Ghar(
    id: json["id"],
    uuid: json["uuid"],
    gharName: json["ghar_name"],
    gharNumber: json["ghar_number"],
    userId: json["user_id"],
    userName: json["user_name"],
    userEmail: json["user_email"],
    userPhone: json["user_phone"],
    userAddress: json["user_address"],
    userCity: json["user_city"],
    userLocation: json["user_location"],
    gharLocation: json["ghar_location"],
    billImage: json["bill_image"],
    isGharVerified: json["isGharVerified"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "ghar_name": gharName,
    "ghar_number": gharNumber,
    "user_id": userId,
    "user_name": userName,
    "user_email": userEmail,
    "user_phone": userPhone,
    "user_address": userAddress,
    "user_city": userCity,
    "user_location": userLocation,
    "ghar_location": gharLocation,
    "bill_image": billImage,
    "isGharVerified": isGharVerified,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Rent {
  Rent({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.gharId,
    required this.noOfRoom,
    required this.name,
    required this.price,
    required this.roomImage,
    required this.createBillDateNepali,
    required this.createBillDateEnglish,
    required this.isAccept,
    required this.userLeft,
    required this.isSendNotification,
    required this.isDeactive,
    required this.electricReadingUnit,
    this.fixedElectricCharge,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String uuid;
  int userId;
  int gharId;
  int noOfRoom;
  String name;
  int price;
  String roomImage;
  DateTime createBillDateNepali;
  DateTime createBillDateEnglish;
  bool isAccept;
  bool userLeft;
  bool isSendNotification;
  bool isDeactive;
  int electricReadingUnit;
  dynamic fixedElectricCharge;
  DateTime createdAt;
  DateTime updatedAt;

  factory Rent.fromJson(Map<String, dynamic> json) => Rent(
    id: json["id"],
    uuid: json["uuid"],
    userId: json["user_id"],
    gharId: json["ghar_id"],
    noOfRoom: json["no_of_room"],
    name: json["name"],
    price: json["price"],
    roomImage: json["room_image"],
    createBillDateNepali: DateTime.parse(json["create_bill_date_nepali"]),
    createBillDateEnglish: DateTime.parse(json["create_bill_date_english"]),
    isAccept: json["isAccept"],
    userLeft: json["userLeft"],
    isSendNotification: json["isSendNotification"],
    isDeactive: json["isDeactive"],
    electricReadingUnit: json["electric_reading_unit"],
    fixedElectricCharge: json["fixed_electric_charge"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "user_id": userId,
    "ghar_id": gharId,
    "no_of_room": noOfRoom,
    "name": name,
    "price": price,
    "room_image": roomImage,
    "create_bill_date_nepali": "${createBillDateNepali.year.toString().padLeft(4, '0')}-${createBillDateNepali.month.toString().padLeft(2, '0')}-${createBillDateNepali.day.toString().padLeft(2, '0')}",
    "create_bill_date_english": "${createBillDateEnglish.year.toString().padLeft(4, '0')}-${createBillDateEnglish.month.toString().padLeft(2, '0')}-${createBillDateEnglish.day.toString().padLeft(2, '0')}",
    "isAccept": isAccept,
    "userLeft": userLeft,
    "isSendNotification": isSendNotification,
    "isDeactive": isDeactive,
    "electric_reading_unit": electricReadingUnit,
    "fixed_electric_charge": fixedElectricCharge,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Setting {
  Setting({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.gharId,
    required this.noOfRooms,
    required this.electricityRate,
    this.fixedElectricCharge,
    required this.water,
    required this.waste,
    required this.wifi,
    required this.otherServices,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String uuid;
  int userId;
  int gharId;
  int noOfRooms;
  int electricityRate;
  dynamic fixedElectricCharge;
  int water;
  int waste;
  int wifi;
  String otherServices;
  DateTime createdAt;
  DateTime updatedAt;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    id: json["id"],
    uuid: json["uuid"],
    userId: json["user_id"],
    gharId: json["ghar_id"],
    noOfRooms: json["no_of_rooms"],
    electricityRate: json["electricity_rate"],
    fixedElectricCharge: json["fixed_electric_charge"],
    water: json["water"],
    waste: json["waste"],
    wifi: json["wifi"],
    otherServices: json["otherServices"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "user_id": userId,
    "ghar_id": gharId,
    "no_of_rooms": noOfRooms,
    "electricity_rate": electricityRate,
    "fixed_electric_charge": fixedElectricCharge,
    "water": water,
    "waste": waste,
    "wifi": wifi,
    "otherServices": otherServices,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class User {
  User({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.mapLocation,
    required this.isVerified,
    required this.isGharbhati,
    required this.isPhoneVerified,
    required this.isUser,
    required this.isUserVerified,
    required this.isLogin,
    required this.status,
    required this.isDeactive,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String uuid;
  String name;
  String email;
  String phoneNumber;
  String address;
  String city;
  String mapLocation;
  bool isVerified;
  bool isGharbhati;
  bool isPhoneVerified;
  bool isUser;
  bool isUserVerified;
  bool isLogin;
  bool status;
  bool isDeactive;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    uuid: json["uuid"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    city: json["city"],
    mapLocation: json["map_location"],
    isVerified: json["isVerified"],
    isGharbhati: json["isGharbhati"],
    isPhoneVerified: json["isPhoneVerified"],
    isUser: json["isUser"],
    isUserVerified: json["isUserVerified"],
    isLogin: json["isLogin"],
    status: json["status"],
    isDeactive: json["isDeactive"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "address": address,
    "city": city,
    "map_location": mapLocation,
    "isVerified": isVerified,
    "isGharbhati": isGharbhati,
    "isPhoneVerified": isPhoneVerified,
    "isUser": isUser,
    "isUserVerified": isUserVerified,
    "isLogin": isLogin,
    "status": status,
    "isDeactive": isDeactive,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
