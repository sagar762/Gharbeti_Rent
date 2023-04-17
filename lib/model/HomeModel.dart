import 'package:flutter/cupertino.dart';

import '../screen/RentScreen/UserScreen.dart';

class HomeContent {
  String? title;
  HomeContent({this.title});
}

List<HomeContent> contents = [
  HomeContent(title: 'Rent History'),
  HomeContent(title: 'Manage Rooms'),
  HomeContent(title: 'Settings')
];

class RentName {
  String? name;
  RentName({this.name });
}

List<RentName> rents = [
  RentName(name: 'Ram Maharjan'),
  RentName(name: 'Hari Sapkota' ),
  RentName(name: 'Sita Sapkota')
];

class UserDetails {
  String? month;
  int? total;
  int? due;
  int? credit;
  String? paid;

  UserDetails({this.total, this.credit, this.due, this.month, this.paid});

}

List<UserDetails> details = [
  UserDetails(month: 'Baisakh', total: 5000, due: 2000, credit: 1000, paid: 'Paid'),
  UserDetails(month: 'Jestha', total: 2000, due: 100, credit: 200, paid: 'UnPaid'),
  UserDetails(month: 'Baisakh', total: 5000, due: 2000, credit: 1000, paid: 'Paid'),
  UserDetails(month: 'Jestha', total: 2000, due: 100, credit: 200, paid: 'UnPaid'),
  UserDetails(month: 'Baisakh', total: 5000, due: 2000, credit: 1000, paid: 'Paid'),
  UserDetails(month: 'Jestha', total: 2000, due: 100, credit: 200, paid: 'UnPaid'),
  UserDetails(month: 'Jestha', total: 2000, due: 100, credit: 200, paid: 'UnPaid')
];

class UserPhoneNumber {
  String? name;
  String? address;
  String? phoneNumber;

  UserPhoneNumber({this.name, this.address, this.phoneNumber});
}

List<UserPhoneNumber> users = [
  UserPhoneNumber(name: 'Ram Maharjan', address: 'New Baneshwor Kathmandu', phoneNumber: '9808782347'),
  UserPhoneNumber(name: 'Hari Sapkota', address: 'Sitapaila Kathmandu', phoneNumber: '9807248282'),
  UserPhoneNumber(name: 'Sita Sapkota', address: 'Kalanki Kathmandu', phoneNumber: '9808278434')
];