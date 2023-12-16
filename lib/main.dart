import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_app/view/auth/continue_screen.dart/continue_screen.dart';
import 'package:period_app/view/auth/continue_screen2/Start_date_avarage.dart';
import 'package:period_app/view/auth/continue_screen2/end_date_average.dart';
import 'package:period_app/view/auth/login/login_screen.dart';
import 'package:period_app/view/auth/login_screen_main.dart';
import 'package:period_app/view/dashboard/dashboard_screen.dart';
import 'package:period_app/view/home/home_screen.dart';
import 'package:period_app/view/splash_screen/splash_screen.dart';
import 'package:period_app/view/user_screen/tap_to_change.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Period App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      defaultTransition:
          Transition.fade, // Set default transition animation for all routes
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
          transition:
              Transition.zoom, // Set a specific transition for this route
        ),
        GetPage(
          name: '/homeScreen',
          page: () => HomeScreen(),
          transition: Transition
              .rightToLeft, // Set a different transition for this route
        ),
        GetPage(
          name: '/LoginScreenMain',
          page: () => LoginScreenMain(),
          // transition:
          //     Transition.zoom, // Set a different transition for this route
        ),
        GetPage(
          name: '/TapToChange',
          page: () => TapToChange(),
          // transition:
          //     Transition.zoom, // Set a different transition for this route
        ),
        GetPage(
          name: '/LoginScreen',
          page: () => LoginScreen(),
          // Set a different transition for this route
        ),
        GetPage(
          name: '/ContinueScreen',
          page: () => ContinueScreen(),
          // Set a different transition for this route
        ),
        GetPage(
          name: '/NumberPickerScreen',
          page: () => NumberPickerScreen(),
          // Set a different transition for this route
        ),
        GetPage(
          name: '/EndNumberPickerScreen',
          page: () => EndNumberPickerScreen(),
          // Set a different transition for this route
        ),
        GetPage(
          name: '/BottomNavBar',
          page: () => BottomNavBar(),
          // Set a different transition for this route
        ),
      ],
      initialRoute: '/',
    );
  }
}
