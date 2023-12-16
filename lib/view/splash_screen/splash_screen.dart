import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/home/home_screen.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      // Navigate to the next screen after 3 seconds
      Get.toNamed('/LoginScreenMain');
    });
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
          Container(color: AppColors.primaryColor),
          // Centered white text
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MySize.size60),
                child: DefaultTextStyle(
                  style: AppStyles.whitetext900.copyWith(
                    fontSize: MySize.size60,
                    height: 0,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedTextKit(
                          repeatForever: true,
                          pause: Duration(milliseconds: 100),
                          animatedTexts: [
                            ScaleAnimatedText('PERIOD APP',
                                textAlign: TextAlign.center),
                            ScaleAnimatedText("Let's Start",
                                textAlign: TextAlign.center),
                            // ScaleAnimatedText(''),
                            // ScaleAnimatedText('Build'),
                            // ScaleAnimatedText('Ship'),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MySize.size20,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: MySize.size120),
              //   child: CustomText(
              //       text: "Go With The Flow",
              //       textAlign: TextAlign.center,
              //       textStyle: AppStyles.whitetext900.copyWith(
              //         fontSize: MySize.size16,
              //       )),
              // )
            ],
          )),
        ],
      ),
    );
  }
}
