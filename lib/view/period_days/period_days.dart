import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:period_app/service/notification_service.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/period_days/period_start_widget.dart';
import 'package:period_app/view/widgets/custom_appbar.dart';
import 'package:period_app/view/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class PeriodDayScreen extends StatefulWidget {
  const PeriodDayScreen({super.key});

  @override
  State<PeriodDayScreen> createState() => _PeriodDayScreenState();
}

class _PeriodDayScreenState extends State<PeriodDayScreen> {
  late bool periodStartValue = false;
  late bool periodEndValue = false;

  late DateTime periodStartDate = DateTime(2000);
  late DateTime periodEndDate = DateTime(2000);

  bool isFetching = false; // Track whether fetching is in progress

  @override
  void initState() {
    super.initState();
    fetchPeriodStartValueFromHive();
  }

  void dismissNotification(int notificationId) async {
    await AwesomeNotifications().cancel(notificationId);
    print("dismiss");
  }

  Future<void> fetchPeriodStartValueFromHive() async {
    try {
      final userBox = await Hive.openBox('userBox');
      periodStartValue = await userBox.get('periodStartValue') ?? false;
      periodEndValue = await userBox.get('periodEndValue') ?? false;

      periodStartDate =
          await userBox.get('alarmNextPeriodStartDate') ?? DateTime.now();
      periodEndDate =
          await userBox.get('alarmNextPeriodEndDate') ?? DateTime.now();
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      setState(() {
        isFetching = true; // Update fetching status when done
      });
    }
  }

  void updatePeriodStartValue(bool newValue) async {
    try {
      final userBox = await Hive.openBox('userBox');
      await userBox.put('periodStartValue', newValue);
      setState(() {
        periodStartValue = newValue;
      });

      await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
      // DateTime currentTime = DateTime.now();

      // Schedule a notification 5 seconds from the current time
      DateTime scheduledTime = periodStartDate;

      // Call the scheduleNotification function from NotificationService
      String formattedDate = DateFormat('dd MMM yyyy').format(scheduledTime);
      String formattedTime = DateFormat('hh:mm a').format(scheduledTime);

      if (periodStartValue) {
        await NotificationService.scheduleNotification(
            scheduledTime,
            1,
            "Reminder Set",
            "Period Start For $formattedDate And Time $formattedTime",
            "NAVIGATE_HOME");

        // Optionally, show a message that the notification has been scheduled
        Get.snackbar(
          colorText: AppColors.whiteColor,
          backgroundColor: AppColors.secondaryColor,
          borderRadius: MySize.size5,
          "Reminder Set",
          "Period Start For $formattedDate And Time $formattedTime",
        );
      } else {
        // Dismiss the notification with ID 1 if periodStartValue is false
        dismissNotification(1);
        Get.snackbar(
          colorText: AppColors.whiteColor,
          backgroundColor: AppColors.secondaryColor,
          borderRadius: MySize.size5,
          "Dismmiss Reminder Set",
          "Period Start For $formattedDate And Time $formattedTime",
        ); // Replace with your implementation for dismissing the notification
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error updating data: $error');
      }
    }
  }

