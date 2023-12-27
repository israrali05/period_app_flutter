import 'package:flutter/material.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final double width;
  final double height;
  final double borderRadius;
  final void Function()? ontap;

  final Color borderColor;

  const CustomButton({super.key, 
    required this.text,
    required this.buttonColor,
    required this.width,
    required this.height,
    required this.borderColor,
    required this.borderRadius,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return InkWell(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          shadows: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            )
          ],

          // borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(text,
              style: AppStyles.whitetext700.copyWith(
                  fontSize: MySize.size18, color: AppColors.blackColor)),
        ),
      ),
    );
  }
}
