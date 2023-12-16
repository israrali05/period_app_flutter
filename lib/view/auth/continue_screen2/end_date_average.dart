import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_bottom.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class EndNumberPickerScreen extends StatefulWidget {
  @override
  _EndNumberPickerScreenState createState() => _EndNumberPickerScreenState();
}

class _EndNumberPickerScreenState extends State<EndNumberPickerScreen> {
  int _selectedValue = 0;
  final int minValue = 0;
  final int maxValue = 31;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        children: [
          // SizedBox(
          //   height: MySize.size38,
          // ),
          // CircleAvatar(
          //   radius: MySize.size300,
          //   backgroundImage: AssetImage(AppImages.selectDateImage),
          // ),
          Image.asset(
            AppImages.endDateImage,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: MySize.size38,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MySize.size20, horizontal: MySize.size20),
            child: CustomText(
                textAlign: TextAlign.center,
                text: "How Many Days Does Your Cycle Last On Avaerage?",
                textStyle:
                    AppStyles.whitetext900.copyWith(fontSize: MySize.size18)),
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
                  Get.toNamed("/BottomNavBar");
                },
                text: "Continue",
                buttonColor: AppColors.whiteColor,
                width: double.infinity,
                height: MySize.size52,
                borderColor: AppColors.blackColor,
                borderRadius: MySize.size15),
          ),
        ],
      ),
    );
  }
}
