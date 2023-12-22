import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_app/service/calculate_period_analytics.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_bottom.dart';
import 'package:period_app/view/widgets/custom_text.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectLastPeriodDate extends StatefulWidget {
  @override
  _SelectLastPeriodDateState createState() => _SelectLastPeriodDateState();
}

class _SelectLastPeriodDateState extends State<SelectLastPeriodDate> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List> _events = {};

  Future<void> _saveStartDateToHive(DateTime selectedDate) async {
    try {
         final startDateBox =  Hive.box('userBox');
      await startDateBox.put('lastPeriodStartDate', selectedDate);
    } catch (error) {
      print('Error saving start date to Hive: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        children: [
          SizedBox(
            height: MySize.size38,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: MySize.size20,
              horizontal: MySize.size20,
            ),
            child: CustomText(
              textAlign: TextAlign.center,
              text:
                  "Last Menstrual Period Start Date? The date when her last menstrual period began. This is used as a starting point to predict the next period.",
              textStyle: AppStyles.whitetext900.copyWith(
                fontSize: MySize.size16,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: TableCalendar(
                      calendarFormat: _calendarFormat,
                      focusedDay: _focusedDay,
                      firstDay: DateTime.utc(2023, 1, 1),
                      lastDay: DateTime.utc(2023, 12, 31),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          if (_events[selectedDay] == null) {
                            _events[selectedDay] = ['Selected'];
                          } else {
                            _events[selectedDay]?.add('Selected');
                          }
                        });

                        _saveStartDateToHive(selectedDay);
                      },
                      headerStyle: HeaderStyle(
                        headerMargin: EdgeInsets.only(
                          bottom: MySize.size40,
                        ),
                        formatButtonTextStyle: AppStyles.whitetext400.copyWith(
                          fontSize: MySize.size20,
                        ),
                        leftChevronIcon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: AppColors.whiteColor,
                        ),
                        rightChevronIcon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.whiteColor,
                        ),
                        titleCentered: true,
                        titleTextStyle: AppStyles.whitetext700.copyWith(
                          fontSize: MySize.size12,
                        ),
                        formatButtonVisible: false,
                      ),
                      calendarStyle: CalendarStyle(
                        // Set styles for the calendar
                        todayDecoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                        defaultTextStyle: AppStyles.whitetext400.copyWith(
                          fontSize: MySize.size12,
                          color: AppColors.whiteColor.withOpacity(0.6),
                        ),
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          color: Colors.white,
                        ),
                        weekendStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      availableCalendarFormats: {
                        CalendarFormat.month: 'Month',
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: MySize.size40,
              horizontal: MySize.size40,
            ),
            child: CustomButton(
              ontap: () {
                Get.toNamed("/SplashScreen");
                calculateDatesAndSaveToHive();
              },
              text: "Continue",
              buttonColor: AppColors.whiteColor,
              width: double.infinity,
              height: MySize.size52,
              borderColor: AppColors.blackColor,
              borderRadius: MySize.size15,
            ),
          ),
        ],
      ),
    );
  }
}
