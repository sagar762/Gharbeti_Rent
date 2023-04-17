import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/steper_controller.dart';
import '../../utils/sharedPreferences.dart';
import '../../validators/validators.dart';
import '../../widget/CustomButton.dart';
import '../../widget/CustomTextField.dart';
import '../../widget/Custom_text.dart';
import '../../widget/color.dart';
import 'MapScreen.dart';
import 'package:get/get.dart';
import 'dart:io';

class HouseInfoForm extends StatefulWidget {
  const HouseInfoForm({Key? key}) : super(key: key);

  @override
  State<HouseInfoForm> createState() => _HouseInfoFormState();
}

class _HouseInfoFormState extends State<HouseInfoForm> {
  int _index = 0;
  File? selectedImage;
  String base64Image = "";

  void getPrefs()async{
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    controller.nameController.text = SharedData.getUserName();
    controller.emailController.text = SharedData.getEmail();
    controller.cityController.text = SharedData.getUserCity();
  }

  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null)  {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
    }
    else {
      return print('please select an image');
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick Image from!!'),
          actions: <Widget>[
            CustomButton(text: 'Camera', onPressed: (){
              chooseImage("camera");
              Get.back();
            }, height: 135.h, width: 35.w,),
            CustomButton(text: 'Gallery', onPressed: (){
              chooseImage("gallery");
              Get.back();
            }, height: 135.h, width: 35.w,)
          ],
        );
      },
    );
  }
  String _selectedVal = 'Kathmandu';
  var items = ['Kathmandu', 'Pokhara', 'Chitwan'];

  void _cancelImage() {
    setState(() {
      selectedImage = null;
    });
  }
  @override
  void initState() {
    getPrefs();
    // TODO: implement initState
    super.initState();
  }

  final controller = Get.put(SteperController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0).h,
                  child: Center(child: CustomText(text: 'कृप्या घर को विवरण भर्नुहोस ', fontWeight: FontWeight.w700, size: 32.0.sp, color: Colors.black, )),
                ),
                CustomTextField(enabled:false, initialvalue: controller.addressController.text, hint: 'Address', prefixIcon: Icon(Icons.location_on, color: AppColor.primarycolor,), textInputType: TextInputType.text, validator: Validator.checkFieldEmpty,
                  onChanged: (value) async {

                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0).h,
                  child: CustomButton(text: 'Choose from Map', onPressed: () async{
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    // prefs.setString('number', controller.numberController.text);
                    // print(prefs.getString('number'));
                    Get.to(()=> MapScreen());
                    setState(() {
                      controller.getprefs();
                    });
                  }, height: 135.h, width: 30.w,),
                ),
                CustomTextField(
                  hint: 'UserName', prefixIcon: Icon(Icons.person, color: AppColor.primarycolor, ), validator: Validator.checkFieldEmpty, controller: controller.nameController,
                ),
                CustomTextField(
                  hint: 'Email', prefixIcon: Icon(Icons.email, color: AppColor.primarycolor,), validator: Validator.checkEmailField, controller: controller.emailController,
                ),
                CustomTextField(controller:controller.gharbetiName, hint: 'Name', prefixIcon: SvgPicture.asset('assets/images/Vector4.svg'), validator: Validator.checkFieldEmpty,),
                CustomTextField(controller:controller.houseNumberController, hint: 'House NUmber', prefixIcon: SvgPicture.asset('assets/images/Vector4.svg'),validator: Validator.checkNumberField, textInputType: TextInputType.number,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0).w.h,
                  child: DropdownButtonFormField(
                    value: _selectedVal,
                    items: items.map((e) => DropdownMenuItem(child: Text(e, style: GoogleFonts.poppins(fontSize: 16.0.sp, fontWeight: FontWeight.w400, color: AppColor.primarycolor),), value: e)).toList(),
                    onChanged: (val){
                      setState(() {
                        setState(() {
                          _selectedVal = val as String;
                          controller.cityController.text = _selectedVal;
                        });
                      },
                      );
                    },
                    icon: Icon(
                      Icons.arrow_drop_down, color: AppColor.primarycolor,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10.r, 0, 0, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0.w, color: AppColor.primarycolor
                          ),
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6.0).w,
                        ),
                        prefixIcon: Container(
                          margin: EdgeInsets.only(right: 16.0).r,
                          decoration: BoxDecoration(
                            border: Border(right: BorderSide(color: Color(0xFFD6D6D6), width: 2.0.w),
                            ),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0).w,
                              child: Icon(Icons.location_on, color: AppColor.primarycolor,)
                          ),
                        )
                    ) ,
                  ),
                ),
                CustomTextField(hint: 'Address', prefixIcon: Icon(Icons.location_on, color: AppColor.primarycolor,),validator: Validator.checkFieldEmpty, controller: controller.addressController1,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('House Bill', style: GoogleFonts.poppins(fontSize: 20.0.sp, color: AppColor.primarycolor, fontWeight: FontWeight.w500),),
                      SizedBox(height: 10.0.h,),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: selectedImage != null
                                ? Stack(
                              children: [
                                Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                  height: 150.h,
                                  width: 150.w,

                                ),
                                Positioned.fill(
                                    top: 8.h,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child : Container(
                                        child: InkWell(
                                            onTap: (){
                                              _cancelImage();
                                            },
                                            child: Center(child: Icon(Icons.cancel, color: Colors.red, size: 50,))),
                                      ),
                                    )
                                )
                              ],

                            ) :
                            Container(
                              height: 150.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  color: AppColor.backgroundcolor,
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: GestureDetector(
                                  onTap: (){
                                    _dialogBuilder(context);
                                  },
                                  child: Icon(Icons.add, size: 50.sp, color: AppColor.primarycolor,)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                Center(
                  child: CustomButton(text: 'Submit', height: 135.h, width: 35.w, onPressed: (){
                    controller.CreateGharbeti(context, gharbetiName: controller.gharbetiName.text, houseNumber: controller.houseNumberController.text, userEmail: controller.gharbetiEmailController.text, city: controller.cityController.text, location: controller.addressController1.text);

                  },),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
