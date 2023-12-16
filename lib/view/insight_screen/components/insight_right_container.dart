import 'package:flutter/material.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/insight_screen/components/Insights_categories_widget.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class InsightRightContainer extends StatelessWidget {
  const InsightRightContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
      decoration: ShapeDecoration(
        color: AppColors.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 1,
            offset: Offset(0, 0.2),
            spreadRadius: 0,
          )
        ],
      ),
      padding: EdgeInsets.symmetric(
          vertical: MySize.size20, horizontal: MySize.size20),
      child: Column(children: [
        InsightCategoryWidget(
          image: AppImages.insightMood,
          text: "Mood",
        ),
        SizedBox(
          height: MySize.size25,
        ),
        InsightCategoryWidget(
          image: AppImages.insightheart,
          text: "Sex",
        ),
        SizedBox(
          height: MySize.size25,
        ),
        InsightCategoryWidget(
          image: AppImages.insightsymptoms,
          text: "Symptoms",
        ),
        SizedBox(
          height: MySize.size25,
        ),
        InsightCategoryWidget(
          image: AppImages.insightDischarge,
          text: "Discharge",
        ),
        SizedBox(
          height: MySize.size25,
        ),
        Row(
          children: [
            Image.asset(
              AppImages.insightDischarge,
              height: MySize.size24,
            ),
            Image.asset(
              AppImages.insightDischarge,
              height: MySize.size24,
            ),
          ],
        ),
        CustomText(
            text: "Heaviness \nOf Flow",
            textAlign: TextAlign.center,
            textStyle:
                AppStyles.whitetext900.copyWith(fontSize: MySize.size16)),
        SizedBox(
          height: MySize.size25,
        ),
        InsightCategoryWidget(
          image: AppImages.insightedit,
          text: "Notes",
        ),
      ]),
    );
  }
}