  void updatePeriodEndValue(bool newValue) async {
    try {
      final userBox = await Hive.openBox('userBox');
      await userBox.put('periodEndValue', newValue);
      setState(() {
        periodEndValue = newValue;
      });

      await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
      // DateTime currentTime = DateTime.now();

      // Schedule a notification 5 seconds from the current time
      DateTime scheduledTime = periodEndDate;

      // Call the scheduleNotification function from NotificationService
      String formattedDate = DateFormat('dd MMM yyyy').format(scheduledTime);
      String formattedTime = DateFormat('hh:mm a').format(scheduledTime);

      if (periodStartValue) {
        await NotificationService.scheduleNotification(
            scheduledTime,
            2,
            "Reminder Set",
            "Period End For $formattedDate And Time $formattedTime",
            "NAVIGATE_HOME");

        // Optionally, show a message that the notification has been scheduled
        Get.snackbar(
          colorText: AppColors.whiteColor,
          backgroundColor: AppColors.secondaryColor,
          borderRadius: MySize.size5,
          "Reminder Set",
          "Period End For Schedule $formattedDate And Time $formattedTime",
        );
      } else {
        // Dismiss the notification with ID 1 if periodStartValue is false
        dismissNotification(2);
        Get.snackbar(
          colorText: AppColors.whiteColor,
          backgroundColor: AppColors.secondaryColor,
          borderRadius: MySize.size5,
          "Dismmiss Reminder Set",
          "Period End For $formattedDate And Time $formattedTime",
        ); // Replace with your implementation for dismissing the notification
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error updating data: $error');
      }
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Colors.red),
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: Colors.white,
              selectionHandleColor: Colors.white,
              cursorColor: Colors.white,
            ),
          ),
          child: child ?? Container(),
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
              textSelectionTheme: TextSelectionThemeData(
                selectionColor: AppColors.whiteColor,
                selectionHandleColor: AppColors.whiteColor,
                cursorColor: AppColors.whiteColor,
              ),
            ),
            child: child ?? Container(),
          );
        },
      );

      if (pickedTime != null) {
        selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Do something with the selected date and time
        print('Selected date and time: $selectedDate');
        setState(() {
          periodEndDate = selectedDate;
        });
      }
    }
  }

  Future<void> _selectDateTimeStart(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Colors.red),
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: Colors.white,
              selectionHandleColor: Colors.white,
              cursorColor: Colors.white,
            ),
          ),
          child: child ?? Container(),
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
              textSelectionTheme: TextSelectionThemeData(
                selectionColor: AppColors.whiteColor,
                selectionHandleColor: AppColors.whiteColor,
                cursorColor: AppColors.whiteColor,
              ),
            ),
            child: child ?? Container(),
          );
        },
      );

      if (pickedTime != null) {
        selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Do something with the selected date and time
        print('Selected date and time: $selectedDate');
        setState(() {
          periodStartDate = selectedDate;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        toolbarHeight: MySize.size60,
        surfaceTintColor: AppColors.primaryColor.withOpacity(0.2),
        backgroundColor: AppColors.primaryColor.withOpacity(0.2),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          arrowBacktext: "Reminders",
          title: "Period Ends",
        ),
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(MySize.size30),
          color: AppColors.whiteColor.withOpacity(0.4),
          child: Column(
            children: [
              !isFetching
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : PeriodStartWidget(
                      mySize: MySize.size20,
                      title: "Period Starts",
                      widget: SizedBox(
                        height: MySize.size35,
                        width: MySize.size110,
                        child: LiteRollingSwitch(
                            width: MySize.size120,
                            onSwipe: () {},
                            onDoubleTap: () {},
                            onTap: () {},
                            //initial value
                            value: periodStartValue,
                            textOn: 'Period ON',
                            textOnColor: AppColors.whiteColor,
                            textOff: 'OFF',
                            colorOn: AppColors.primaryColor,
                            colorOff: AppColors.secondaryColor,
                            iconOn: Icons.done,
                            iconOff: Icons.remove_circle_outline,
                            textSize: MySize.size12,
                            onChanged: (bool newValue) {
                              updatePeriodStartValue(newValue);

                              //Use it to manage the different states
                              // Provider.of<NotificationService>(context, listen: false)
                              //     .scheduleNotification(
                              //   notificationId: 0, // Replace with your desired ID
                              //   title: 'Scheduled Notification',
                              //   body: 'This is a scheduled notification!',
                              //   scheduledTime:
                              //       DateTime.now().add(Duration(seconds: 5)),
                              // );
                              print('Current State of oWITCH IS: $newValue');
                            }),
                      ),
                    ),
              InkWell(
                onTap: () {
                  _selectDateTimeStart(context);
                },
                child: PeriodStartWidget(
                    title: "Remind Me",
                    widget: Container(
                      padding: EdgeInsets.all(MySize.size25),
                      decoration:
                          BoxDecoration(color: AppColors.secondaryColor),
                      child: CustomText(
                          text:
                              DateFormat('dd MMM yyyy').format(periodStartDate),
                          textStyle: AppStyles.whitetext900
                              .copyWith(fontSize: MySize.size18)),
                    )),
              ),
              PeriodStartWidget(
                  title: "Time",
                  widget: Container(
                    padding: EdgeInsets.only(
                        top: MySize.size20,
                        right: MySize.size10,
                        left: MySize.size10),
                    decoration: BoxDecoration(color: AppColors.secondaryColor),
                    child: CustomText(
                        text: DateFormat('hh:mm a').format(periodStartDate),
                        textStyle: AppStyles.whitetext900
                            .copyWith(fontSize: MySize.size30)),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: MySize.size60,
        ),
        Container(
          padding: EdgeInsets.all(MySize.size30),
          color: AppColors.whiteColor.withOpacity(0.4),
          child: Column(
            children: [
              !isFetching
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : PeriodStartWidget(
                      mySize: MySize.size20,
                      title: "Period Ends",
                      widget: SizedBox(
                        height: MySize.size35,
                        width: MySize.size110,
                        child: LiteRollingSwitch(
                            width: MySize.size120,
                            onSwipe: () {},
                            onDoubleTap: () {},
                            onTap: () {},
                            //initial value
                            value: periodEndValue,
                            textOn: 'Period ON',
                            textOnColor: AppColors.whiteColor,
                            textOff: 'OFF',
                            colorOn: AppColors.primaryColor,
                            colorOff: AppColors.secondaryColor,
                            iconOn: Icons.done,
                            iconOff: Icons.remove_circle_outline,
                            textSize: MySize.size12,
                            onChanged: (bool newValue) {
                              updatePeriodEndValue(newValue);

                              //Use it to manage the different states
                              // Provider.of<NotificationService>(context, listen: false)
                              //     .scheduleNotification(
                              //   notificationId: 0, // Replace with your desired ID
                              //   title: 'Scheduled Notification',
                              //   body: 'This is a scheduled notification!',
                              //   scheduledTime:
                              //       DateTime.now().add(Duration(seconds: 5)),
                              // );
                              print('Current State of oWITCH IS: $newValue');
                            }),
                      ),
                    ),
              InkWell(
                onTap: () {
                  _selectDateTime(context);
                },
                child: PeriodStartWidget(
                    title: "Remind Me",
                    widget: Container(
                      padding: EdgeInsets.all(MySize.size25),
                      decoration:
                          BoxDecoration(color: AppColors.secondaryColor),
                      child: CustomText(
                          text: DateFormat('dd MMM yyyy').format(periodEndDate),
                          textStyle: AppStyles.whitetext900
                              .copyWith(fontSize: MySize.size18)),
                    )),
              ),
              PeriodStartWidget(
                  title: "Time",
                  widget: Container(
                    padding: EdgeInsets.only(
                        top: MySize.size20,
                        right: MySize.size10,
                        left: MySize.size10),
                    decoration: BoxDecoration(color: AppColors.secondaryColor),
                    child: CustomText(
                        text: DateFormat('hh:mm a').format(periodEndDate),
                        textStyle: AppStyles.whitetext900
                            .copyWith(fontSize: MySize.size30)),
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
