import 'package:flutter/material.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List> _events = {};

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          surfaceTintColor: AppColors.primaryColor,
          title: Text("Calendar"),
          centerTitle: true,
          titleTextStyle:
              AppStyles.whitetext900.copyWith(fontSize: MySize.size18),
        ),
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
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
                      // Check if the day is selected
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        // Perform actions on day selection (e.g., add to a list of selected dates)
                        if (_events[selectedDay] == null) {
                          _events[selectedDay] = ['Selected'];
                        } else {
                          _events[selectedDay]?.add('Selected');
                        }
                      });
                    },
                    headerStyle: HeaderStyle(
                      headerMargin: EdgeInsets.only(bottom: MySize.size40),
                      formatButtonTextStyle: AppStyles.whitetext400
                          .copyWith(fontSize: MySize.size20),
                      leftChevronIcon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.whiteColor,
                      ),
                      rightChevronIcon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.whiteColor,
                      ),
                      titleCentered: true,
                      titleTextStyle: AppStyles.whitetext700
                          .copyWith(fontSize: MySize.size12),
                      formatButtonVisible: false,
                    ),
                    calendarStyle: CalendarStyle(
                      rangeStartTextStyle: AppStyles.whitetext400.copyWith(
                          fontSize: MySize.size12,
                          color: AppColors.whiteColor.withOpacity(0.5)),
                      holidayTextStyle: AppStyles.whitetext400
                          .copyWith(fontSize: MySize.size12),
                      disabledTextStyle: AppStyles.whitetext400
                          .copyWith(fontSize: MySize.size12),
                      outsideTextStyle: AppStyles.whitetext400
                          .copyWith(fontSize: MySize.size12),
                      weekNumberTextStyle: AppStyles.whitetext400
                          .copyWith(fontSize: MySize.size12),
                      rangeEndTextStyle: AppStyles.whitetext400
                          .copyWith(fontSize: MySize.size12),
                      weekendTextStyle: AppStyles.whitetext400
                          .copyWith(fontSize: MySize.size12),
                      todayTextStyle: AppStyles.whitetext400
                          .copyWith(fontSize: MySize.size12),
                      withinRangeTextStyle: AppStyles.whitetext400
                          .copyWith(fontSize: MySize.size12),

                      todayDecoration: BoxDecoration(
                        color: AppColors
                            .secondaryColor, // Set the selected date color
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.white, // Set the selected date color
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                      // Set selected date text color
                      defaultTextStyle: AppStyles.whitetext400.copyWith(
                          fontSize: MySize.size12,
                          color: AppColors.whiteColor
                              .withOpacity(0.6)), // Set default date text color
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                          color: Colors
                              .white), // Change the color of weekday names here
                      weekendStyle: TextStyle(
                          color: Colors
                              .white), // Modify weekend text style if needed
                    ),
                    availableCalendarFormats: {
                      CalendarFormat.month: 'Month',
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
