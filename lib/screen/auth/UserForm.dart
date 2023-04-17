import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gharbeti/controller/loginController.dart';
import 'package:gharbeti/widget/CustomAppBar.dart';
import 'package:gharbeti/widget/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../widget/CustomButton.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();


}


class _UserFormState extends State<UserForm> {

  File? _image1;
  File? _image2;

  Future getImage1() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  Future getImageFromCamera1() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  Future getImageFromCamera2() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage2() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick Image from!!'),
          actions: <Widget>[
            CustomButton(text: 'Camera', onPressed: (){
              getImageFromCamera1();
              Get.back();
            },height: 135.h, width: 35.w,),
            CustomButton(text: 'Gallery', onPressed: (){
              getImage1();
              Get.back();
            },height: 135.h, width: 35.w,)
          ],
        );
      },
    );
  }
  Future<void> _dialogBuilder1(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick Image from!!'),
          actions: <Widget>[
            CustomButton(text: 'Camera', onPressed: (){
              getImageFromCamera2();
              Get.back();
            }, height: 135.h, width: 35.w,),
            CustomButton(text: 'Gallery', onPressed: (){
              getImage2();
              Get.back();
            }, height: 135.h, width: 35.w,)
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundcolor,
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('User Form', style: GoogleFonts.poppins(fontSize: 22.0.sp, fontWeight: FontWeight.w600),)),
              SizedBox(height: 50.h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0).w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text('Citizenship Front Image', style: GoogleFonts.poppins(fontSize: 20.0.sp, color: AppColor.primarycolor, fontWeight: FontWeight.w500),),
                    SizedBox(height: 10.0.h,),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: _image1 != null
                            ? Image.file(
                          _image1!,
                          fit: BoxFit.cover,
                          height: 150.h,
                          width: 150.w,

                        ) : Container(
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
                        )
                    ),
                    SizedBox(height: 20.h,),


                    Text('Citizenship Back Image', style: GoogleFonts.poppins(fontSize: 20.0.sp, color: AppColor.primarycolor, fontWeight: FontWeight.w500),),
                    SizedBox(height: 10.0.h,),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: _image2 != null
                            ? Image.file(
                          _image2!,
                          fit: BoxFit.cover,
                          height: 150.h,
                          width: 150.w,

                        ) : Container(
                          height: 150.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                              color: AppColor.backgroundcolor,
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          child: GestureDetector(
                              onTap: (){
                                // getImage1();
                                _dialogBuilder1(context);
                              },
                              child: Icon(Icons.add, size: 50.sp, color: AppColor.primarycolor,)),
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60.h,),
              Center(child: CustomButton(text: 'Submit', onPressed: () async{
                controller.userSelect(context,firstPhoto: _image1!.toString(), backPhoto: _image2!.toString() );

              }, height: 135.h, width: 35.w,))

            ],
          ),
        )
      ),
    );
  }
}
