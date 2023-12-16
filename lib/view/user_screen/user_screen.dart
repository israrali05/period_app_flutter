import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leading: Icon(
          Icons.arrow_back_ios_rounded,
          color: AppColors.greyColor,
          size: MySize.size24,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: MySize.size25),
            child: Icon(
              Icons.settings,
              color: AppColors.greyColor,
              size: MySize.size24,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.secondaryColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MySize.size40,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed("/TapToChange");
              },
              child: Center(
                child: CircleAvatar(
                  radius: MySize.size60,
                  backgroundColor: AppColors.greyColor,
                ),
              ),
            ),
            SizedBox(
              height: MySize.size40,
            ),
            CustomText(
                text: "ANNE SHARON",
                textStyle: AppStyles.whitetext700
                    .copyWith(fontSize: MySize.size26, height: 0)),
            CustomText(
                text: "annesharon23@gmail.com",
                textStyle: AppStyles.whitetext700
                    .copyWith(fontSize: MySize.size22, height: 0)),
            SizedBox(
              height: MySize.size40,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: MySize.size40, right: MySize.size10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: "Reminders",
                      textStyle: AppStyles.whitetext700
                          .copyWith(fontSize: MySize.size22, height: 0)),
                  CustomText(
                      text: "Active",
                      textStyle: AppStyles.whitetext700.copyWith(
                          fontSize: MySize.size22,
                          height: 0,
                          color: AppColors.whiteColor.withOpacity(0.7))),
                  SizedBox(
                    height: MySize.size10,
                  ),
                  Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.5,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MySize.size20,
                  ),
                  CustomText(
                      text: "Partner",
                      textStyle: AppStyles.whitetext700
                          .copyWith(fontSize: MySize.size22, height: 0)),
                  CustomText(
                      text: "Keep them in the loop",
                      textStyle: AppStyles.whitetext700.copyWith(
                          fontSize: MySize.size22,
                          height: 0,
                          color: AppColors.whiteColor.withOpacity(0.7))),
                  SizedBox(
                    height: MySize.size10,
                  ),
                  Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.5,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }
}