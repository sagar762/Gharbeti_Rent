import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  CustomText({ required this.text, required this.fontWeight, required this.size, required this.color, this.decoration, this.decorationStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text, style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight, fontFamily: 'Preeti', decoration: decoration, decorationStyle: decorationStyle),
    );
  }
}
