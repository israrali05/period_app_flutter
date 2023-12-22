import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:period_app/model/user_model.dart';
import 'package:period_app/utils/app_colors.dart';
import 'package:period_app/utils/app_images.dart';
import 'package:period_app/utils/app_styles.dart';
import 'package:period_app/utils/mysize.dart';
import 'package:period_app/view/user_screen/components/tap_to_change_textfield.dart';
import 'package:period_app/view/widgets/custom_bottom.dart';
import 'package:period_app/view/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class EnterYourName extends StatefulWidget {
  const EnterYourName({Key? key}) : super(key: key);

  @override
  _EnterYourNameState createState() => _EnterYourNameState();
}

class _EnterYourNameState extends State<EnterYourName> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkExistingName();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> _checkExistingName() async {
    try {
      // Access the Hive box
      final userBox = Hive.box('userBox');

      // Fetch the UserModel object from the box
      UserModel? user = userBox.get('user');

      // Pre-fill the text field if UserModel exists
      if (user != null) {
        setState(() {
          nameController.text = user.name.toString();
        });
      }
    } catch (error) {
      print('Error checking existing name: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(AppImages.enterNamepicture),
            SizedBox(
              height: MySize.size28,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MySize.size10, horizontal: MySize.size20),
              child: CustomText(
                  textAlign: TextAlign.center,
                  text: "Enter Your Info: ",
                  textStyle:
                      AppStyles.whitetext900.copyWith(fontSize: MySize.size18)),
            ),
            SizedBox(
              height: MySize.size60,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MySize.size40),
              child: UserTextfieldWidget(
                  lableText: "First Name", controller: nameController),
            ),
            SizedBox(
              height: MySize.size25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MySize.size40),
              child: UserTextfieldWidget(
                  lableText: "Enter Email", controller: emailController),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MySize.size40, horizontal: MySize.size40),
              child: CustomButton(
                ontap: () async {
                  String enteredName = nameController.text;
                  String enteredEmail = emailController.text;

                  // Create a UserModel instance with the entered name
                  try {
                    final userBox = Hive.box('userBox');

                    await userBox.put('name', enteredName);
                    await userBox.put('email', enteredEmail);

                    print('Name saved successfully to Hive! $enteredName');
                  } catch (error) {
                    print('Error saving data to Hive: $error');
                  }

                  // Navigate to the next screen
                  Get.toNamed("/NumberPickerScreen");
                },
                text: "Continue",
                buttonColor: AppColors.whiteColor,
                width: double.infinity,
                height: MySize.size52,
                borderColor: AppColors.blackColor,
                borderRadius: MySize.size15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
