import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/partner/partner_screen.dart';
import 'package:period_app/view/reminder_screen.dart/reminder_screen.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late String name;
  late String email;
  late String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchDataFromHive(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator(color: AppColors.primaryColor));
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            Map<String, dynamic> hiveData = snapshot.data!;
            name = hiveData['name'] ?? '';
            email = hiveData['email'] ?? '';
            image = hiveData['avatar'] ?? '';

            return YourExistingUIWidget(
              image: image,
              email: email,
              userName: name,
              refreshData: fetchDataFromHive, //
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchDataFromHive() async {
    try {
      final userBox = Hive.box('userBox');
      return {
        'name': userBox.get('name') ?? '',
        'email': userBox.get('email') ?? '',
        'avatar': userBox.get('avatar') ?? '',
      };
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching data from Hive: $error');
      }
      return {};
    }
  }
}

class YourExistingUIWidget extends StatefulWidget {
  final String userName;
  final String email;
  final String image;
  final Future<void> Function() refreshData;

  const YourExistingUIWidget(
      {Key? key,
      required this.userName,
      required this.email,
      required this.image,
      required this.refreshData})
      : super(key: key);

  @override
  State<YourExistingUIWidget> createState() => _YourExistingUIWidgetState();
}

class _YourExistingUIWidgetState extends State<YourExistingUIWidget> {
  Future<void> refreshData() async {
    await widget
        .refreshData(); // Call the refresh method from the parent widget
    setState(() {}); // Update the UI after data refresh
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.secondaryColor,
        backgroundColor: AppColors.secondaryColor,
        leading: Icon(
          Icons.arrow_back_ios_rounded,
          color: AppColors.greyColor,
          size: MySize.size24,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: MySize.size25),
            child: InkWell(
              onTap: () {
                Get.toNamed("/SettingScreen");
              },
              child: Icon(
                Icons.settings,
                color: AppColors.greyColor,
                size: MySize.size24,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.secondaryColor,
      body: LiquidPullToRefresh(
        color: AppColors.primaryColor,
        backgroundColor: AppColors.secondaryColor,
        onRefresh: refreshData,
        showChildOpacityTransition: true,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MySize.screenHeight,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MySize.size40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/TapToChange");
                    },
                    child: Center(
                      child: CircleAvatar(
                        backgroundImage: widget.image != "" &&
                                File(widget.image).existsSync()
                            ? Image.file(File(widget.image))
                                .image // Use FileImage to load the image from the file path
                            : AssetImage(
                                "assets/images/default_image.jpg"), // Fallback to AssetImage if path is invalid or image doesn't exist
                        radius: MySize.size60,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MySize.size40,
                  ),
                  CustomText(
                      text: widget.userName.toString(),
                      textStyle: AppStyles.whitetext700
                          .copyWith(fontSize: MySize.size26, height: 0)),
                  CustomText(
                      text: widget.email.toString(),
                      textStyle: AppStyles.whitetext700
                          .copyWith(fontSize: MySize.size22, height: 0)),
                  SizedBox(
                    height: MySize.size40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MySize.size40, right: MySize.size10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: "Reminders",
                            textStyle: AppStyles.whitetext700
                                .copyWith(fontSize: MySize.size22, height: 0)),
                        InkWell(
                          onTap: () {
                            Get.to(() => ReminderScreen());
                          },
                          child: CustomText(
                              text: "Active",
                              textStyle: AppStyles.whitetext700.copyWith(
                                  fontSize: MySize.size22,
                                  height: 0,
                                  color:
                                      AppColors.whiteColor.withOpacity(0.7))),
                        ),
                        SizedBox(
                          height: MySize.size10,
                        ),
                        Container(
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.5,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MySize.size20,
                        ),
                        CustomText(
                            text: "Partner",
                            textStyle: AppStyles.whitetext700
                                .copyWith(fontSize: MySize.size22, height: 0)),
                        InkWell(
                          onTap: () {
                            Get.to(() => PartnerScreen());
                          },
                          child: CustomText(
                              text: "Keep them in the loop",
                              textStyle: AppStyles.whitetext700.copyWith(
                                  fontSize: MySize.size22,
                                  height: 0,
                                  color:
                                      AppColors.whiteColor.withOpacity(0.7))),
                        ),
                        SizedBox(
                          height: MySize.size10,
                        ),
                        Container(
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.5,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
