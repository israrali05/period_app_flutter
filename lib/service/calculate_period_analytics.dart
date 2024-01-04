import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

Future<void> calculateDatesAndSaveToHive() async {
  try {
    final userBox = Hive.box('userBox');
    DateTime? lastPeriodStartDate = userBox.get('lastPeriodStartDate');
    int? menstrualCycleLength = userBox.get('averageCycle');
    int? periodCycle = userBox.get('periodCycle');

    if (lastPeriodStartDate != null &&
        periodCycle != null &&
        menstrualCycleLength != null) {
      DateTime nextPeriodStartDate =
          lastPeriodStartDate.add(Duration(days: menstrualCycleLength));
      DateTime nextPeriodlastDate =
          nextPeriodStartDate.add(Duration(days: periodCycle));

      // ovulation day
      DateTime currentDate = DateTime.now();

      DateTime ovulationStart =
          lastPeriodStartDate.add(Duration(days: menstrualCycleLength ~/ 2));
      DateTime ovulationEnd = ovulationStart.add(const Duration(days: 5));

      // Assuming menstrualCycleLength is the length of the entire cycle in days

      DateTime ovulationDay = ovulationStart;

      Duration daysUntilOvulation = ovulationDay.difference(currentDate);
      int daysLeft = daysUntilOvulation.inDays;

      // Format daysLeft as a string with two digits
      String formattedOvulationDay = daysLeft.toString();

      // end ovulation day

      // calculate fertile start and end date
      DateTime fertileStart = ovulationStart.subtract(const Duration(days: 5));
      DateTime fertileEnd = ovulationEnd.add(const Duration(days: 4));
      // pms start date
      DateTime pmsStartDate =
          nextPeriodStartDate.subtract(const Duration(days: 7));

// alaram Calculate
      await userBox.put('alarmNextPeriodStartDate', nextPeriodlastDate);
      await userBox.put('alarmNextPeriodEndDate', nextPeriodlastDate);
      await userBox.put('alarmOvulationStartDate', ovulationStart);
      await userBox.put('alarmOvulationEndDate', ovulationEnd);
      await userBox.put('alarmFertileStartDate', fertileStart);
      await userBox.put('alarmFertileEndDate', fertileEnd);
      await userBox.put('alarmPmsStartDate', pmsStartDate);
      //

      String formattedNextPeriodStartDate =
          DateFormat('dd MMM').format(nextPeriodStartDate);
      await userBox.put('nextPeriodStartDate', formattedNextPeriodStartDate);

      await userBox.put('ovulationDay', formattedOvulationDay);
      await userBox.put('nextCycleDuration', menstrualCycleLength.toString());

      // Calculate the days left until the next period
      int daysLefts = nextPeriodStartDate.difference(currentDate).inDays;
      await userBox.put('leftDaysNextPeriod', daysLefts.toString());

      // Calculate approximate percentages for Period, Pms, and Fertile
      double cycleLength = menstrualCycleLength.toDouble();
      double daysPassed =
          menstrualCycleLength.toDouble() - daysLefts.toDouble();

      double periodPercentage = (daysPassed / cycleLength * 100).clamp(0, 100);
      double pmsPercentage =
          ((cycleLength - 7) / cycleLength * 100).clamp(0, 100);
      double fertilePercentage = (14 / cycleLength * 100).clamp(0, 100);

      await userBox.put('Period', periodPercentage.toStringAsFixed(2));
      await userBox.put('Pms', pmsPercentage.toStringAsFixed(2));
      await userBox.put('Fertile', fertilePercentage.toStringAsFixed(2));

      // Schedule the function to run again after 24 hours
      DateTime tomorrow =
          DateTime(currentDate.year, currentDate.month, currentDate.day + 1);
      Duration timeUntilTomorrow = tomorrow.difference(currentDate);

      // Schedule the function to run again after 24 hours
      Future.delayed(timeUntilTomorrow, () {
        calculateDatesAndSaveToHive();
      });
    } else {
      if (kDebugMode) {
        print('One or more required values are null');
      }
    }
  } catch (error) {
    if (kDebugMode) {
      print('Error calculating dates and saving to Hive: $error');
    }
  }
}
