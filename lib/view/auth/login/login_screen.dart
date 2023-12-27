import 'package:flutter/material.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/mysize.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          // width: 300,
          // height: 300,
          decoration: const BoxDecoration(
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
