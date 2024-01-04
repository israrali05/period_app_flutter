import 'package:flutter/material.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class DurationCalculate extends StatelessWidget {
  final String title;
  final String duration;
  const DurationCalculate({
    super.key,
    required this.title,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
                textAlign: TextAlign.center,
                text: title,
                textStyle: AppStyles.whitetext700.copyWith(
                  fontSize: MySize.size18,
                )),
          ],
        ),
        SizedBox(
          height: MySize.size20,
        ),
        Container(
          color: AppColors.primaryColor.withOpacity(0.3),
          width: MySize.screenWidth,
          height: MySize.size50,
          // padding: EdgeInsets.all(MySize.size0),
          child: Center(
            child: CustomText(
                text: duration,
                textStyle:
                    AppStyles.whitetext900.copyWith(fontSize: MySize.size30)),
          ),
        )
      ],
    );
  }
}
