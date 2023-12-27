import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:period_app/model/user_model.dart';
import 'package:period_app/provider/bottom_provider.dart';
import 'package:period_app/provider/user_name_controller.dart';
import 'package:period_app/view/auth/continue_screen.dart/continue_screen.dart';
import 'package:period_app/view/auth/continue_screen2/cycle_average_length.dart';
import 'package:period_app/view/auth/continue_screen2/select_last_period_date.dart';
import 'package:period_app/view/auth/continue_screen2/select_period_duration.dart';
import 'package:period_app/view/auth/login/login_screen.dart';
import 'package:period_app/view/auth/login_screen_main.dart';
import 'package:period_app/view/dashboard/dashboard_screen.dart';
import 'package:period_app/view/enter_name_screen.dart/enter_name_screen.dart';
import 'package:period_app/view/home/home_screen.dart';
import 'package:period_app/view/splash_screen/splash_screen.dart';
import 'package:period_app/view/splash_screen/splash_screen_logo.dart';
import 'package:period_app/view/user_screen/tap_to_change.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter<UserModel>(UserModelAdapter()); // Register the adapter for UserModel
  await Hive.openBox('userBox'); // ;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),
      ],
      child: GetMaterialApp(
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
            page: () => SplashScreenLogo(),
            transition:
                Transition.zoom, // Set a specific transition for this route
          ),
          GetPage(
            name: '/SplashScreen',
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
            name: '/EnterYourName',
            page: () => const EnterYourName(),
            transition: Transition
                .rightToLeft, // Set a different transition for this route
          ),
          GetPage(
            name: '/LoginScreenMain',
            page: () => const LoginScreenMain(),
            // transition:
            //     Transition.zoom, // Set a different transition for this route
          ),
          GetPage(
            name: '/TapToChange',
            page: () => const TapToChange(),
            // transition:
            //     Transition.zoom, // Set a different transition for this route
          ),
          GetPage(
            name: '/LoginScreen',
            page: () => const LoginScreen(),
            // Set a different transition for this route
          ),
          GetPage(
            name: '/SelectLastPeriodDate',
            page: () => SelectLastPeriodDate(),
            // Set a different transition for this route
          ),
          GetPage(
            name: '/ContinueScreen',
            page: () => const ContinueScreen(),
            // Set a different transition for this route
          ),
          GetPage(
            name: '/NumberPickerScreen',
            page: () => NumberPickerScreen(),
            // Set a different transition for this route
          ),
          GetPage(
            name: '/EndNumberPickerScreen',
            page: () => const EndNumberPickerScreen(),
            // Set a different transition for this route
          ),
          GetPage(
            name: '/BottomNavBar',
            page: () => BottomNavBar(),
            // Set a different transition for this route
          ),
        ],
        initialRoute: '/',
      ),
    );
  }
}
