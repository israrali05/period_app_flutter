import 'package:flutter/material.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class PeriodStartWidget extends StatelessWidget {
  final double? mySize;
  final String title;
  final Widget widget;
  final void Function()? ontap;
  const PeriodStartWidget(
      {super.key,
      required this.title,
      this.ontap,
      required this.widget,
      this.mySize});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                textStyle:
                    AppStyles.whitetext700.copyWith(fontSize: MySize.size15),
              ),
              widget,
            ],
          ),
          SizedBox(
            height: mySize,
          ),
          Divider(
            height: 5,
            color: AppColors.whiteColor,
          ),
          // SizedBox(
          //   height: MySize.size20,
          // ),
        ],
      ),
    );
  }
}
