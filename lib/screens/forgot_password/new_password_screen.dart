import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/forgot_password_page/forgot_password_controller.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';
import 'package:medical_chain_mobile_ui/widgets/dialog.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';

class NewPasswordScreen extends StatelessWidget {
  ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "resetPassword".tr),
      body: Container(
        height: double.infinity,
        margin: EdgeInsets.only(
          left: getWidth(16),
          right: getWidth(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getHeight(50),
            ),
            Obx(() {
              return inputPasswordSignup(
                  context,
                  forgotPasswordController.password,
                  "newPassword".tr,
                  forgotPasswordController.passwordIsHide.value,
                  forgotPasswordController.changeHidePassword,
                  false,
                  forgotPasswordController.passwordErr.value != "",
                  onchange: () {
                forgotPasswordController.passwordErr.value == "";
              });
            }),
            SizedBox(
              height: getHeight(5),
            ),
            Obx(() {
              return forgotPasswordController.passwordErr.value == ""
                  ? Container()
                  : Text(
                      forgotPasswordController.passwordErr.value,
                      style: TextStyle(
                        fontSize: getWidth(13),
                        color: Colors.red,
                      ),
                    );
            }),
            SizedBox(
              height: getHeight(12),
            ),
            Obx(() {
              return inputPasswordSignup(
                  context,
                  forgotPasswordController.confirmPassword,
                  "再入力パスワード".tr,
                  forgotPasswordController.confirmPasswordIsHide.value,
                  forgotPasswordController.changeHideConfirmPassword,
                  false,
                  forgotPasswordController.passwordConfirmErr.value != "",
                  onchange: () {
                forgotPasswordController.passwordConfirmErr.value == "";
              });
            }),
            SizedBox(
              height: getHeight(5),
            ),
            Obx(() {
              return forgotPasswordController.passwordConfirmErr.value == ""
                  ? Container()
                  : Text(
                      forgotPasswordController.passwordConfirmErr.value,
                      style: TextStyle(
                        fontSize: getWidth(13),
                        color: Colors.red,
                      ),
                    );
            }),
            SizedBox(height: getHeight(173)),
            Bouncing(
              child: Container(
                alignment: Alignment.center,
                height: getHeight(48),
                width: getWidth(343),
                decoration: BoxDecoration(
                  color: Color(0xFFD0E8FF),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "再設定",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: getWidth(17),
                  ),
                ),
              ),
              onPress: () async {
                if (forgotPasswordController.isPasswordValid()) {
                  var success =
                      await forgotPasswordController.forgotPasswordChange();
                  if (success) {
                    CustomDialog(context, "RESET_PASSWORD").show();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
