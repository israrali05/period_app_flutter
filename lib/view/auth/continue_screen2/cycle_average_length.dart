import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_bottom.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class NumberPickerScreen extends StatefulWidget {
  @override
  _NumberPickerScreenState createState() => _NumberPickerScreenState();
}

class _NumberPickerScreenState extends State<NumberPickerScreen> {
  int _selectedValue = 0;
  final int minValue = 20;
  final int maxValue = 35;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        children: [
          SizedBox(height: MySize.size38),
          Padding(
            padding: EdgeInsets.all(MySize.size22),
            child: Image.asset(AppImages.selectDateImage),
          ),
          SizedBox(height: MySize.size28),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MySize.size20, horizontal: MySize.size20),
            child: CustomText(
              textAlign: TextAlign.center,
              text: "How Many Days Average Menstrual Cycle Length?",
              textStyle:
                  AppStyles.whitetext900.copyWith(fontSize: MySize.size18),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MySize.size5, horizontal: MySize.size20),
            child: CustomText(
              textAlign: TextAlign.center,
              text:
                  "This can vary greatly from person to person but is typically around 28 days",
              textStyle:
                  AppStyles.whitetext900.copyWith(fontSize: MySize.size15),
            ),
          ),
          Expanded(
            child: Center(
              child: ListWheelScrollView(
                itemExtent: 60, // Change this value to adjust item height
                diameterRatio: 1.5, // Change this value for scaling
                physics: FixedExtentScrollPhysics(),
                children: List.generate(
                  maxValue - minValue + 1,
                  (index) {
                    final value = minValue + index;
                    return Center(
                      child: CustomText(
                        text: '$value',
                        textStyle: AppStyles.whitetext900
                            .copyWith(fontSize: MySize.size30),
                      ),
                    );
                  },
                ).toList(),
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedValue = minValue + index;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MySize.size40, horizontal: MySize.size40),
            child: CustomButton(
              ontap: () {
                _saveSelectedValueToHive(); // Call function to save selected value to Hive
                Get.toNamed("/EndNumberPickerScreen");
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

  Future<void> _saveSelectedValueToHive() async {
    try {
      final userBox =
          Hive.box('userBox'); // Open Hive box for storing int values
      await userBox.put(
          'averageCycle', _selectedValue); // Save selected value to Hive
    } catch (error) {
      print('Error saving data to Hive: $error');
    }
  }
}
