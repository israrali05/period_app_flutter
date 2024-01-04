import 'package:flutter/material.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class UserTextfieldWidget extends StatelessWidget {
  final String lableText;
  final TextEditingController? controller;
  const UserTextfieldWidget({
    super.key,
    required this.lableText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: lableText,
              textStyle: AppStyles.whitetext700
                  .copyWith(fontSize: MySize.size15, height: 0)),
          TextField(
            controller: controller,
            style: AppStyles.whitetext700.copyWith(
                fontSize: MySize.size18,
                color: AppColors.primaryColor), // Text color
            cursorColor: AppColors.primaryColor,
            // Cursor color
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              // hintText: 'First Name', // Hint text
              // hintStyle: AppStyles.whitetext700
              //     .copyWith(fontSize: MySize.size15), // Hint text color
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white), // Border color when enabled
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.primaryColor), // Border color when focused
              ),
            ),
          ),
        ]);
  }
}
