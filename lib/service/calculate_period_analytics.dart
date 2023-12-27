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

      // ovulation day
      DateTime currentDate = DateTime.now();

      // Assuming menstrualCycleLength is the length of the entire cycle in days
      Duration duration = Duration(days: menstrualCycleLength);
      DateTime ovulationDay =
          currentDate.add(duration).subtract(const Duration(days: 14));

      Duration daysUntilOvulation = ovulationDay.difference(currentDate);
      int daysLeft = daysUntilOvulation.inDays;

      // Format daysLeft as a string with two digits
      String formattedOvulationDay = daysLeft.toString();

      // end ovulation day

      // calculate fertile start and end date 

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
      print('One or more required values are null');
    }
  } catch (error) {
    print('Error calculating dates and saving to Hive: $error');
  }
}
