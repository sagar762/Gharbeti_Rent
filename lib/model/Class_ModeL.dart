class UserModel {
  String? address;
  String? name;
  String? houseNumber;
  String? numberofRooms;
  String? electricity;
  String? water;
  String? waste;

  UserModel({this.address, this.name, this.electricity, this.houseNumber, this.numberofRooms, this.waste, this.water});
}

List<UserModel> houses = [];

class FreeRoomDetails {
  String? name;
  String? numberOfRooms;
  String? rentAmount;

  FreeRoomDetails({this.name, this.numberOfRooms, this.rentAmount});
}

List<FreeRoomDetails> roomDetails = [];

class BillScreenDetails {
  String? fixedAmount;
  String? extraCharges;

  BillScreenDetails({this.extraCharges, this.fixedAmount});

}

List<BillScreenDetails> details = [];

class UserData {
  String? userId;
  String? userName;
  String? userEmail;
  String? phoneNumber;
  String? userAddress;
  String? userLocation;
  String? city;

  UserData({this.userName, this.userEmail, this.phoneNumber, this.city, this.userAddress, this.userLocation, this.userId});
}

List<UserData> userdetails = [
];

