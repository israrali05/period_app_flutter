import 'package:flutter/material.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: MySize.size10),
          child: CustomText(
              text: "Articles",
              textStyle:
                  AppStyles.whitetext900.copyWith(fontSize: MySize.size26)),
        ),
        Padding(
          padding: EdgeInsets.only(left: MySize.size10),
          child: CustomText(
              text: "Recommended Based On Your Cycle.",
              textStyle:
                  AppStyles.whitetext900.copyWith(fontSize: MySize.size16)),
        ),
        SizedBox(
          height: MySize.size10,
        ),
        SizedBox(
            height: MySize.size200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          AppImages.endDateImage,
                          fit: BoxFit.cover,
                          width: MySize.size320,
                        ),
                      ));
                }))
      ],
    );
  }
}
