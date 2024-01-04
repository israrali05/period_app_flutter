import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static Future<void> initialize() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          importance: NotificationImportance.Max,
          enableVibration: true,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
          channelDescription: 'Notification channel for basic notifications',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.amber,
        ),
      ],
    );

    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Handle when a new notification or schedule is created
    print('Notification created: ${receivedNotification.id}');
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Handle when a notification is displayed
    print('Notification displayed: ${receivedNotification.id}');
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Handle when a notification is dismissed
    print('Notification dismissed: ${receivedAction.id}');
  }

  static Future<void> scheduleNotification(DateTime scheduledTime, int id,
      String title, String body, String pageroute) async {
    // Convert the scheduled time to UTC
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
      actionButtons: [
        NotificationActionButton(
          key: pageroute,
          label: 'Click Here',
        ),
      ],
      schedule: NotificationCalendar.fromDate(
        date: scheduledTime,
      ),
    );
  }

  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    if (receivedAction.buttonKeyPressed == "NAVIGATE_HOME") {
      print('Navigate Action Button Clicked');
      // Get.to(() => SecondScreen());
      // Perform actions for navigation or other functionality here
    } else {
      print("no match");
    }
  }
}
