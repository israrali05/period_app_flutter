import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/about_screen/about_screen.dart';
import 'package:period_app/view/widgets/about_widget.dart';
import 'package:period_app/view/setting_screen/duration_widget.dart';
import 'package:period_app/view/widgets/custom_text.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String averageCycles = '';
  String periodCycles = '';

  @override
  void initState() {
    super.initState();
    _checkExistingName();
  }

  Future<void> _checkExistingName() async {
    try {
      // Access the Hive box
      final userBox = Hive.box('userBox');

      // Fetch the UserModel object from the box
      final averageCycle = userBox.get('averageCycle');
      final periodCycle = userBox.get('periodCycle');

      // Pre-fill the text field if UserModel exists
      if (averageCycle != null) {
        setState(() {
          averageCycles = averageCycle.toString();
          periodCycles = periodCycle.toString();

          // emailController.text = email.toString();
        });
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error checking existing name: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MySize.size120,
        surfaceTintColor: AppColors.primaryColor,
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: MySize.size25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: CustomText(
                          text: "Close",
                          textStyle: AppStyles.whitetext700.copyWith(
                              fontSize: MySize.size22,
                              color: AppColors.primaryColor)),
                    )
                  ],
                ),
              ),
              CustomText(
                  text: "Setting",
                  textStyle:
                      AppStyles.whitetext700.copyWith(fontSize: MySize.size26)),
              Divider(
                color: AppColors.whiteColor,
              ),
            ]),
      ),
      backgroundColor: AppColors.secondaryColor,
      body: LiquidPullToRefresh(
        color: AppColors.primaryColor,
        backgroundColor: AppColors.secondaryColor,
        onRefresh: _checkExistingName,
        showChildOpacityTransition: true,
        child: SingleChildScrollView(
          child: averageCycles.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      SizedBox(
                        height: MySize.size20,
                      ),
                      DurationCalculate(
                        title: "Duration of Cycle",
                        duration: averageCycles,
                      ),
                      SizedBox(
                        height: MySize.size25,
                      ),
                      DurationCalculate(
                        title: "Duration of Period",
                        duration: periodCycles,
                      ),
                      SizedBox(
                        height: MySize.size80,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: MySize.size10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.settingCalendar,
                                  height: MySize.size36,
                                  width: MySize.size36,
                                ),
                                SizedBox(
                                  width: MySize.size10,
                                ),
                                CustomText(
                                    textAlign: TextAlign.start,
                                    text: "Notify About The Start \nOf Period",
                                    textStyle: AppStyles.whitetext700.copyWith(
                                        fontSize: MySize.size18,
                                        height: MySize.size0)),
                              ],
                            ),
                            SizedBox(
                              height: MySize.size35,
                              width: MySize.size110,
                              child: LiteRollingSwitch(
                                  width: MySize.size120,
                                  onSwipe: () {},
                                  onDoubleTap: () {},
                                  onTap: () {},
                                  //initial value
                                  value: true,
                                  textOn: 'Period ON',
                                  textOnColor: AppColors.whiteColor,
                                  textOff: 'OFF',
                                  colorOn: AppColors.primaryColor,
                                  colorOff: AppColors.secondaryColor,
                                  iconOn: Icons.done,
                                  iconOff: Icons.remove_circle_outline,
                                  textSize: MySize.size12,
                                  onChanged: (bool period) {
                                    //Use it to manage the different states
                                    print(
                                        'Current State of SWITCH IS: $period');
                                  }),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MySize.size30,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: MySize.size10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.settingOvulation,
                                  height: MySize.size36,
                                  width: MySize.size36,
                                ),
                                SizedBox(
                                  width: MySize.size10,
                                ),
                                CustomText(
                                    textAlign: TextAlign.start,
                                    text:
                                        "Notify About The Atart Of \nThe Ovulation",
                                    textStyle: AppStyles.whitetext700.copyWith(
                                        fontSize: MySize.size18,
                                        height: MySize.size0)),
                              ],
                            ),
                            SizedBox(
                              height: MySize.size35,
                              width: MySize.size110,
                              child: LiteRollingSwitch(
                                  width: MySize.size120,
                                  onSwipe: () {},
                                  onDoubleTap: () {},
                                  onTap: () {},
                                  //initial value
                                  value: true,
                                  textOn: 'Ovulation',
                                  textOnColor: AppColors.whiteColor,
                                  textOff: 'OFF',
                                  colorOn: AppColors.primaryColor,
                                  colorOff: AppColors.secondaryColor,
                                  iconOn: Icons.done,
                                  iconOff: Icons.remove_circle_outline,
                                  textSize: MySize.size12,
                                  onChanged: (bool ovulation) {
                                    //Use it to manage the different states
                                    print(
                                        'Current State of oWITCH IS: $ovulation');
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MySize.size80,
                      ),
                      CustomText(
                          text: "About",
                          textAlign: TextAlign.center,
                          textStyle: AppStyles.whitetext700.copyWith(
                            fontSize: MySize.size22,
                          )),
                      const Divider(
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(
                        height: MySize.size40,
                      ),
                      AboutColumnWidget(
                        ontap: () {},
                        title: "Peflow",
                      ),
                      SizedBox(
                        height: MySize.size20,
                      ),
                      AboutColumnWidget(
                        ontap: () {},
                        title: "Invester",
                      ),
                      SizedBox(
                        height: MySize.size20,
                      ),
                      AboutColumnWidget(
                        ontap: () {},
                        title: "Support",
                      ),
                      SizedBox(
                        height: MySize.size20,
                      ),
                      AboutColumnWidget(
                        ontap: () {
                          Get.to(() => AboutScreen());
                        },
                        title: "About Us",
                      )
                    ]),
        ),
      ),
    );
  }
}
