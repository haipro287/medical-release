import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medical_chain_mobile_ui/controllers/forgot_password_page/forgot_password_controller.dart';
import 'package:medical_chain_mobile_ui/screens/forgot_password/forgot_password_otp_screen.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';

class ForgotPasswordScreen extends StatelessWidget {
  Text errText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: getWidth(13),
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ForgotPasswordController forgotPasswordController =
        Get.put(ForgotPasswordController());

    return Scaffold(
        appBar: appBar(context, "resetPassword".tr),
        body: Container(
          height: double.infinity,
          margin: EdgeInsets.only(
            left: getWidth(25),
            right: getWidth(27),
          ),
          child: Column(
            children: [
              SizedBox(
                height: getHeight(31),
              ),
              Text(
                "resetPasswordMess1".tr,
                style: TextStyle(
                  fontSize: getWidth(17),
                ),
              ),
              Text(
                "resetPasswordMess2".tr,
                style: TextStyle(
                  fontSize: getWidth(17),
                ),
              ),
              SizedBox(
                height: getHeight(19),
              ),
              inputOnChange(
                context,
                hintText: "email".tr,
                textEditingController: forgotPasswordController.email,
                function: () => {forgotPasswordController.activeButton()},
              ),
              SizedBox(
                height: getHeight(12),
              ),
              Obx(() {
                return Container(
                    alignment: Alignment.centerLeft,
                    child: forgotPasswordController.errMess.value != ""
                        ? errText(forgotPasswordController.errMess.value)
                        : Container());
              }),
              SizedBox(
                height: getHeight(12),
              ),
              Obx(() {
                bool active = forgotPasswordController.buttonActive.value;
                return Bouncing(
                  child: Container(
                    alignment: Alignment.center,
                    height: getHeight(48),
                    width: getWidth(343),
                    decoration: BoxDecoration(
                      color: active ? Color(0xFFD0E8FF) : Color(0xFFE3E3E3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "sentRequestBtn".tr,
                      style: TextStyle(
                        fontSize: getWidth(17),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onPress: () async {
                    if (active) {
                      if (forgotPasswordController.isValid()) {
                        var emailExisted =
                            await forgotPasswordController.checkEmail();

                        if (emailExisted) {
                          Get.to(() => ForgotPasswordOTPScreen());
                        }
                      }
                    }
                  },
                );
              }),
            ],
          ),
        ));
  }
}
