import 'package:flutter/material.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/insight_screen/components/article_widget.dart';
import 'package:period_app/view/insight_screen/components/insight_left_container.dart';
import 'package:period_app/view/insight_screen/components/insight_right_container.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class InsightScreen extends StatelessWidget {
  const InsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(MySize.size30),
                child: CustomText(
                    text: "Today",
                    textStyle: AppStyles.whitetext900
                        .copyWith(fontSize: MySize.size26)),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: MySize.size30),
                child: CustomText(
                    text: "Insights",
                    textStyle: AppStyles.whitetext900.copyWith(
                      fontSize: MySize.size26,
                    )),
              ),
            ],
          ),
          Divider(
            color: AppColors.whiteColor,
            height: 1,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [InsightRightContainer(), InsightLeftContainer()],
          ),
          SizedBox(
            height: MySize.size50,
          ),
          ArticleWidget()
        ]),
      ),
    );
  }
}
