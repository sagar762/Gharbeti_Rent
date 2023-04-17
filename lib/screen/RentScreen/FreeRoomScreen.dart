
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gharbeti/model/Class_ModeL.dart';
import 'package:gharbeti/screen/home/BottomNavigationBar.dart';
import 'package:gharbeti/validators/validators.dart';
import 'package:gharbeti/widget/CustomAppBar.dart';
import 'package:gharbeti/widget/CustomButton.dart';
import 'package:gharbeti/widget/CustomTextField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/billController.dart';
import '../../controller/roomController.dart';
import '../../model/RentModel.dart';
import '../../widget/color.dart';
import 'package:gharbeti/model/HomeModel.dart';
import 'package:get/get.dart';
import 'package:gharbeti/model/Class_ModeL.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FreeRoomScreen extends StatefulWidget {
  const FreeRoomScreen({Key? key}) : super(key: key);

  @override
  State<FreeRoomScreen> createState() => _FreeRoomScreenState();
}

List<UserPhoneNumber> display_list = List.from(users);

class _FreeRoomScreenState extends State<FreeRoomScreen> {
  int oldUnitValue = 1;
  int newUnitValue = 1;
  int fixedRate = 1;
  final _controller = Get.put(RoomController());
  bool listVisible = false;
  bool _isButtonPressed = true;
  // TextEditingController _dateController = TextEditingController();



  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // void updateList(String value) {
  //   // List<RentModel> user_list = List.from(_controller.userList);
  //   setState(() {
  //     if(value.trim().isNotEmpty){
  //       _controller.user_list = _controller.userList.where((element) => element.phoneNumber!.toLowerCase()==(value.toLowerCase())).toList();
  //     }
  //   });
  // }


  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to save?'),
          actions: <Widget>[
            CustomButton(text: 'Yes', onPressed: (){
              Get.to(()=>BottomNavigationBarScreen());
            },height: 135.h, width: 35.w,),
            CustomButton(text: 'No', onPressed: (){
              Get.back();
            },height: 135.h, width: 35.w,)
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundcolor,

        appBar: CustomAppBar(title: 'Create Tenant',),
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  validator: Validator.checkFieldEmpty,
                  controller: _controller.searchController,
                  onChanged: (value) => _controller.fetchUserData(),
                  // onChanged: (value)=> updateList(value),
                  hint: 'Search Phone Number',
                  prefixIcon: Icon(Icons.phone, color: AppColor.primarycolor,),
                  suffixIcon: GestureDetector(
                    onTap: (){

                      // print(searchController.text);
                    },
                      child: Icon(Icons.search, color: AppColor.primarycolor,)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0).w,
                  child:  _controller.searchController.text=='' ?Container():Text('Search Results', style: GoogleFonts.poppins(fontSize: 14.0.sp ),),
                ),
                SizedBox(height: 10.h,),
                Obx(
                    ()=> _controller.isLoading.value ? Center(child: const CircularProgressIndicator()):
                   Container(
                      child:
                      // _controller.userList.length == 0? Center(child: Text('Please Enter 10 digit number',  style: GoogleFonts.poppins(fontSize: 22.0.sp, fontWeight: FontWeight.w600, color: Colors.black),),):
                      _controller.searchController.text == '' ? Container() :ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index){
                            return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0).w.h,
                              child: Container(
                                height: 160.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 18.0).h,
                                  child: ListTile(
                                      leading: CircleAvatar(
                                          radius: 40.0.r,
                                          backgroundColor: const Color(0xffF2F2F2),
                                          child: Icon(Icons.person, color: Colors.black,)
                                      ),
                                      title: Text(_controller.mapResponse.value['name'].toString(), style: GoogleFonts.poppins(fontSize: 20.0.sp, fontWeight:FontWeight.w600 ),),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(_controller.mapResponse.value['address'].toString(), style: GoogleFonts.poppins(fontSize:14.0.sp, fontWeight: FontWeight.w300 ),),
                                          Text(_controller.mapResponse.value['phone_number'].toString(), style: GoogleFonts.poppins(fontSize:14.0.sp, fontWeight: FontWeight.w300 ),),
                                          SizedBox(height: 5.0.h,),
                                          Container(
                                            height: 30.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                              color: Color(0xffF2F2F2),
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                SvgPicture.asset('assets/images/Group 41.svg',height: 20.0,),
                                                Text('Verified', style: GoogleFonts.poppins(fontSize: 14.0.sp, fontWeight: FontWeight.w300),)
                                              ],
                                            ),
                                          )

                                        ],
                                      ),
                                      // onTap: (){
                                      //   setState(() {
                                      //     display_list.removeAt(index);
                                      //   });
                                      //   setState(() {
                                      //
                                      //   });
                                      // },
                                      trailing: GestureDetector(
                                        onTap: () {
                                          Get.showSnackbar(
                                            GetSnackBar(
                                              title: 'Button is tapped',
                                              message: '${_controller.mapResponse.value['name'].toString()} field is selected',
                                              backgroundColor: AppColor.primarycolor,
                                              duration: const Duration(seconds: 3),
                                            ),
                                          );
                                          setState(() {
                                            listVisible = true;
                                            _controller.namecontroller.text = _controller.mapResponse.value['name'].toString();
                                          });
                                        },
                                        child: Container(
                                          height: 35.0.h,
                                          width: 35.0.w,
                                          decoration: BoxDecoration(
                                              color: Color(0xffF2F2F2),
                                              borderRadius: BorderRadius.circular(15.0)
                                          ),
                                          child: Icon(Icons.add),
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            );
                          }
                      )
                  ),
                ),
                listVisible==true?Column(
                  children: [
                    SizedBox(
                      height: 20.0.h,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0).w,
                      child: Container(
                        height: 950.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0).w.h,
                              child: Text('Details', style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 22.0.sp),),
                            ),
                            CustomTextField(hint: 'Name', controller: _controller.namecontroller, prefixIcon: Icon(Icons.person, color: AppColor.primarycolor,), validator: Validator.checkFieldEmpty,),
                            CustomTextField(hint: 'Number of Rooms', controller: _controller.roomController, prefixIcon: Icon(Icons.person, color: AppColor.primarycolor,), validator: Validator.checkNumberField,),
                            GestureDetector(
                              onTap: () {
                                _controller.showDatePicker(context);
                              },
                              child: CustomTextField(
                                validator:
                                Validator.checkFieldEmpty,
                                enabled: false,
                                controller: _controller.dateController,
                                hint: 'Nepali Date',
                                prefixIcon: SvgPicture.asset(
                                    'assets/images/Group 54.svg'),
                              ),
                            ),

                            CustomTextField( hint: 'Water', controller: _controller.waterController, prefixIcon: Icon(Icons.person, color: AppColor.primarycolor,), validator: Validator.checkNumberField,),
                            CustomTextField( hint: 'Waste', controller: _controller.wasteController, prefixIcon: Icon(Icons.person, color: AppColor.primarycolor,), validator: Validator.checkNumberField,),
                            CustomTextField( hint: 'Wifi', controller: _controller.wifiController, prefixIcon: Icon(Icons.person, color: AppColor.primarycolor,), validator: Validator.checkNumberField,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Electricity',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0.sp),
                              ),
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 1,
                                    groupValue: _controller.value,
                                    activeColor:
                                    AppColor.primarycolor,
                                    onChanged: (value) {
                                      setState(() {
                                        _controller.value = value!;
                                        _controller.showTextField = true;
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
                            if (_controller.value == 1)
                              CustomTextField(
                                validator: Validator
                                    .checkNumberField,
                                textInputType:
                                TextInputType.phone,
                                controller: _controller.fixedController,
                                prefixIcon: SvgPicture.asset(
                                    'assets/images/Vector1.svg'),
                                hint: '500',
                              ),
                            Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: _controller.value,
                                  activeColor:
                                  AppColor.primarycolor,
                                  onChanged: (value) {
                                    setState(() {
                                      _controller.value = value!;
                                      _controller.showTextField = true;
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
                            if (_controller.value == 2)
                              Column(
                                children: [
                                  CustomTextField( hint: 'Old ELectricity Unit', controller: _controller.oldElectricityUnit, prefixIcon: Icon(Icons.person, color: AppColor.primarycolor,), validator: Validator.checkNumberField,),
                                  CustomTextField(
                                    controller: _controller.electricityChargeController,
                                    hint: 'Electric Charge',
                                    prefixIcon: SvgPicture.asset(
                                        'assets/images/Vector1.svg'),
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
                            CustomTextField( hint: 'Rent Amount', controller: _controller.rentController, prefixIcon: Icon(Icons.person, color: AppColor.primarycolor,), validator: Validator.checkNumberField,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(text: 'Cancel', onPressed: () {
                          setState(() {
                            listVisible = false;
                          });
                        },height: 135.h, width: 35.w,),
                        CustomButton(text: 'Save', onPressed: () async{
                          print('called');
                          _controller.createRent(context, name: _controller.namecontroller.text, no_of_room: _controller.roomController.text, price: _controller.rentController.text, nepali_Date: _controller.dateController.text, electric_reading_unit: _controller.oldElectricityUnit.text, wifi: _controller.wifiController.text, water: _controller.waterController.text, waste: _controller.wasteController.text, per_electricity_rate_price: _controller.electricityChargeController.text, fixed_electric_charge: _controller.fixedController.text);
                        },height: 135.h, width: 35.w,),

                      ],
                    ),
                  ],
                ):Container()
              ],
            ),
          ),
        ),
      ),

    );
  }
}

