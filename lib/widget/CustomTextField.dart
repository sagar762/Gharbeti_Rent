import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gharbeti/widget/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String? initialvalue;
  final bool? enabled;
  final String? hint;
  final TextInputFormatter? formatter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  final Function(String)? onTap;
  final String? Function(String?)? validator;


    CustomTextField({Key? key, this.onSubmitted, this.onChanged, this.formatter, this.enabled, this.initialvalue, this.onTap, this.textInputType, this.controller,this.hint,this.prefixIcon, this.onSaved, this.suffixIcon, this.validator });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0).w.h,
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        initialValue: initialvalue,
        keyboardType: textInputType,
        onSaved: onSaved,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        validator: validator,
        decoration:  InputDecoration(
          errorStyle: TextStyle(
            fontSize: 10.0.sp,
          ),
          suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          hintText: hint,
          hintStyle: GoogleFonts.poppins(fontSize: 16.0.sp, fontWeight: FontWeight.w400, color: AppColor.primarycolor
          ),
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
              child: prefixIcon
            ),
          )
        ) ,
      ),
    );
  }
}
