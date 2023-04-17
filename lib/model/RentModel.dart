import 'dart:convert';

// To parse this JSON data, do
//
//     final rentModel = rentModelFromJson(jsonString);

// RentModel rentModelFromJson(String str) => RentModel.fromJson(json.decode(str));
//
// String rentModelToJson(RentModel data) => json.encode(data.toJson());

class RentModel {
  RentModel({
     this.id,
     this.uuid,
     this.name,
     this.email,
     this.phoneNumber,
     this.address,
     this.city,
     this.mapLocation,
     this.isVerified,
     this.isGharbhati,
     this.isPhoneVerified,
     this.isUser,
     this.isUserVerified,
     this.isLogin,
     this.status,
     this.isDeactive,
  });

  int? id;
  String? uuid;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  String? city;
  String? mapLocation;
  bool? isVerified;
  bool? isGharbhati;
  bool? isPhoneVerified;
  bool? isUser;
  bool? isUserVerified;
  bool? isLogin;
  bool? status;
  bool? isDeactive;

  factory RentModel.fromJson(Map<String, dynamic> json) {
    return RentModel(
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
    );
  }

}
