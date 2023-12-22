import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:period_app/model/user_model.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Set a timer to navigate to the next screen after 4 seconds (4000 milliseconds)
    Timer(Duration(seconds: 4), () {
      // Navigate to the next screen using Navigator
      Get.toNamed("/BottomNavBar");
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _fetchNameFromHive(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return _buildSplashScreen(snapshot.data ?? 'Guest');
        }
      },
    );
  }

Future<String> _fetchNameFromHive() async {
  String userName = 'Guest'; // Default value if no name is stored

  try {
    final userBox = Hive.box('userBox');
    final storedName = userBox.get('name');

    if (storedName != null && storedName is String) {
      userName = storedName;
    }
  } catch (error) {
    print('Error fetching data: $error');
  }

  return userName;
}

  Widget _buildSplashScreen(String userName) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.splashScreen,
            fit: BoxFit.cover,
          ),
          Container(color: AppColors.secondaryColor),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MySize.size60),
                  child: DefaultTextStyle(
                    style: AppStyles.whitetext500.copyWith(
                      fontSize: MySize.size50,
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
                              ScaleAnimatedText('Hi $userName!',
                                  textAlign: TextAlign.center),
                              ScaleAnimatedText("Let's Start App",
                                  textAlign: TextAlign.center),
                              ScaleAnimatedText("Wait A Moment....",
                                  textAlign: TextAlign.center),
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
                SizedBox(height: MySize.size20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
