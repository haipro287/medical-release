import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/change_password_page/change_password_controller.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';

class ChangePasswordPageScreen extends StatelessWidget {
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "change_password".tr),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(
          left: getWidth(16),
          right: getWidth(16),
          top: getHeight(62),
        ),
        child: Column(
          children: [
            Obx(
              () => inputPasswordWithBorder(
                context,
                changePasswordController.password,
                "oldPassword".tr,
                changePasswordController.isHidePassword.value,
                changePasswordController.changeHidePassword,
                changePasswordController.focusPassword,
                changePasswordController.errPassword.value,
              ),
            ),
            Obx(
              () => inputPasswordWithBorder(
                context,
                changePasswordController.newPassword,
                "newPassword".tr,
                changePasswordController.isHideNewPassword.value,
                changePasswordController.changeHideNewPassword,
                changePasswordController.focusNewPassword,
                changePasswordController.errNewPassword.value,
              ),
            ),
            Obx(
              () => inputPasswordWithBorder(
                context,
                changePasswordController.confirmPassword,
                "confirmNewPassword".tr,
                changePasswordController.isHideConfirmPassword.value,
                changePasswordController.changeHideConfirmPassword,
                changePasswordController.focusConfirmPassword,
                changePasswordController.errConfirmPassword.value,
              ),
            ),
            SizedBox(
              height: getHeight(30),
            ),
            Bouncing(
              child: Container(
                width: getWidth(double.infinity),
                height: getHeight(48),
                color: Color(0xFFD0E8FF),
                alignment: Alignment.center,
                child: Text(
                  'change_password_btn'.tr,
                  style: TextStyle(fontSize: getWidth(17)),
                ),
              ),
              onPress: () async {
                FocusScope.of(context).unfocus();
                changePasswordController.changePassword();
                // bool result = await changePasswordController.changePassword();
                // if (result) {
                // Get.to(() => HomePageScreen());
                // }
              },
            ),
            SizedBox(
              height: getHeight(20),
            ),
            Obx(() => changePasswordController.isSuccess.value
                ? Container(
                    child: Text(
                    "passwordChangeSuccessfully".tr,
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontSize: getWidth(17),
                    ),
                  ))
                : Container()),
          ],
        ),
      ),
    );
  }
}
