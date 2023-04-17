// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

List<UserDetail> userDetailFromJson(String str) => List<UserDetail>.from(json.decode(str).map((x) => UserDetail.fromJson(x)));

// String userDetailToJson(List<UserDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDetail {
  UserDetail({
    this.id,
    this.uuid,
   this.userId,
    this.gharId,
    this.noOfRoom,
    this.name,
   this.price,
    this.roomImage,
    // required this.createBillDateNepali,
    // required this.createBillDateEnglish,
    this.isAccept,
     this.userLeft,
    this.isSendNotification,
    this.isDeactive,
    this.electricReadingUnit,
    this.fixedElectricCharge,
  });

  int? id;
  String? uuid;
  int? userId;
  int? gharId;
  int? noOfRoom;
  String? name;
  int? price;
  String? roomImage;
  // DateTime createBillDateNepali;
  // DateTime createBillDateEnglish;
  bool? isAccept;
  bool? userLeft;
  bool? isSendNotification;
  bool? isDeactive;
  int? electricReadingUnit;
  dynamic fixedElectricCharge;
  // DateTime? createdAt;
  // DateTime? updatedAt;

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json["id"],
      uuid: json["uuid"],
      userId: json["user_id"],
      gharId: json["ghar_id"],
      noOfRoom: json["no_of_room"],
      name: json["name"],
      price: json["price"],
      roomImage: json["room_image"],
      // createBillDateNepali: DateTime.parse(json["create_bill_date_nepali"]),
      // createBillDateEnglish: DateTime.parse(json["create_bill_date_english"]),
      isAccept: json["isAccept"],
      userLeft: json["userLeft"],
      isSendNotification: json["isSendNotification"],
      isDeactive: json["isDeactive"],
      electricReadingUnit: json["electric_reading_unit"],
      fixedElectricCharge: json["fixed_electric_charge"],

    );

  }
  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "uuid": uuid,
  //   "user_id": userId,
  //   "ghar_id": gharId,
  //   "no_of_room": noOfRoom,
  //   "name": name,
  //   "price": price,
  //   "room_image": roomImage,
  //   "create_bill_date_nepali": "${createBillDateNepali.year.toString().padLeft(4, '0')}-${createBillDateNepali.month.toString().padLeft(2, '0')}-${createBillDateNepali.day.toString().padLeft(2, '0')}",
  //   "create_bill_date_english": "${createBillDateEnglish.year.toString().padLeft(4, '0')}-${createBillDateEnglish.month.toString().padLeft(2, '0')}-${createBillDateEnglish.day.toString().padLeft(2, '0')}",
  //   "isAccept": isAccept,
  //   "userLeft": userLeft,
  //   "isSendNotification": isSendNotification,
  //   "isDeactive": isDeactive,
  //   "electric_reading_unit": electricReadingUnit,
  //   "fixed_electric_charge": fixedElectricCharge,
  //   "createdAt": createdAt.toIso8601String(),
  //   "updatedAt": updatedAt.toIso8601String(),
  // };
}
