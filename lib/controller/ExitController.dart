import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gharbeti/widget/CustomButton.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/color.dart';

class ExitController extends GetxController{
  DateTime? lastPressed;
  bool willLeave = false;
  Future<bool> onExit() async {
  await showDialog(
    context: Get.overlayContext!,
    builder: (_) => AlertDialog(
      title: Text('Are you sure you want to exit the app?', style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w500) ,),
      actions: [
        CustomButton(text: 'Yes', onPressed: (){
          willLeave = true;
         SystemNavigator.pop();
        }, height: 135.h, width: 35.w,),
        CustomButton(text: 'No', onPressed: () => Get.back(result: false), height: 135.h, width: 35.w,)
      ],
    )

  );
  return willLeave;
   }
 }
