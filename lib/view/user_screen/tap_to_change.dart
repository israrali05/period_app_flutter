import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:period_app/model/user_model.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/user_screen/components/tap_to_change_textfield.dart';
import 'package:period_app/view/widgets/custom_bottom.dart';
import 'package:period_app/view/widgets/custom_text.dart';

class TapToChange extends StatefulWidget {
  const TapToChange({super.key});

  @override
  State<TapToChange> createState() => _TapToChangeState();
}

class _TapToChangeState extends State<TapToChange> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _checkExistingName();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    sexController.dispose();
    super.dispose();
  }

  Future<void> _checkExistingName() async {
    try {
      // Access the Hive box
      final userBox = Hive.box('userBox');

      // Fetch the UserModel object from the box
      UserModel? user = userBox.get('user');
      final email = userBox.get('email');
      final sex = userBox.get('sex');

      // Pre-fill the text field if UserModel exists
      if (user != null) {
        setState(() {
          nameController.text = user.name.toString();
          emailController.text = email.toString();
          sexController.text = sex.toString();
        });
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error checking existing name: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    Future<void> getImage(ImageSource source) async {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: source);

      if (pickedImage != null) {
        final userBox = Hive.box('userBox');
        await userBox.put('avatar', pickedImage.path.toString());

        // Update UI to show the picked image in a circular avatar
        // setState(() {
        //   avatarImagePath = pickedImage.path;
        // });
      }
    }

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.secondaryColor,
        backgroundColor: AppColors.secondaryColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.greyColor,
            size: MySize.size24,
          ),
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
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MySize.size25,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.secondaryColor,
                          elevation: 1,
                          title: CustomText(
                              text: "Select Image Source",
                              textStyle: AppStyles.whitetext700.copyWith(
                                  fontSize: MySize.size16, height: 0)),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    getImage(ImageSource.gallery);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(MySize.size10),
                                    child: CustomText(
                                        text: "Gallery",
                                        textStyle: AppStyles.whitetext700
                                            .copyWith(
                                                fontSize: MySize.size14,
                                                height: 0)),
                                  ),
                                ),
                                SizedBox(height: MySize.size15),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    getImage(ImageSource.camera);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(MySize.size10),
                                    child: CustomText(
                                        text: "Camera",
                                        textStyle: AppStyles.whitetext700
                                            .copyWith(
                                                fontSize: MySize.size14,
                                                height: 0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: MySize.size60,
                    backgroundColor: AppColors.greyColor,
                  ),
                ),
              ),
              SizedBox(
                height: MySize.size20,
              ),
              CustomText(
                  text: "Tap To Change",
                  textStyle: AppStyles.whitetext700
                      .copyWith(fontSize: MySize.size22, height: 0)),
              SizedBox(
                height: MySize.size60,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MySize.size40, right: MySize.size10),
                    child: CustomText(
                        text: "Account",
                        textStyle: AppStyles.whitetext700
                            .copyWith(fontSize: MySize.size22, height: 0)),
                  ),
                  SizedBox(
                    height: MySize.size30,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        top: MySize.size20,
                        bottom: MySize.size20,
                        left: MySize.size30),
                    color:
                        const Color.fromRGBO(255, 255, 255, 1).withOpacity(0.3),
                    child: Column(
                      children: [
                        UserTextfieldWidget(
                            lableText: "Enter Name",
                            controller: nameController),
                        SizedBox(
                          height: MySize.size20,
                        ),
                        UserTextfieldWidget(
                            lableText: "Email", controller: emailController),
                        SizedBox(
                          height: MySize.size20,
                        ),
                        UserTextfieldWidget(
                            lableText: "Sex", controller: sexController),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MySize.size30,
              ),
              CustomButton(
                  ontap: () async {
                    String enteredName = nameController.text;
                    String enteredEmail = emailController.text;
                    String enteredSex = sexController.text;

                    try {
                      final userBox = Hive.box('userBox');

                      await userBox.put('name', enteredName);
                      await userBox.put('email', enteredEmail);
                      await userBox.put('sex', enteredSex);

                      Get.snackbar(
                        'Data Updated Successfully',
                        'Your Name and Email & image Updated',
                        backgroundColor: AppColors.primaryColor,
                        colorText: Colors.white,

                        snackPosition:
                            SnackPosition.TOP, // Display snackbar at the top
                      );

                      if (kDebugMode) {
                        print(
                            'User data saved successfully to Hive! $enteredName');
                      }
                    } catch (error) {
                      if (kDebugMode) {
                        print('Error saving data to Hive: $error');
                      }
                    }
                  },
                  text: "Save",
                  buttonColor: AppColors.whiteColor,
                  width: MySize.size120,
                  height: MySize.size60,
                  borderColor: AppColors.whiteColor,
                  borderRadius: MySize.size20),
              SizedBox(
                height: MySize.size30,
              ),
            ]),
      ),
    );
  }
}
