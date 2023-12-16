import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/home/home_screen.dart';
import 'package:period_app/view/widgets/custom_bottom.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class LoginScreenMain extends StatelessWidget {
  const LoginScreenMain({Key? key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            AppImages.splashScreen, // Replace with your image URL
            fit: BoxFit.cover,
          ),
          // Blue color with opacity
          Container(color: AppColors.primaryColor.withOpacity(0.5)),

          // Centered content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MySize.size60),
                child: DefaultTextStyle(
                  style: AppStyles.whitetext900.copyWith(
                    fontSize: MySize.size80,
                    height: MySize.size0,
                  ),
                  child: CustomText(
                    text: "PEFLOW\nPERIOD\nTRACKER",
                    textAlign: TextAlign.center,
                    textStyle: AppStyles.whitetext900.copyWith(
                      fontSize: MySize.size40,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MySize.size20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MySize.size120),
                child: CustomText(
                  text: "Go With The Flow",
                  textAlign: TextAlign.center,
                  textStyle: AppStyles.whitetext900.copyWith(
                    fontSize: MySize.size16,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              bottom: MySize.size80,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MySize.size40),
                child: Column(
                  children: [
                    CustomButton(
                        ontap: () {
                          Get.toNamed("/ContinueScreen");
                        },
                        text: "Sign In",
                        buttonColor: AppColors.whiteColor,
                        width: double.infinity,
                        height: MySize.size52,
                        borderColor: AppColors.blackColor,
                        borderRadius: MySize.size15),
                    SizedBox(
                      height: MySize.size10,
                    ),
                    CustomButton(
                        text: "Sign Up",
                        buttonColor: AppColors.whiteColor,
                        width: double.infinity,
                        height: MySize.size52,
                        borderColor: AppColors.blackColor,
                        borderRadius: MySize.size15),
                  ],
                ),
              )),
          Positioned(
            bottom: MySize.size10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Already Have An Account?",
                  textAlign: TextAlign.center,
                  textStyle:
                      AppStyles.whitetext700.copyWith(fontSize: MySize.size16),
                ),
                SizedBox(
                  width: MySize.size2,
                ),
                TextButton(
                    onPressed: () {},
                    child: CustomText(
                        text: "Sign In",
                        textStyle: AppStyles.whitetext700
                            .copyWith(fontSize: MySize.size16)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
