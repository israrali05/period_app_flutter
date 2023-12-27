import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final TextAlign? textAlign; // Add TextAlign as an optional parameter

  const CustomText({super.key, 
    required this.text,
    required this.textStyle,
    this.textAlign, // Include textAlign as an optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      textAlign: textAlign, // Set the textAlign property in the Text widget
    );
  }
}
      