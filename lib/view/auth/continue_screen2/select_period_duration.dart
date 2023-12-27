import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_bottom.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class EndNumberPickerScreen extends StatefulWidget {
  const EndNumberPickerScreen({super.key});

  @override
  _EndNumberPickerScreenState createState() => _EndNumberPickerScreenState();
}

class _EndNumberPickerScreenState extends State<EndNumberPickerScreen> {
  int _selectedValue = 0;
  final int minValue = 3;
  final int maxValue = 7;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        children: [
          Image.asset(
            AppImages.endDateImage,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: MySize.size38),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MySize.size20, horizontal: MySize.size20),
            child: CustomText(
              textAlign: TextAlign.center,
              text: "Determining Cycle Length Last On Average??",
              textStyle:
                  AppStyles.whitetext900.copyWith(fontSize: MySize.size18),
            ),
          ),
          Expanded(
            child: Center(
              child: ListWheelScrollView(
                itemExtent: 60,
                diameterRatio: 1.5,
                physics: const FixedExtentScrollPhysics(),
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
                saveSelectedValueToHive(); // Save selected value to Hive before navigating
                Get.toNamed("/SelectLastPeriodDate");
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

  void saveSelectedValueToHive() async {
    try {
      final box = Hive.box(
          'userBox'); // Replace 'selectedValueBox' with your preferred box name
      await box.put('periodCycle', _selectedValue);
    } catch (error) {
      print('Error saving data to Hive: $error');
    }
  }
}
