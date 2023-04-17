import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gharbeti/controller/billController.dart';
import 'package:gharbeti/model/Class_ModeL.dart';
import 'package:gharbeti/screen/auth/NepaliCalendar.dart';
import 'package:gharbeti/screen/home/BottomNavigationBar.dart';
import 'package:gharbeti/utils/sharedPreferences.dart';
import 'package:gharbeti/validators/validators.dart';
import 'package:gharbeti/widget/CustomAppBar.dart';
import 'package:gharbeti/widget/CustomButton.dart';
import 'package:gharbeti/widget/CustomTextField.dart';
import 'package:gharbeti/widget/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../model/ApiConfig.dart';
import '../../utils/notification.dart';

class BillScreen extends StatefulWidget {
  final String title;
  final String name;
  BillScreen({
    Key? key,
    required this.title,
    required this.name,

  }) : super(key: key);

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final controller = Get.put(BillController());
  int oldUnitValue = 1;
  bool buttonVisible = true;
  int newUnitValue = 1;
  int fixedRate = 1;
  int total =1;
  @override
  void initState() {
    // controller.oldUnitController.text = SharedData.getElectricity();
    controller.initializeNotifications();
    controller.getBillDetail();
    // DateTime now = DateTime.now().toUtc().add(
    //   Duration(minutes: 1),
    // );
    //  controller.singleNotification(
    //     now,
    //     "Bill Info",
    //     "Please Pay a Bill",
    //     98123871,
    //    // RepeatInterval.everyMinute,
    //
    // );
    controller.getPrefs();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      appBar: CustomAppBar(
        title: '${widget.title}',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0).h,
              child: Center(
                  child: Text(
                'Bill For Month ${widget.title} 2080 B.S.',
                style: GoogleFonts.poppins(
                    fontSize: 20.0.sp, fontWeight: FontWeight.w600),
              )),
            ),
            SizedBox(
              height: 20.0.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0.w),
              child: Container(
                height: 400.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 12.0)
                      .w
                      .h,
                  child: Obx(()=>
                  controller.isLoading.value ? Center(child: CircularProgressIndicator(),) :
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.name}',
                          style: GoogleFonts.poppins(
                              fontSize: 20.0.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 15.0.h,
                        ),
                        UserDetail(
                            image: 'assets/images/Group 48.svg',
                            text: 'Number of Rooms',
                            price:controller.data.value['rent']['no_of_room'].toString(),
                            // price: controller.numOfRooms.value == '' ? '-' : '${controller.numOfRooms.value}'
                        ),
                        UserDetail(
                            image: 'assets/images/Group 48.svg',
                            text: 'Rent Charges',
                            price: controller.data.value['rent']['price'].toString()
                        ),
                        UserDetail(
                          image: 'assets/images/Vector1.svg',
                          text: 'Electricity Charges',
                          price: controller.value == 1 ? controller.data.value['bill']['fixed_electric_charge'].toString() : controller.data.value['bill']['total_electricity_cost'].toString(),
                          // price: electricCharge == 0 ? '0' : electricCharge
                          // price: controller.data.value['bill']['electric_unit_charge'].toString() == null ? '0': '${controller.data.value['bill']['electric_unit_charge'].toString()}',
                        ),
                        UserDetail(
                            image: 'assets/images/Vector2.svg',
                            text: 'Water Charges',
                            price: controller.data.value['bill']['water'].toString(),
                        ),
                        UserDetail(
                            image: 'assets/images/bag.svg',
                            text: 'Waste Charges',
                            price: controller.data.value['bill']['waste'].toString(),
                        ),
                        UserDetail(
                          image: 'assets/images/Vector3.svg',
                          text: 'Extra Charges',
                          price: controller.data.value['bill']['additional_charge'].toString() == null ? '0': controller.data.value['bill']['additional_charge'].toString(),
                          // price: addionalCharge == 0 ? '0' : addionalCharge,
                        ),
                        SizedBox(
                          height: 7.0.h,
                        ),
                        UserDetail(
                          text: 'Pending Charges',
                          price: controller.data.value['bill']['pending_amount'].toString(),
                        ),
                        UserDetail(
                          text: 'Credit Charges',
                          price: controller.data.value['bill']['credit_amount'].toString(),
                        ),
                        SizedBox(
                          height: 10.0.h,
                        ),
                        UserDetail(
                          text: 'Bill Total',
                          price: controller.data.value['bill']['total_charge'].toString(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0.h,
            ),

               controller.buttonVisible.value
                  ?
                     CustomButton(
                        text: 'Generate Bill',
                        onPressed: () {
                          // bool result = await Navigator.push(context);
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            )),
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  final bottom =
                                      MediaQuery.of(context).viewInsets.bottom;
                                  controller.buttonVisible.value = false;
                                  return SingleChildScrollView(
                                    child: Form(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height * 0.8,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 30.0)
                                                  .w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0).h,
                                                child: Center(
                                                    child: Text(
                                                  'Enter Details',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20.0.sp,
                                                      fontWeight: FontWeight.w500),
                                                )),
                                              ),
                                              Text(
                                                'Electricity',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0.sp),
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                      value: 1,
                                                      groupValue: controller.value,
                                                      activeColor:
                                                          AppColor.primarycolor,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          controller.value = value!;
                                                          controller.showTextField = true;
                                                        });
                                                        // controller.value = value!;
                                                        // controller.showTextField = true;
                                                      }),
                                                  SizedBox(
                                                    width: 5.0.w
                                                  ),
                                                  Text(
                                                    'Fixed Amount',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16.0.sp,
                                                        fontWeight: FontWeight.w300),
                                                  )
                                                ],
                                              ),
                                              if (controller.value == 1)
                                                CustomTextField(
                                                  validator:
                                                      Validator.checkNumberField,
                                                  controller:controller.fixedController,
                                                  prefixIcon: SvgPicture.asset(
                                                      'assets/images/Vector1.svg'),
                                                  hint: '500',
                                                ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 2,
                                                    groupValue: controller.value,
                                                    activeColor:
                                                        AppColor.primarycolor,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        controller.value = value!;
                                                        controller.showTextField = true;
                                                      });
                                                      // controller.value = value!;
                                                      // controller.showTextField = true;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 5.0.w,
                                                  ),
                                                  Text(
                                                    'Units',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16.0.sp,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              if (controller.value == 2)
                                                Column(
                                                  children: [
                                                    // Row(
                                                    //   children: [
                                                    //     SizedBox(
                                                    //       width:MediaQuery.of(context).size.width*0.4,
                                                    //       child: CustomTextField(
                                                    //         onChanged: (value) async{
                                                    //       final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    //       setState(() {
                                                    //       oldUnitValue = int.parse(controller.oldUnitController.text);
                                                    //       fixedRate = prefs.getInt('ElectricityUnit')!;
                                                    //       total = oldUnitValue * fixedRate;
                                                    //       print(total);
                                                    //       // print(fixedRate);
                                                    //       // controller.oldUnitController.text = total.toString();
                                                    //       });
                                                    //         },
                                                    //         controller: controller.oldUnitController,
                                                    //         prefixIcon: SvgPicture.asset(
                                                    //             'assets/images/Vector1.svg'),
                                                    //         hint: 'Old Unit',
                                                    //       ),
                                                    //     ),
                                                    //     SizedBox(
                                                    //       width:MediaQuery.of(context).size.width*0.4,
                                                    //       child: CustomTextField(
                                                    //         controller: controller.newUnitController,
                                                    //         onChanged: (value) async{
                                                    //           final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    //           setState(() {
                                                    //             newUnitValue = int.parse(controller.newUnitController.text);
                                                    //             fixedRate = prefs.getInt('ElectricityUnit')!;
                                                    //             oldUnitValue = int.parse(controller.oldUnitController.text);
                                                    //             int totalNewUnit = (newUnitValue * fixedRate) - total;
                                                    //             print(totalNewUnit);
                                                    //             controller.electricityChargeController.text = totalNewUnit.toString();
                                                    //
                                                    //           });
                                                    //         // onSubmitted:
                                                    //           // newUnitValue = int.parse(controller.newUnitController.text);
                                                    //           // fixedRate = prefs.getInt('ElectricityUnit')!;
                                                    //           // oldUnitValue = int.parse(controller.oldUnitController.text);
                                                    //           // int totalNewUnit = (newUnitValue * fixedRate) - oldUnitValue;
                                                    //           // print(totalNewUnit);
                                                    //           // controller.electricityChargeController.text = totalNewUnit.toString();
                                                    //         },
                                                    //         prefixIcon: SvgPicture.asset(
                                                    //             'assets/images/Vector1.svg'),
                                                    //         hint: 'New Unit',
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    CustomTextField(
                                                      controller: controller.newUnitController,
                                                      hint: 'New Electricity Reading',
                                                      prefixIcon: SvgPicture.asset(
                                                          'assets/images/Vector1.svg'),
                                                      onChanged: (value)async{
                                                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                        int oldReading = int.parse(prefs.getString('OldUnitReading').toString());
                                                        print(oldReading);
                                                        int unitCharge = int.parse(prefs.getString('UnitCharge').toString());
                                                        print(unitCharge);
                                                        int finalPrice = (int.parse(controller.newUnitController.text) - oldReading) * unitCharge;
                                                        controller.electricityChargeController.text = finalPrice.toString();
                                                      },
                                                    ),
                                                    CustomTextField(
                                                      enabled: false,
                                                      controller: controller.electricityChargeController,
                                                      hint: 'Electric Charge',
                                                      prefixIcon: SvgPicture.asset(
                                                          'assets/images/Vector1.svg'),
                                                      onChanged: (value)async {

                                                      },
                                                      // onSubmitted: (value)async{
                                                      //   final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                      //   setState((){
                                                      //     newUnitValue = int.parse(controller.newUnitController.text);
                                                      //     fixedRate = prefs.getInt('ElectricityUnit')!;
                                                      //     oldUnitValue = int.parse(controller.oldUnitController.text);
                                                      //     int totalNewUnit = (newUnitValue * fixedRate) - oldUnitValue;
                                                      //     print(totalNewUnit);
                                                      //
                                                      //     // totalNewUnit
                                                      //   });
                                                      // },
                                                    )
                                                  ],
                                                ),

                                              // SizedBox(
                                              //   width:MediaQuery.of(context).size.width/2,
                                              //   child: CustomTextField(
                                              //     prefixIcon: SvgPicture.asset(
                                              //         'assets/images/Vector1.svg'),
                                              //     hint: '500',
                                              //   ),
                                              // ),
                                              Text(
                                                'Extra Charges',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0.sp),
                                              ),
                                              CustomTextField(
                                                validator: Validator.checkNumberField,
                                                controller: controller.chargeController,
                                                hint: 'Extra Charges',
                                                prefixIcon: SvgPicture.asset(
                                                    'assets/images/Vector3.svg'),
                                              ),
                                              Text(
                                                'Pick Date',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0.sp),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.showDatePicker(context);
                                                },
                                                child: CustomTextField(
                                                  validator:
                                                      Validator.checkFieldEmpty,
                                                  enabled: false,
                                                  controller: controller.dateController,
                                                  hint: 'Nepali Date',
                                                  prefixIcon: SvgPicture.asset(
                                                      'assets/images/Group 54.svg'),
                                                ),
                                              ),
                                              Center(
                                                  child: CustomButton(
                                                text: 'Confirm',
                                                onPressed: () {

                                                  // setState((){
                                                  //   buttonVisible = false;
                                                  //
                                                  // });
                                                  controller.updateBill(context, nepali_paid_date: controller.dateController.text, electric_unit: controller.newUnitController.text, extra_charge: controller.chargeController.text, fixed_electric_charge: controller.electricityChargeController.text);

                                                  // Get.back();

                                                     // setState((){
                                                     //   // Get.back();
                                                     //   Get.to(()=>BillScreen(title: 'Baisakh' , name:widget.name));
                                                     // });

                                                  // Get.back();
                                                },
                                                height: 135.h,
                                                width: 35.w,
                                              ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        height: 135.h,
                        width: 35.w,
                      )

                  : Container(),
             controller.buttonVisible.value
                  ? Container()
                  : Column(
                      children: [
                        CustomButton(
                          text: 'Edit',
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              )),
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) setState) {
                                    final bottom =
                                        MediaQuery.of(context).viewInsets.bottom;
                                    controller.buttonVisible.value = false;
                                    return SingleChildScrollView(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                                  horizontal: 30.0)
                                              .w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 12.0).h,
                                                child: Center(
                                                    child: Text(
                                                  'Enter Details',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20.0.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                              ),
                                              Text(
                                                'Electricity',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0.sp),
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                      value: 1,
                                                      groupValue: controller.value,
                                                      activeColor:
                                                          AppColor.primarycolor,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          controller.value = value!;
                                                          controller.showTextField = true;
                                                        });
                                                        // controller.value = value!;
                                                        // controller.showTextField = true;
                                                      }),
                                                  SizedBox(
                                                    width: 5.0.w,
                                                  ),
                                                  Text(
                                                    'Fixed Amount',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16.0.sp,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  )
                                                ],
                                              ),
                                              if (controller.value == 1)
                                                CustomTextField(
                                                  validator: Validator
                                                      .checkNumberField,
                                                  textInputType:
                                                      TextInputType.phone,
                                                  controller: controller.fixedController,
                                                  prefixIcon: SvgPicture.asset(
                                                      'assets/images/Vector1.svg'),
                                                  hint: '500',
                                                ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 2,
                                                    groupValue: controller.value,
                                                    activeColor:
                                                        AppColor.primarycolor,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        controller.value = value!;
                                                        controller.showTextField = true;
                                                      });
                                                      // controller.value = value!;
                                                      // controller.showTextField = true;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 5.0.w,
                                                  ),
                                                  Text(
                                                    'Units',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16.0.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              if (controller.value == 2)
                                                Column(
                                                  children: [
                                                    // Row(
                                                    //   children: [
                                                    //     SizedBox(
                                                    //       width:MediaQuery.of(context).size.width*0.4,
                                                    //       child: CustomTextField(
                                                    //         onChanged: (value) async{
                                                    //       final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    //       setState(() {
                                                    //       oldUnitValue = int.parse(controller.oldUnitController.text);
                                                    //       fixedRate = prefs.getInt('ElectricityUnit')!;
                                                    //       total = oldUnitValue * fixedRate;
                                                    //       print(total);
                                                    //       // print(fixedRate);
                                                    //       // controller.oldUnitController.text = total.toString();
                                                    //       });
                                                    //         },
                                                    //         controller: controller.oldUnitController,
                                                    //         prefixIcon: SvgPicture.asset(
                                                    //             'assets/images/Vector1.svg'),
                                                    //         hint: 'Old Unit',
                                                    //       ),
                                                    //     ),
                                                    //     SizedBox(
                                                    //       width:MediaQuery.of(context).size.width*0.4,
                                                    //       child: CustomTextField(
                                                    //         controller: controller.newUnitController,
                                                    //         onChanged: (value) async{
                                                    //           final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    //           setState(() {
                                                    //             newUnitValue = int.parse(controller.newUnitController.text);
                                                    //             fixedRate = prefs.getInt('ElectricityUnit')!;
                                                    //             oldUnitValue = int.parse(controller.oldUnitController.text);
                                                    //             int totalNewUnit = (newUnitValue * fixedRate) - total;
                                                    //             print(totalNewUnit);
                                                    //             controller.electricityChargeController.text = totalNewUnit.toString();
                                                    //
                                                    //           });
                                                    //         // onSubmitted:
                                                    //           // newUnitValue = int.parse(controller.newUnitController.text);
                                                    //           // fixedRate = prefs.getInt('ElectricityUnit')!;
                                                    //           // oldUnitValue = int.parse(controller.oldUnitController.text);
                                                    //           // int totalNewUnit = (newUnitValue * fixedRate) - oldUnitValue;
                                                    //           // print(totalNewUnit);
                                                    //           // controller.electricityChargeController.text = totalNewUnit.toString();
                                                    //         },
                                                    //         prefixIcon: SvgPicture.asset(
                                                    //             'assets/images/Vector1.svg'),
                                                    //         hint: 'New Unit',
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    CustomTextField(
                                                      controller: controller.newUnitController,
                                                      hint: 'New Electricity Reading',
                                                      prefixIcon: SvgPicture.asset(
                                                          'assets/images/Vector1.svg'),
                                                      onChanged: (value)async{
                                                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                        int oldReading = int.parse(prefs.getString('OldUnitReading').toString());
                                                        print(oldReading);
                                                        int unitCharge = int.parse(prefs.getString('UnitCharge').toString());
                                                        print(unitCharge);
                                                        int finalPrice = (int.parse(controller.newUnitController.text) - oldReading) * unitCharge;
                                                        controller.electricityChargeController.text = finalPrice.toString();
                                                      },
                                                    ),
                                                    CustomTextField(
                                                      enabled: false,
                                                      controller: controller.electricityChargeController,
                                                      hint: 'Electric Charge',
                                                      prefixIcon: SvgPicture.asset(
                                                          'assets/images/Vector1.svg'),
                                                      onChanged: (value)async {

                                                      },
                                                      // onSubmitted: (value)async{
                                                      //   final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                      //   setState((){
                                                      //     newUnitValue = int.parse(controller.newUnitController.text);
                                                      //     fixedRate = prefs.getInt('ElectricityUnit')!;
                                                      //     oldUnitValue = int.parse(controller.oldUnitController.text);
                                                      //     int totalNewUnit = (newUnitValue * fixedRate) - oldUnitValue;
                                                      //     print(totalNewUnit);
                                                      //
                                                      //     // totalNewUnit
                                                      //   });
                                                      // },
                                                    )
                                                  ],
                                                ),
                                              Text(
                                                'Extra Charges',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0.sp),
                                              ),
                                              CustomTextField(
                                                textInputType:
                                                    TextInputType.phone,
                                                validator:
                                                    Validator.checkNumberField,
                                                controller: controller.chargeController,
                                                hint: 'Extra Charges',
                                                prefixIcon: SvgPicture.asset(
                                                    'assets/images/Vector3.svg'),
                                              ),
                                              Text(
                                                'Pick Date',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0.sp),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.showDatePicker(context);
                                                },
                                                child: CustomTextField(
                                                  validator:
                                                      Validator.checkFieldEmpty,
                                                  enabled: false,
                                                  controller: controller.dateController,
                                                  hint: 'Nepali Date',
                                                  prefixIcon: SvgPicture.asset(
                                                      'assets/images/Group 54.svg'),
                                                ),
                                              ),
                                              Center(
                                                  child: CustomButton(
                                                text: 'Confirm',
                                                onPressed: () {
                                                  // setState((){
                                                  //   controller.updateBill(context, electric_unit: controller.electricityChargeController.text);
                                                  // });
                                                  controller.updateBill(context, nepali_paid_date: controller.dateController.text, electric_unit: controller.newUnitController.text, extra_charge: controller.chargeController.text, fixed_electric_charge: controller.electricityChargeController.text);

                                                  // setState((){
                                                  //   buttonVisible = false;
                                                  // });
                                                  // if (controller.formKey.currentState!
                                                  //     .validate()) {
                                                  //   Get.back();
                                                  // }
                                                },
                                                height: 135.h,
                                                width: 35.w,
                                              ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                            // setState(() {
                            //   buttonVisible = false;
                            // });
                            controller.buttonVisible.value = false;

                          },
                          height: 135.h,
                          width: 35.w,
                        ),
                        SizedBox(height: 10.h,),
                        CustomButton(
                          text: 'Confirm Payment',
                          onPressed: () async{
                            controller.dialogBuilder(context);
                            // controller.buttonVisible.value = true;
                          },
                          height: 135.h,
                          width: 35.w,
                        )
                      ],
                    ),
          ],
        ),
      ),
    );
  }
}

class UserDetail extends StatelessWidget {
  final String? image;
  final String? text;
  final String? price;
  const UserDetail({Key? key, this.image, this.text, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0).h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              image == null
                  ? Container()
                  : SvgPicture.asset(
                      image!,
                    ),
              SizedBox(
                width: 10.0.w,
              ),
              Text(
                '${text}: ',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400, fontSize: 16.0.sp),
              ),
            ],
          ),
          Text(
            '${price}',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400, fontSize: 16.0.sp),
          )
        ],
      ),
    );
  }
}
