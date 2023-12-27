import 'package:flutter/material.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/view/widgets/custom_text.dart';

import '../../../utils/mysize.dart';

class MyCustomContainer extends StatelessWidget {
  final String text;
  final Color bgColor;

  const MyCustomContainer(
      {super.key, required this.text, required this.bgColor});
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MySize.size20),
      height: MySize.size30, // Set the desired height of the container
      // width: width, // Set the width to fill the available space
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          const BoxShadow(
            color: const Color(0x3F000000),
            blurRadius: 2,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Center(
        child: CustomText(
            text: text,
            textStyle: AppStyles.whitetext700
                .copyWith(fontSize: MySize.size18, height: 0)),
      ),
    );
  }
}
