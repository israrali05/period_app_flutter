import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_bottom.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class ContinueScreen extends StatelessWidget {
  const ContinueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        // Background image
        Image.asset(
          AppImages.continueBackgroundImage, // Replace with your image path
          fit: BoxFit.cover,
        ),

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0x7FB80257), Color(0x7FC4C4C4)],
            ),
          ),
        ),
        Positioned(
            bottom: MySize.size14,
            right: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MySize.size40),
              child: Column(
                children: [
                  CustomText(
                      text: "Welcome!",
                      textStyle: AppStyles.whitetext900
                          .copyWith(fontSize: MySize.size26)),
                  SizedBox(
                    height: MySize.size60,
                  ),
                  CustomText(
                      text:
                          "Please answer a few questons and we will personalise the app for you!",
                      textAlign: TextAlign.center,
                      textStyle: AppStyles.whitetext900
                          .copyWith(fontSize: MySize.size16)),
                  SizedBox(height: MySize.size60),
                  CustomButton(
                      ontap: () {
                        Get.toNamed("/EnterYourName");
                      },
                      text: "Continue",
                      buttonColor: AppColors.whiteColor,
                      width: double.infinity,
                      height: MySize.size52,
                      borderColor: AppColors.blackColor,
                      borderRadius: MySize.size15),
                  SizedBox(
                    height: MySize.size35,
                  ),
                  CustomText(
                      text:
                          'By tapping “continue” you agree to our terms of service and privacy policy',
                      textAlign: TextAlign.center,
                      textStyle: AppStyles.whitetext500
                          .copyWith(fontSize: MySize.size10)),
                ],
              ),
            ))
        // Scaffold content
      ]),
    );
  }
}
