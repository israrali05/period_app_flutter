import 'package:flutter/material.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class InsightCategoryWidget extends StatelessWidget {
  final String text;
  final String image;
  const InsightCategoryWidget(
      {super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Column(
      children: [
        Image.asset(
          image,
          height: MySize.size24,
        ),
        CustomText(
            text: text,
            textStyle: AppStyles.whitetext900.copyWith(fontSize: MySize.size16))
      ],
    );
  }
}
