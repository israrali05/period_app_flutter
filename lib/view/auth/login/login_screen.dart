import 'package:flutter/material.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          // width: 300,
          // height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages
                  .loginScreenBackgroundImage), // Replace with your image path
              fit: BoxFit
                  .cover, // Adjust the BoxFit according to your requirement
            ),
          ),
        ),
      ),
    );
  }
}
