import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/login_page/login_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/signup_page/signup_page_controller.dart';
import 'package:medical_chain_mobile_ui/screens/login_page/login_page_screen.dart';
import 'package:medical_chain_mobile_ui/screens/signup_pape/signup_screen.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';

class LoginWelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.55,
          child: Image.asset(
            "assets/images/logowelcome.png",
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: getHeight(37.38),
        ),
        SizedBox(
          width: getWidth(224),
          height: getHeight(84),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "ブロックチェーン\nアプリ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getWidth(28),
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: getWidth(16),
            right: getWidth(16),
            top: getHeight(62),
          ),
          child: Column(
            children: [
              Bouncing(
                child: Container(
                  width: getWidth(double.infinity),
                  height: getHeight(48),
                  color: Color(0xFFD0E8FF),
                  alignment: Alignment.center,
                  child: Text('signupButton'.tr),
                ),
                onPress: () {
                  SignupPageController signupPageController =
                      Get.put(SignupPageController());

                  signupPageController.userId.text = "";
                  signupPageController.email.text = "";
                  signupPageController.phone.text = "";
                  signupPageController.password.text = "";
                  signupPageController.confirmPassword.text = "";

                  signupPageController.userIdErr.value = "";
                  signupPageController.mailErr.value = "";
                  signupPageController.phoneErr.value = "";
                  signupPageController.passwordErr.value = "";
                  signupPageController.confirmPasswordErr.value = "";
                  Get.to(() => SignupScreen());
                },
              ),
              SizedBox(
                height: getHeight(18),
              ),
              Bouncing(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color(0xFF61B3FF),
                    ),
                  ),
                  width: getWidth(double.infinity),
                  height: getHeight(48),
                  alignment: Alignment.center,
                  child: Text('login'.tr),
                ),
                onPress: () {
                  Get.put(LoginPageController()).username.text = "";
                  Get.put(LoginPageController()).password.text = "";
                  Get.put(LoginPageController()).messValidatePassword.value =
                      "";
                  Get.put(LoginPageController()).messValidateUsername.value =
                      "";
                  Get.to(() => LoginPageScreen());
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
