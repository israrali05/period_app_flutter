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

class PmsScreen extends StatefulWidget {
  const PmsScreen({super.key});

  @override
  State<PmsScreen> createState() => _PmsScreenState();
}

class _PmsScreenState extends State<PmsScreen> {
  late bool pmsStartValue = false;

  late DateTime pmsStartDate = DateTime(2000);

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
      pmsStartValue = await userBox.get('pmsStartValue') ?? false;

      pmsStartDate = await userBox.get('alarmPmsStartDate') ?? DateTime.now();
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
      await userBox.put('pmsStartValue', newValue);
      setState(() {
        pmsStartValue = newValue;
      });

      await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
      // DateTime currentTime = DateTime.now();

      // Schedule a notification 5 seconds from the current time
      DateTime scheduledTime = pmsStartDate;

      // Call the scheduleNotification function from NotificationService
      String formattedDate = DateFormat('dd MMM yyyy').format(scheduledTime);
      String formattedTime = DateFormat('hh:mm a').format(scheduledTime);

      if (pmsStartValue) {
        await NotificationService.scheduleNotification(
            scheduledTime,
            3,
            "Reminder You",
            "PMS Start For $formattedDate And Time $formattedTime",
            "NAVIGATE_HOME");

        // Optionally, show a message that the notification has been scheduled
        Get.snackbar(
          colorText: AppColors.whiteColor,
          backgroundColor: AppColors.secondaryColor,
          borderRadius: MySize.size5,
          "Reminder Set",
          "PMS For $formattedDate And Time $formattedTime",
        );
      } else {
        // Dismiss the notification with ID 1 if periodStartValue is false
        dismissNotification(3);
        Get.snackbar(
          colorText: AppColors.whiteColor,
          backgroundColor: AppColors.secondaryColor,
          borderRadius: MySize.size5,
          "Dismmiss Reminder Set",
          "PMS Start For $formattedDate And Time $formattedTime",
        ); // Replace with your implementation for dismissing the notification
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error updating data: $error');
      }
    }
  }

  Future<void> _selectDateTimeStart(BuildContext context) async {
    DateTime selectedDate = pmsStartDate;
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(selectedDate);

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
          pmsStartDate = selectedDate;
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
          arrowBacktext: "PMS",
          title: "PMS",
        ),
      ),
      body: Column(children: [
        !isFetching
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              )
            : Container(
                padding: EdgeInsets.all(MySize.size30),
                color: AppColors.whiteColor.withOpacity(0.4),
                child: Column(
                  children: [
                    PeriodStartWidget(
                      mySize: MySize.size20,
                      title: "PMS Starts",
                      widget: SizedBox(
                        height: MySize.size35,
                        width: MySize.size110,
                        child: LiteRollingSwitch(
                            width: MySize.size120,
                            onSwipe: () {},
                            onDoubleTap: () {},
                            onTap: () {},
                            //initial value
                            value: pmsStartValue,
                            textOn: 'PMS Starts',
                            textOnColor: AppColors.whiteColor,
                            textOff: 'OFF',
                            colorOn: AppColors.primaryColor,
                            colorOff: AppColors.secondaryColor,
                            iconOn: Icons.done,
                            iconOff: Icons.remove_circle_outline,
                            textSize: MySize.size12,
                            onChanged: (bool ovulation) {
                              //Use it to manage the different states
                              updatePeriodStartValue(ovulation);
                              print('Current State of oWITCH IS: $ovulation');
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
                                text: DateFormat('dd MMM yyyy')
                                    .format(pmsStartDate),
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
                          decoration:
                              BoxDecoration(color: AppColors.secondaryColor),
                          child: CustomText(
                              text: DateFormat('hh:mm a').format(pmsStartDate),
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
