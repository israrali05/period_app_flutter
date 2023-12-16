import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/user_screen/components/tap_to_change_textfield.dart';
import 'package:period_app/view/widgets/custom_bottom.dart';
import 'package:period_app/view/widgets/custom_text.dart';
import 'package:period_app/view/widgets/primary_button.dart';

class TapToChange extends StatelessWidget {
  const TapToChange({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.secondaryColor,
        backgroundColor: AppColors.secondaryColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.greyColor,
            size: MySize.size24,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: MySize.size25),
            child: Icon(
              Icons.settings,
              color: AppColors.greyColor,
              size: MySize.size24,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MySize.size40,
              ),
              Center(
                child: CircleAvatar(
                  radius: MySize.size60,
                  backgroundColor: AppColors.greyColor,
                ),
              ),
              SizedBox(
                height: MySize.size20,
              ),
              CustomText(
                  text: "Tap To Change",
                  textStyle: AppStyles.whitetext700
                      .copyWith(fontSize: MySize.size22, height: 0)),
              SizedBox(
                height: MySize.size60,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MySize.size40, right: MySize.size10),
                    child: CustomText(
                        text: "Account",
                        textStyle: AppStyles.whitetext700
                            .copyWith(fontSize: MySize.size22, height: 0)),
                  ),
                  SizedBox(
                    height: MySize.size30,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        top: MySize.size20,
                        bottom: MySize.size20,
                        left: MySize.size30),
                    color:
                        const Color.fromRGBO(255, 255, 255, 1).withOpacity(0.3),
                    child: Column(
                      children: [
                        UserTextfieldWidget(lableText: "First Name"),
                        SizedBox(
                          height: MySize.size20,
                        ),
                        UserTextfieldWidget(lableText: "Last Name"),
                        SizedBox(
                          height: MySize.size20,
                        ),
                        UserTextfieldWidget(lableText: "Email"),
                        SizedBox(
                          height: MySize.size20,
                        ),
                        UserTextfieldWidget(lableText: "Sex"),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MySize.size30,
              ),
              CustomButton(
                  ontap: () {},
                  text: "Save",
                  buttonColor: AppColors.whiteColor,
                  width: MySize.size120,
                  height: MySize.size60,
                  borderColor: AppColors.whiteColor,
                  borderRadius: MySize.size20),
              SizedBox(
                height: MySize.size30,
              ),
            ]),
      ),
    );
  }
}
