import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_appbar.dart';
import 'package:period_app/view/widgets/custom_text.dart';
import 'package:period_app/view/widgets/primary_button.dart';

class PartnerScreen extends StatelessWidget {
  const PartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MySize.size60,
        surfaceTintColor: AppColors.primaryColor.withOpacity(0.2),
        backgroundColor: AppColors.primaryColor.withOpacity(0.2),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          arrowBacktext: "Me",
          title: "Partner",
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MySize.size60,
            ),
            CustomText(
                text: "Connect With Your Partner",
                textStyle: AppStyles.whitetext900.copyWith(
                  fontSize: MySize.size22,
                )),
            Padding(
              padding: EdgeInsets.only(left: MySize.size80),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MySize.size30,
                    ),
                    CustomText(
                        text: "Keep Them In The Loop",
                        textStyle: AppStyles.whitetext700.copyWith(
                          fontSize: MySize.size15,
                        )),
                    SizedBox(
                      height: MySize.size10,
                    ),
                    CustomText(
                        text: "Plan Time Together On Special Days",
                        textStyle: AppStyles.whitetext700.copyWith(
                          fontSize: MySize.size15,
                        )),
                    SizedBox(
                      height: MySize.size10,
                    ),
                    CustomText(
                        text: "Total Privacy: Just For You Two",
                        textStyle: AppStyles.whitetext700.copyWith(
                          fontSize: MySize.size15,
                        )),
                  ]),
            ),
            SizedBox(
              height: MySize.size60,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MySize.size60),
              child: PrimaryButton(
                  fontsize: MySize.size16,
                  text: "Invite Partner",
                  buttonColor: AppColors.primaryColor,
                  width: double.infinity,
                  height: MySize.size60,
                  borderColor: AppColors.primaryColor,
                  borderRadius: MySize.size20),
            ),
          ]),
    );
  }
}
