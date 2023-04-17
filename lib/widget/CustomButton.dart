import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gharbeti/widget/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {

  // final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  //
  //   primary: AppColor.primarycolor,
  //   minimumSize: Size(height, 35.w),
  //   padding: EdgeInsets
  //       .symmetric(horizontal: 16)
  //       .w,
  //
  //   shape: const RoundedRectangleBorder(
  //     borderRadius: BorderRadius.all(Radius.circular(12)),
  //   ),
  // );
  final String text;
  final Function()? onPressed;
  final double height;
  final double width;
  CustomButton({Key? key, required this.text, this.onPressed, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(

        primary: AppColor.primarycolor,
        minimumSize: Size(height,width),
        padding: EdgeInsets
            .symmetric(horizontal: 16)
            .w,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.poppins(
            color: Color(0xFFFFFFFF),
            fontSize: 18.0.sp,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
