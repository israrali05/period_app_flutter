import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class AboutColumnWidget extends StatelessWidget {
  final String title;
  final void Function()? ontap;
  const AboutColumnWidget({super.key, required this.title, this.ontap});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.only(left: MySize.scaleFactorWidth * 70),
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
                Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.greyColor,
                  size: MySize.size25,
                )
              ],
            ),
            Divider(
              color: AppColors.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
