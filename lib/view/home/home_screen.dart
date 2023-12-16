import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:get/get.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_text.dart';
import 'package:period_app/view/widgets/primary_button.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    Map<String, double> dataMap = {
      'Period': 10,
      'Pms': 30,
      'Fertile': 10,
    };

    List<Color> colorList = [
      Color(0xFF49EFB3),
      Color(0xFFF8FFAE),
      Color(0xFFEF4A4A),
    ];
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MySize.size50),
              Stack(
                children: [
                  Positioned(
                    top: MySize.size0,
                    right: MySize.size10,
                    child: CircularText(children: [
                      TextItem(
                        text: Text(
                          "Period",
                          style: TextStyle(
                            fontSize: MySize.size15,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        space: MySize.size4,
                        startAngle: -30,
                        startAngleAlignment: StartAngleAlignment.end,
                        direction: CircularTextDirection.clockwise,
                      )
                    ]),
                  ),
                  Positioned(
                    top: MySize.size0,
                    left: MySize.size15,
                    child: CircularText(children: [
                      TextItem(
                        text: Text(
                          "Pms",
                          style: TextStyle(
                            fontSize: MySize.size15,
                            color: Color(0xFFF8FFAE),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        space: MySize.size5,
                        startAngle: -130,
                        startAngleAlignment: StartAngleAlignment.end,
                        direction: CircularTextDirection.clockwise,
                      )
                    ]),
                  ),
                  Positioned(
                    bottom: MySize.size0,
                    right: MySize.size10,
                    child: CircularText(children: [
                      TextItem(
                        text: Text(
                          "Fertile",
                          style: TextStyle(
                            fontSize: MySize.size15,
                            color: Color(0xFF49EFB3),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        space: MySize.size4,
                        startAngle: 418,
                        startAngleAlignment: StartAngleAlignment.end,
                        direction: CircularTextDirection.clockwise,
                      )
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(MySize.size15),
                    child: Container(
                      padding: EdgeInsets.all(MySize.size10),
                      decoration: ShapeDecoration(
                        color: AppColors.whiteColor.withOpacity(0.5),
                        shape: OvalBorder(),
                      ),
                      child: PieChart(
                        // legendOptions: LegendOptions(),
                        dataMap: dataMap,
                        colorList: colorList,
                        baseChartColor: AppColors.whiteColor,
                        chartType: ChartType.ring,
                        centerWidget: Container(
                          padding: EdgeInsets.all(MySize.size30),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            // shape: OvalBorder(),
                            border: Border.all(
                              color: Colors.white, // Change the color if needed
                              width: MySize.size10,
                            ),
                          ),
                          child: Column(children: [
                            CustomText(
                                text: "Ovulation In 5 \nDays",
                                textAlign: TextAlign.center,
                                textStyle: AppStyles.whitetext900
                                    .copyWith(fontSize: MySize.size15)),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: MySize.size20),
                              child: CustomText(
                                  text: "25 Feb",
                                  textStyle: AppStyles.whitetext900
                                      .copyWith(fontSize: MySize.size35)),
                            ),
                            CustomText(
                                text: "Cycle day 11",
                                textStyle: AppStyles.whitetext900
                                    .copyWith(fontSize: MySize.size15)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MySize.size50,
                                  vertical: MySize.size10),
                              child: PrimaryButton(
                                  fontsize: MySize.size15,
                                  text: "Log Period",
                                  buttonColor: AppColors.primaryColor,
                                  width: MySize.size160,
                                  height: MySize.size50,
                                  borderColor: AppColors.primaryColor,
                                  borderRadius: MySize.size20),
                            )
                          ]),
                        ),
                        legendOptions: LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.bottom,
                          showLegends: false,
                          legendShape: BoxShape.circle,
                          legendTextStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          decimalPlaces: 2,
                          showChartValueBackground: false,
                          showChartValues: false,
                          showChartValuesInPercentage: true,
                          // showChartValuesOutside: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MySize.size20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIndicator(color: Color(0xFFEF4A4A), text: 'Period'),
                    SizedBox(
                      height: MySize.size10,
                    ),
                    _buildIndicator(color: Color(0xFFF8FFAE), text: 'Pms'),
                    SizedBox(
                      height: MySize.size10,
                    ),
                    _buildIndicator(color: Color(0xFF49EFB3), text: 'Fertile'),
                  ],
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MySize.size50, vertical: MySize.size20),
                child: PrimaryButton(
                    fontsize: MySize.size26,
                    text: "Log For Today",
                    buttonColor: AppColors.primaryColor,
                    width: double.infinity,
                    height: MySize.size60,
                    borderColor: AppColors.primaryColor,
                    borderRadius: MySize.size20),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator({required Color color, required String text}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Container(
            width: MySize.size20,
            height: MySize.size20,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: MySize.size5),
          CustomText(
              text: text,
              textStyle:
                  AppStyles.whitetext900.copyWith(fontSize: MySize.size15)),
        ],
      ),
    );
  }
}
