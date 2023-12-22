import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:period_app/model/user_model.dart';
import 'package:period_app/service/calculate_period_analytics.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/widgets/custom_text.dart';
import 'package:period_app/view/widgets/primary_button.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String ovulationDay;
  late String nextCycleDuration;
  late String leftDaysNextPeriod;
  late String nextPeriodStartDate;
  late String pms;
  late String fertile;
  late String period;

  @override
  void initState() {
    super.initState();
    // Call the function to calculate and store menstrual cycle data
    calculateDatesAndSaveToHive().then((_) {
      // Once data is saved, load the screen
      setState(() {}); // Refresh the UI after data is stored
    });
  }

  Future<Map<String, dynamic>> fetchDataFromHive() async {
    try {
      final userBox = Hive.box('userBox');
      return {
        'ovulationDay': userBox.get('ovulationDay') ?? '',
        'nextCycleDuration': userBox.get('nextCycleDuration') ?? '',
        'nextPeriodStartDate': userBox.get('nextPeriodStartDate') ?? '',
        'leftDaysNextPeriod': userBox.get('leftDaysNextPeriod') ?? '',
        'Period': userBox.get('Period') ?? '',
        'Fertile': userBox.get('Fertile') ?? '',
        'Pms': userBox.get('Pms') ?? '',
      };
    } catch (error) {
      print('Error fetching data from Hive: $error');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchDataFromHive(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            Map<String, dynamic> hiveData = snapshot.data!;
                   ovulationDay = hiveData['ovulationDay'] ?? '';
            nextCycleDuration = hiveData['nextCycleDuration'] ?? '';
            nextPeriodStartDate = hiveData['nextPeriodStartDate'] ?? '';
            leftDaysNextPeriod = hiveData['leftDaysNextPeriod'] ?? '';
            pms = hiveData['Pms'] ?? '';
            fertile = hiveData['Fertile'] ?? '';
            period = hiveData['Period'] ?? '';
    
            return YourExistingUIWidget(
              fertile: fertile,
              period: period,
              pms: pms,
              nextPeriodStartDate: nextPeriodStartDate,
              leftDaysNextPeriod: leftDaysNextPeriod,
              ovulationDay: ovulationDay,
              nextCycleDuration: nextCycleDuration,
            );
          }
        },
      ),
    );
  }
}

class YourExistingUIWidget extends StatelessWidget {
  final String ovulationDay;
  final String nextCycleDuration;
  final String leftDaysNextPeriod;
  final String nextPeriodStartDate;

  final String period;
  final String pms;
  final String fertile;

  const YourExistingUIWidget({
    Key? key,
    required this.ovulationDay,
    required this.nextCycleDuration,
    required this.leftDaysNextPeriod,
    required this.nextPeriodStartDate,
    required this.period,
    required this.pms,
    required this.fertile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    Map<String, double> dataMap = {
      'Period': double.parse(period),
      'Pms': double.parse(pms),
      'Fertile': double.parse(fertile),
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
              SizedBox(height: MySize.size40),
              Padding(
                padding: EdgeInsets.symmetric(vertical: MySize.size20),
                child: CustomText(
                    textAlign: TextAlign.center,
                    text: "Your Next Period $leftDaysNextPeriod Days Left",
                    textStyle: AppStyles.whitetext900
                        .copyWith(fontSize: MySize.size20)),
              ),
              SizedBox(height: MySize.size20),
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
                            color:  Color(0xFFEF4A4A),
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
                                text: "Ovulation In $ovulationDay \nDays",
                                textAlign: TextAlign.center,
                                textStyle: AppStyles.whitetext900
                                    .copyWith(fontSize: MySize.size15)),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: MySize.size20),
                              child: CustomText(
                                  text: nextPeriodStartDate,
                                  textStyle: AppStyles.whitetext900
                                      .copyWith(fontSize: MySize.size35)),
                            ),
                            CustomText(
                                text: "Cycle day $nextCycleDuration",
                                textStyle: AppStyles.whitetext900
                                    .copyWith(fontSize: MySize.size15)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MySize.size50,
                                  vertical: MySize.size10),
                              child: PrimaryButton(
                                ontap: (){
                                    Get.toNamed("/NumberPickerScreen");
                                },
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

  // Add other necessary properties and methods here
}
