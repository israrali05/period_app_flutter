import 'package:flutter/material.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/calendar_screen/calendar_screen.dart';
import 'package:period_app/view/home/home_screen.dart';
import 'package:period_app/view/insight_screen/insight_screen.dart';
import 'package:period_app/view/user_screen/user_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    CalendarScreen(),
    InsightScreen(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        // padding: EdgeInsets.symmetric(vertical: MySize.size20),
        decoration: BoxDecoration(
          color: Color(0xfff487b7),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent, // Remove bottom elevation
              spreadRadius: 0,
              blurRadius: 0,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Color(0xfff487b7),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.white,
          selectedLabelStyle:
              AppStyles.whitetext900.copyWith(fontSize: MySize.size15),
          unselectedLabelStyle:
              AppStyles.whitetext900.copyWith(fontSize: MySize.size15),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                AppImages.bottomCurrentIndexcycle,
                height: MySize.size30,
              ),
              icon: Image.asset(
                AppImages.bottomcycle,
                height: MySize.size30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                AppImages.bottomCalendar,
                color: AppColors.primaryColor,
                height: MySize.size30,
              ),
              icon: Image.asset(
                AppImages.bottomCalendar,
                height: MySize.size30,
              ),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                AppImages.bottomInsights,
                color: AppColors.primaryColor,
                height: MySize.size30,
              ),
              icon: Image.asset(
                AppImages.bottomInsights,
                height: MySize.size30,
              ),
              label: 'Insight',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                AppImages.bottomUser,
                color: AppColors.primaryColor,
                height: MySize.size30,
              ),
              icon: Image.asset(
                AppImages.bottomUser,
                height: MySize.size30,
              ),
              label: 'Me',
            ),
          ],
        ),
      ),
    );
  }
}
