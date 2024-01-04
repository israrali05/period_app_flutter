import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget {
  final String arrowBacktext;
  final String title;
  const CustomAppBar({
    super.key,
    required this.arrowBacktext,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: MySize.size25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    AppImages.arrowBack,
                    width: MySize.size24,
                    height: MySize.size24,
                  ),
                ),
                SizedBox(
                  width: MySize.size5,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: CustomText(
                      text: arrowBacktext,
                      textStyle: AppStyles.whitetext900.copyWith(
                          fontSize: MySize.size16,
                          color: AppColors.whiteColor)),
                )
              ],
            ),
          ),
          CustomText(
              text: title,
              textStyle:
                  AppStyles.whitetext700.copyWith(fontSize: MySize.size26)),
        ]);
  }
}
