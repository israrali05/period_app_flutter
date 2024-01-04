import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/reminder_screen.dart/cycle_widget.dart';
import 'package:period_app/view/widgets/custom_appbar.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

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
          arrowBacktext: "",
          title: "Reminder",
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MySize.size50,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: MySize.size24, bottom: MySize.size10),
              child: CustomText(
                  text: "Cycle",
                  textStyle: AppStyles.whitetext900.copyWith(
                    fontSize: MySize.size26,
                  )),
            ),
            Container(
              padding: EdgeInsets.all(MySize.size10),
              color: AppColors.whiteColor.withOpacity(0.2),
              child: Column(children: [
                CycleWidget(
                  ontap: () {
                    Get.toNamed("/PeriodDayScreen");
                  },
                  title: "Period",
                ),
                CycleWidget(
                  ontap: () {
                    Get.toNamed("/FertilityScreen");
                  },
                  title: "Fertility",
                ),
                CycleWidget(
                  ontap: () {
                    Get.toNamed("/PmsScreen");
                  },
                  title: "Pms",
                ),
              ]),
            )
          ]),
    );
  }
}
