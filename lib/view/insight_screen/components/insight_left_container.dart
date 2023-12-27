import 'package:flutter/material.dart';
import 'package:period_app/model/insights_model.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/insight_screen/components/insight_container_widget.dart';

class InsightLeftContainer extends StatelessWidget {
  const InsightLeftContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: MySize.size30),
          child: SizedBox(
            height: MySize.size30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: insightsMoodList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: MySize.size5),
                    child: MyCustomContainer(
                      bgColor: AppColors.primaryColor,
                      text: insightsMoodList[index],
                    ),
                  );
                }),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MySize.size5),
          child: SizedBox(
            height: MySize.size30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: insightsSymptomsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: MySize.size5),
                    child: MyCustomContainer(
                      bgColor: AppColors.primaryColor,
                      text: insightsSymptomsList[index],
                    ),
                  );
                }),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MySize.size40),
          child: SizedBox(
            height: MySize.size30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: insightsSexList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: MySize.size5),
                    child: MyCustomContainer(
                      bgColor: AppColors.primaryColor,
                      text: insightsSexList[index],
                    ),
                  );
                }),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MySize.size40),
          child: SizedBox(
            height: MySize.size30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: insightsDischargeList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: MySize.size5),
                    child: MyCustomContainer(
                      bgColor: AppColors.primaryColor,
                      text: insightsDischargeList[index],
                    ),
                  );
                }),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MySize.size50),
          child: SizedBox(
            height: MySize.size30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: insightsHeavinessList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: MySize.size5),
                    child: MyCustomContainer(
                      bgColor: AppColors.primaryColor,
                      text: insightsHeavinessList[index],
                    ),
                  );
                }),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MySize.size60, right: MySize.size10, left: MySize.size10),
          child: SizedBox(
              height: MySize.size50,
              child: TextFormField(
                style: AppStyles.whitetext700.copyWith(
                  fontSize: MySize.size16,
                ),
                cursorColor: AppColors.primaryColor,
                cursorHeight: MySize.size20,
                decoration: InputDecoration(
                  // Border settings for the text field
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(MySize.size20), // Border radius
                    borderSide: const BorderSide(
                        color: AppColors.primaryColor), // Default border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0), // Border radius
                    borderSide: const BorderSide(
                        color: AppColors.primaryColor), // Focused border color
                  ),
                ),
              )),
        ),
      ],
    ));
  }
}
