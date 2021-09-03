import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/home_page/home_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/login_page/login_page_controller.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_screen.dart';
import 'package:medical_chain_mobile_ui/screens/signup_pape/signup_screen.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';

class LoginPageScreen extends StatelessWidget {
  LoginPageController loginController = Get.put(LoginPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "ログイン"),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.only(
          left: getWidth(16),
          right: getWidth(16),
          top: getHeight(62),
        ),
        child: Column(
          children: [
            inputRegular(
              context,
              hintText: "userId".tr,
              textEditingController: loginController.username,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: getHeight(12),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                "ユーザーID、メールアドレスまたは電話番号",
                style: TextStyle(
                  fontSize: getWidth(13),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Obx(
              () => inputPassword(
                  context,
                  loginController.password,
                  "password".tr,
                  loginController.isHidePassword.value,
                  loginController.changeHidePassword),
            ),
            SizedBox(
              height: getHeight(21),
            ),
            InkWell(
              child: Text("forgotPassword".tr),
              onTap: () {
                print('forgot password');
              },
            ),
            SizedBox(
              height: getHeight(52),
            ),
            Bouncing(
              child: Container(
                width: getWidth(double.infinity),
                height: getHeight(48),
                color: Color(0xFFD0E8FF),
                alignment: Alignment.center,
                child: Text('login'.tr),
              ),
              onPress: () async {
                FocusScope.of(context).unfocus();
                bool result = await loginController.login();
                if (result) {
                  Get.put(HomePageController()).currentPage.value = 0;
                  Get.offAll(() => HomePageScreen());
                }
              },
            ),
            SizedBox(
              height: getHeight(10),
            ),
            Obx(
              () => (loginController.messValidateUsername.value != "" ||
                      loginController.messValidatePassword.value != "")
                  ? InkWell(
                      child: Text(
                        loginController.messValidateUsername.value ==
                                "Error Server"
                            ? "Server crash"
                            : loginController.messValidateUsername.value ==
                                    "User Banned"
                                ? "banned_user_msg".tr
                                : "wrongPass".tr,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      onTap: () {},
                    )
                  : Container(),
            ),
            SizedBox(
              height: getHeight(20),
            ),
            InkWell(
              child: Text("signup".tr),
              onTap: () {
                Get.to(() => SignupScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
