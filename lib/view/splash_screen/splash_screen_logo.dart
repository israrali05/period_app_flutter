import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/view/auth/continue_screen.dart/continue_screen.dart';
import 'package:period_app/view/dashboard/dashboard_screen.dart';
import 'package:period_app/view/enter_name_screen.dart/enter_name_screen.dart';
import 'package:period_app/view/splash_screen/splash_screen.dart';

class SplashScreenLogo extends StatefulWidget {
  @override
  _SplashScreenLogoState createState() => _SplashScreenLogoState();
}

class _SplashScreenLogoState extends State<SplashScreenLogo> {
  @override
  void initState() {
    super.initState();
    navigateToScreen();
  }

  void navigateToScreen() async {
    Map<String, dynamic> userData = await fetchDataFromHive();

    // Check if name and email exist in userData
    if (userData['name'] != null &&
        userData['name'].isNotEmpty &&
        userData['email'] != null &&
        userData['email'].isNotEmpty &&
        userData['lastPeriodStartDate'] != null &&
        userData['Period'] != null &&
        userData['Period'].isNotEmpty) {
      // Navigate to HomeScreen if name and email exist
      Timer(Duration(seconds: 3), () {
        Get.offAll(BottomNavBar());
      });
    } else {
      // Navigate to EnterNameScreen if name and email don't exist
   Timer(Duration(seconds: 3), () {
        Get.offAll(ContinueScreen());
      });
    }
  }

  Future<Map<String, dynamic>> fetchDataFromHive() async {
    try {
      final userBox = Hive.box('userBox');
      return {
        'name': userBox.get('name') ?? '',
        'email': userBox.get('email') ?? '',
        'Period': userBox.get('Period') ?? '',
        'lastPeriodStartDate': userBox.get('lastPeriodStartDate') ?? '',
      };
    } catch (error) {
      print('Error fetching data from Hive: $error');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    // Return a Scaffold with a simple UI for the splash screen
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Center(
        child: Image.asset(AppImages.insightMood),
      ),
    );
  }
}
