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

class FertilityScreen extends StatefulWidget {
  const FertilityScreen({super.key});

  @override
  State<FertilityScreen> createState() => _FertilityScreenState();
}

class _FertilityScreenState extends State<FertilityScreen> {
  late bool fertilityStartValue = false;
  late bool ovulationValue = false;
  late bool fertilityEndValue = false;

  late DateTime fertilityStartDate = DateTime(2000);
  late DateTime fertilityEndDate = DateTime(2000);
  late DateTime ovulationDate = DateTime(2000);

  bool isFetching = false; //

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
      fertilityStartValue = await userBox.get('fertilityStartValue') ?? false;
      ovulationValue = await userBox.get('ovulationValue') ?? false;
      fertilityEndValue = await userBox.get('fertilityEndValue') ?? false;

      fertilityStartDate =
          await userBox.get('alarmFertileStartDate') ?? DateTime.now();
      fertilityEndDate =
          await userBox.get('alarmFertileEndDate') ?? DateTime.now();
      ovulationDate =
          await userBox.get('alarmOvulationStartDate') ?? DateTime.now();
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      setState(() {
        isFetching = true; // Update fetching status when done
      });
    }
  }

  void updatefertilityStartValue(bool newValue) async {
    try {
      final userBox = await Hive.openBox('userBox');
      await userBox.put('fertilityStartValue', newValue);
      setState(() {
        fertilityStartValue = newValue;
      });

      await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
      // DateTime currentTime = DateTime.now();

      // Schedule a notification 5 seconds from the current time
      DateTime scheduledTime = fertilityStartDate;

      // Call the scheduleNotification function from NotificationService
      String formattedDate = DateFormat('dd MMM yyyy').format(scheduledTime);
      String formattedTime = DateFormat('hh:mm a').format(scheduledTime);

      if (fertilityStartValue) {
        await NotificationService.scheduleNotification(
            scheduledTime,
            5,
            "Reminder Set",
            "Fertility Start For $formattedDate And Time $formattedTime",
            "NAVIGATE_HOME");

        // Optionally, show a message that the notification has been scheduled
        Get.snackbar(
          colorText: AppColors.whiteColor,
          backgroundColor: AppColors.secondaryColor,
          borderRadius: MySize.size5,
          "Reminder Set",
          "fertility Start For $formattedDate And Time $formattedTime",
        );
      } else {
        // Dismiss the notification with ID 1 if periodStartValue is false
        dismissNotification(5);
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

  void updatefertilityEndValue(bool newValue) async {
    try {
      final userBox = await Hive.openBox('userBox');
      await userBox.put('fertilityEndValue', newValue);
      setState(() {
        fertilityEndValue = newValue;
      });

      await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
      // DateTime currentTime = DateTime.now();

      // Schedule a notification 5 seconds from the current time
      DateTime scheduledTime = fertilityEndDate;

      // Call the scheduleNotification function from NotificationService
      String formattedDate = DateFormat('dd MMM yyyy').format(scheduledTime);
      String formattedTime = DateFormat('hh:mm a').format(scheduledTime);

      if (fertilityEndValue) {
        await NotificationService.scheduleNotification(
            scheduledTime,
            6,
            "Reminder Set",
            "Fertility End For $formattedDate And Time $formattedTime",
            "NAVIGATE_HOME");

        // Optionally, show a message that the notification has been scheduled
        Get.snackbar(
          colorText: AppColors.whiteColor,
          backgroundColor: AppColors.secondaryColor,
          borderRadius: MySize.size5,
          "Reminder Set",
          "Fertility End For Schedule $formattedDate And Time $formattedTime",
        );
      } else {
        // Dismiss the notification with ID 1 if periodStartValue is false
        dismissNotification(6);
        Get.snackbar(
          colorText: AppColors.whiteColor,
          backgroundColor: AppColors.secondaryColor,
          borderRadius: MySize.size5,
          "Dismmiss Reminder Set",
          "Fertility End For $formattedDate And Time $formattedTime",
        ); // Replace with your implementation for dismissing the notification
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error updating data: $error');
      }
    }
  }

  void updateOvulationValue(bool newValue) async {
    try {
      final userBox = await Hive.openBox('userBox');
      await userBox.put('ovulationValue', newValue);
      setState(() {
        ovulationValue = newValue;
      });

      await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
      // DateTime currentTime = DateTime.now();

      // Schedule a notification 5 seconds from the current time
      DateTime scheduledTime = ovulationDate;

      // Call the scheduleNotification function from NotificationService
      String formattedDate = DateFormat('dd MMM yyyy').format(scheduledTime);
      String formattedTime = DateFormat('hh:mm a').format(scheduledTime);

      if (ovulationValue) {
        await NotificationService.scheduleNotification(
            scheduledTime,
            7,
            "Reminder Set",
            "Ovulation Starts For $formattedDate And Time $formattedTime",
            "NAVIGATE_HOME");

        // Optionally, show a message that the notification has been scheduled
        Get.snackbar(
          colorText: AppColors.whiteColor,
          backgroundColor: AppColors.secondaryColor,
          borderRadius: MySize.size5,
          "Reminder Set",
          "Ovulation Starts For Schedule $formattedDate And Time $formattedTime",
        );
      } else {
        // Dismiss the notification with ID 1 if periodStartValue is false
        dismissNotification(7);
        Get.snackbar(
          colorText: AppColors.whiteColor,
          backgroundColor: AppColors.secondaryColor,
          borderRadius: MySize.size5,
          "Dismmiss Reminder Set",
          "Ovulation Starts For $formattedDate And Time $formattedTime",
        ); // Replace with your implementation for dismissing the notification
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error updating data: $error');
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
          arrowBacktext: "Fertility",
          title: "Fertility Days",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
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
                        title: "fertility Starts",
                        widget: SizedBox(
                          height: MySize.size35,
                          width: MySize.size110,
                          child: LiteRollingSwitch(
                              width: MySize.size120,
                              onSwipe: () {},
                              onDoubleTap: () {},
                              onTap: () {},
                              //initial value
                              value: fertilityStartValue,
                              textOn: 'Fertility ON',
                              textOnColor: AppColors.whiteColor,
                              textOff: 'OFF',
                              colorOn: AppColors.primaryColor,
                              colorOff: AppColors.secondaryColor,
                              iconOn: Icons.done,
                              iconOff: Icons.remove_circle_outline,
                              textSize: MySize.size12,
                              onChanged: (bool ovulation) {
                                updatefertilityStartValue(ovulation);
                                //Use it to manage the different states
                                print('Current State of oWITCH IS: $ovulation');
                              }),
                        ),
                      ),
                      PeriodStartWidget(
                          title: "Remind Me",
                          widget: Container(
                            padding: EdgeInsets.all(MySize.size25),
                            decoration:
                                BoxDecoration(color: AppColors.secondaryColor),
                            child: CustomText(
                                text: DateFormat('dd MMM yyyy')
                                    .format(fertilityStartDate),
                                textStyle: AppStyles.whitetext900
                                    .copyWith(fontSize: MySize.size18)),
                          )),
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
                                text: DateFormat('hh:mm a')
                                    .format(fertilityStartDate),
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
                PeriodStartWidget(
                  mySize: MySize.size20,
                  title: "Ovulation Day",
                  widget: SizedBox(
                    height: MySize.size35,
                    width: MySize.size120,
                    child: LiteRollingSwitch(
                        width: MySize.scaleFactorWidth * 130,
                        onSwipe: () {},
                        onDoubleTap: () {},
                        onTap: () {},
                        //initial value
                        value: ovulationValue,
                        textOn: 'Ovulation ON',
                        textOnColor: AppColors.whiteColor,
                        textOff: 'OFF',
                        colorOn: AppColors.primaryColor,
                        colorOff: AppColors.secondaryColor,
                        iconOn: Icons.done,
                        iconOff: Icons.remove_circle_outline,
                        textSize: MySize.size12,
                        onChanged: (bool ovulation) {
                          updateOvulationValue(ovulation);
                          //Use it to manage the different states
                          print('Current State of oWITCH IS: $ovulation');
                        }),
                  ),
                ),
                PeriodStartWidget(
                    title: "Remind Me",
                    widget: Container(
                      padding: EdgeInsets.all(MySize.size25),
                      decoration:
                          BoxDecoration(color: AppColors.secondaryColor),
                      child: CustomText(
                          text: DateFormat('dd MMM yyyy').format(ovulationDate),
                          textStyle: AppStyles.whitetext900
                              .copyWith(fontSize: MySize.size18)),
                    )),
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
                          text: DateFormat('hh:mm a').format(ovulationDate),
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
                PeriodStartWidget(
                  mySize: MySize.size20,
                  title: "Fertility Ends",
                  widget: SizedBox(
                    height: MySize.size35,
                    width: MySize.scaleFactorWidth * 118,
                    child: LiteRollingSwitch(
                        width: MySize.scaleFactorWidth * 130,
                        onSwipe: () {},
                        onDoubleTap: () {},
                        onTap: () {},
                        //initial value
                        value: fertilityEndValue,
                        textOn: 'Fertility End',
                        textOnColor: AppColors.whiteColor,
                        textOff: 'OFF',
                        colorOn: AppColors.primaryColor,
                        colorOff: AppColors.secondaryColor,
                        iconOn: Icons.done,
                        iconOff: Icons.remove_circle_outline,
                        textSize: MySize.size12,
                        onChanged: (bool ovulation) {
                          updatefertilityEndValue(ovulation);
                          //Use it to manage the different states
                          print('Current State of oWITCH IS: $ovulation');
                        }),
                  ),
                ),
                PeriodStartWidget(
                    title: "Remind Me",
                    widget: Container(
                      padding: EdgeInsets.all(MySize.size25),
                      decoration:
                          BoxDecoration(color: AppColors.secondaryColor),
                      child: CustomText(
                          text: DateFormat('dd MMM yyyy')
                              .format(fertilityEndDate),
                          textStyle: AppStyles.whitetext900
                              .copyWith(fontSize: MySize.size18)),
                    )),
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
                          text: DateFormat('hh:mm a').format(fertilityEndDate),
                          textStyle: AppStyles.whitetext900
                              .copyWith(fontSize: MySize.size30)),
                    )),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
