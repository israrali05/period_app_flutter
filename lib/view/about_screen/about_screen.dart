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

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
          arrowBacktext: "Setting",
          title: "About",
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MySize.size120,
            ),
            CustomText(
                text: "Peflow",
                textStyle: AppStyles.whitetext900.copyWith(
                  fontSize: MySize.size30,
                )),
            SizedBox(
              height: MySize.size30,
            ),
            CustomText(
                text: "Buit For You",
                textStyle: AppStyles.whitetext700.copyWith(
                  fontSize: MySize.size22,
                )),
            SizedBox(
              height: MySize.size10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MySize.size50),
              child: CustomText(
                  textAlign: TextAlign.center,
                  text:
                      "Peflow is the most elegant way to track your menstrual cycle.",
                  textStyle: AppStyles.whitetext700.copyWith(
                    fontSize: MySize.size18,
                  )),
            ),
            SizedBox(
              height: MySize.size40,
            ),
            Container(
              color: AppColors.whiteColor.withOpacity(0.2),
              padding: EdgeInsets.symmetric(
                  horizontal: MySize.size10, vertical: MySize.size10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: "Tell A Friend",
                        textStyle: AppStyles.whitetext700.copyWith(
                          fontSize: MySize.size15,
                        )),
                    Divider(
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(
                      height: MySize.size10,
                    ),
                    CustomText(
                        text: "Write A Review",
                        textStyle: AppStyles.whitetext700.copyWith(
                          fontSize: MySize.size15,
                        )),
                    Divider(
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(
                      height: MySize.size10,
                    ),
                    CustomText(
                        text: "Terms & Policies",
                        textStyle: AppStyles.whitetext700.copyWith(
                          fontSize: MySize.size15,
                        )),
                    Divider(
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(
                      height: MySize.size10,
                    ),
                  ]),
            )
          ]),
    );
  }
}
