// To parse this JSON data, do
//
//     final billModeL = billModeLFromJson(jsonString);

import 'dart:convert';

List<BillModeL> billModeLFromJson(String str) => List<BillModeL>.from(json.decode(str).map((x) => BillModeL.fromJson(x)));


class BillModeL {
  BillModeL({
     this.id,
   this.uuid,
     this.rentId,
    this.nepaliBillCreateDate,
     this.englishBillCreateDate,
   //  this.nepaliBillEndDate,
   // this.englishBillEndDate,
   //  required this.nepaliBillPaidDate,
   //  required this.englishBillPaidDate,
    this.additionalCharge,
    this.totalCharge,
   this.pendingAmount,
    this.creditAmount,
     this.paidAmount,
    this.paidStatus,
    this.electricUnit,
    this.electricUnitCharge,
    this.fixedElectricCharge,
   this.isActive,
    // required this.createdAt,
    // required this.updatedAt,
  });

  int? id;
  String? uuid;
  int? rentId;
  String? nepaliBillCreateDate;
  String? englishBillCreateDate;
  // String? nepaliBillEndDate;
  // String? englishBillEndDate;
  // DateTime nepaliBillPaidDate;
  // DateTime englishBillPaidDate;
  int? additionalCharge;
  int? totalCharge;
  int? pendingAmount;
  int? creditAmount;
  int? paidAmount;
  bool? paidStatus;
  int? electricUnit;
  int? electricUnitCharge;
  int? fixedElectricCharge;
  bool? isActive;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory BillModeL.fromJson(Map<String, dynamic> json) {
    return BillModeL(
      id: json["id"],
      uuid: json["uuid"],
      rentId: json["rent_id"],
      nepaliBillCreateDate: DateTime.parse(json["nepali_bill_create_date"]).toString(),
      englishBillCreateDate: DateTime.parse(json["english_bill_create_date"]).toString(),
      // nepaliBillEndDate: json["nepali_bill_end_date"],
      // englishBillEndDate: json["english_bill_end_date"],
      // nepaliBillPaidDate: DateTime.parse(json["nepali_bill_paid_date"]),
      // englishBillPaidDate: DateTime.parse(json["english_bill_paid_date"]),
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
      // createdAt: DateTime.parse(json["createdAt"]),
      // updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }


}

//To parse this JSON data, do

    // final billModeL = billModeLFromJson(jsonString);

// import 'dart:convert';
//
// List<BillModeL> billModeLFromJson(String str) => List<BillModeL>.from(json.decode(str).map((x) => BillModeL.fromJson(x)));
//
// String billModeLToJson(List<BillModeL> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class BillModeL {
//   BillModeL({
//     required this.id,
//     required this.uuid,
//     required this.rentId,
//     // required this.nepaliBillCreateDate,
//     required this.englishBillCreateDate,
//     // required this.nepaliBillEndDate,
//     // required this.englishBillEndDate,
//     // required this.nepaliBillPaidDate,
//     // required this.englishBillPaidDate,
//     required this.additionalCharge,
//     required this.totalCharge,
//     required this.pendingAmount,
//     required this.creditAmount,
//     required this.oldPendingAmount,
//     required this.oldCreditAmount,
//     required this.paidAmount,
//     required this.paidStatus,
//     required this.electricInitialUnitReading,
//     required this.electricEndingUnitReading,
//     required this.perElectricityRatePrice,
//     required this.fixedElectricCharge,
//     required this.totalElectricityCost,
//     required this.water,
//     required this.waste,
//     required this.wifi,
//     required this.isActive,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   int id;
//   String uuid;
//   int rentId;
//   // DateTime nepaliBillCreateDate;
//   DateTime englishBillCreateDate;
//   // String nepaliBillEndDate;
//   // String englishBillEndDate;
//   // String nepaliBillPaidDate;
//   // String englishBillPaidDate;
//   int additionalCharge;
//   int totalCharge;
//   int pendingAmount;
//   int creditAmount;
//   int oldPendingAmount;
//   int oldCreditAmount;
//   int paidAmount;
//   bool paidStatus;
//   int electricInitialUnitReading;
//   int electricEndingUnitReading;
//   int perElectricityRatePrice;
//   int fixedElectricCharge;
//   int totalElectricityCost;
//   int water;
//   int waste;
//   int wifi;
//   bool isActive;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory BillModeL.fromJson(Map<String, dynamic> json) => BillModeL(
//     id: json["id"],
//     uuid: json["uuid"],
//     rentId: json["rent_id"],
//     // nepaliBillCreateDate: DateTime.parse(json["nepali_bill_create_date"]),
//     englishBillCreateDate: DateTime.parse(json["english_bill_create_date"]),
//     // englishBillCreateDate: json["english_bill_create_date"],
//     // nepaliBillEndDate: json["nepali_bill_end_date"],
//     // englishBillEndDate: json["english_bill_end_date"],
//     // nepaliBillPaidDate: json["nepali_bill_paid_date"],
//     // englishBillPaidDate: json["english_bill_paid_date"],
//     additionalCharge: json["additional_charge"],
//     totalCharge: json["total_charge"],
//     pendingAmount: json["pending_amount"],
//     creditAmount: json["credit_amount"],
//     oldPendingAmount: json["old_pending_amount"],
//     oldCreditAmount: json["old_credit_amount"],
//     paidAmount: json["paidAmount"],
//     paidStatus: json["paidStatus"],
//     electricInitialUnitReading: json["electric_initial_unit_reading"],
//     electricEndingUnitReading: json["electric_ending_unit_reading"],
//     perElectricityRatePrice: json["per_electricity_rate_price"],
//     fixedElectricCharge: json["fixed_electric_charge"],
//     totalElectricityCost: json["total_electricity_cost"],
//     water: json["water"],
//     waste: json["waste"],
//     wifi: json["wifi"],
//     isActive: json["isActive"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     updatedAt: DateTime.parse(json["updatedAt"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "uuid": uuid,
//     "rent_id": rentId,
//     // "nepali_bill_create_date": "${nepaliBillCreateDate.year.toString().padLeft(4, '0')}-${nepaliBillCreateDate.month.toString().padLeft(2, '0')}-${nepaliBillCreateDate.day.toString().padLeft(2, '0')}",
//     "english_bill_create_date": englishBillCreateDate.toIso8601String(),
//     // "nepali_bill_end_date": nepaliBillEndDate,
//     // "english_bill_end_date": englishBillEndDate,
//     // "nepali_bill_paid_date": nepaliBillPaidDate,
//     // "english_bill_paid_date": englishBillPaidDate,
//     "additional_charge": additionalCharge,
//     "total_charge": totalCharge,
//     "pending_amount": pendingAmount,
//     "credit_amount": creditAmount,
//     "old_pending_amount": oldPendingAmount,
//     "old_credit_amount": oldCreditAmount,
//     "paidAmount": paidAmount,
//     "paidStatus": paidStatus,
//     "electric_initial_unit_reading": electricInitialUnitReading,
//     "electric_ending_unit_reading": electricEndingUnitReading,
//     "per_electricity_rate_price": perElectricityRatePrice,
//     "fixed_electric_charge": fixedElectricCharge,
//     "total_electricity_cost": totalElectricityCost,
//     "water": water,
//     "waste": waste,
//     "wifi": wifi,
//     "isActive": isActive,
//     "createdAt": createdAt.toIso8601String(),
//     "updatedAt": updatedAt.toIso8601String(),
//   };
// }

