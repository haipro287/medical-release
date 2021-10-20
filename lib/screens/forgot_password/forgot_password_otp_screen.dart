import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/forgot_password_page/forgot_password_controller.dart';
import 'package:medical_chain_mobile_ui/screens/forgot_password/new_password_screen.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ForgotPasswordOTPScreen extends StatelessWidget {
  ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    // forgotPasswordController.otpController.;
    forgotPasswordController.otp.text = "";
    forgotPasswordController.resetSuccess.value = true;

    return Scaffold(
      appBar: appBar(context, "resetPassword".tr),
      body: Container(
        height: double.infinity,
        margin: EdgeInsets.only(
          left: getWidth(16),
          right: getWidth(16),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getHeight(40),
            ),
            RichText(
              text: TextSpan(
                text: forgotPasswordController.email.text,
                style: TextStyle(
                    color: Color(0xFF2F3842),
                    fontSize: getWidth(17),
                    fontWeight: FontWeight.bold,
                    height: 1.2),
                children: [
                  TextSpan(
                    text: "resetPasswordOTP1".tr,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, height: 1.2),
                  )
                ],
              ),
            ),
            Text(
              "resetPasswordOTP2".tr,
              style: TextStyle(
                  color: Color(0xFF2F3842),
                  fontSize: getWidth(17),
                  height: 1.2),
            ),
            SizedBox(
              height: getHeight(22),
            ),
            Obx(() {
              // bool success = signupPageController.confirmSuccess.value;
              return Container(
                child: PinCodeTextField(
                  onTextChanged: (text) {
                    forgotPasswordController.resetButtonActive();
                  },
                  hasError: !forgotPasswordController.resetSuccess.value,
                  autofocus: false,
                  maxLength: 6,
                  controller: forgotPasswordController.otp,
                  isCupertino: true,
                  pinBoxWidth: (screenWidth() - getWidth(109)) / 6,
                  pinBoxHeight: getHeight(67),
                  defaultBorderColor: Color(0xFFDDDEE2),
                  hasTextBorderColor: Color(0xFFDDDEE2),
                  pinBoxRadius: 4,
                  pinBoxBorderWidth: 1,
                  errorBorderColor: Colors.red,
                  pinTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: getHeight(20),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                  // wrapAlignment: WrapAlignment.spaceEvenly,
                  pinBoxOuterPadding: EdgeInsets.only(left: getWidth(13)),
                ),
              );
            }),
            Obx(() => forgotPasswordController.resetSuccess.value
                ? Container()
                : Container(
                    margin: EdgeInsets.only(
                      top: getHeight(12),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      forgotPasswordController.errMessOTP.value,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: getWidth(13),
                      ),
                    ),
                  )),
            SizedBox(
              height: getHeight(26),
            ),
            GetBuilder<ForgotPasswordController>(
                id: "validateOTP",
                builder: (builder) {
                  return Countdown(
                    controller: forgotPasswordController.otpController,
                    seconds: 60,
                    build: (BuildContext context, double time) {
                      if (time > 0) {
                        return Text(
                          "emailResendParam"
                              .trParams({'time': time.toInt().toString()}),
                          style: TextStyle(
                            color: Color(0xFF878C92),
                            fontSize: getWidth(17),
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      } else
                        return Bouncing(
                          child: Text(
                            "emailResend".tr,
                            style: TextStyle(
                              color: Color(0xFF2F3842),
                              fontSize: getWidth(17),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPress: () {
                            forgotPasswordController.resetOTP();
                          },
                        );
                    },
                    interval: Duration(seconds: 1),
                  );
                }),
            SizedBox(
              height: getHeight(106),
            ),
            Obx(() {
              bool active = forgotPasswordController.resetActive.value;

              return GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  height: getHeight(48),
                  width: getWidth(343),
                  decoration: BoxDecoration(
                    color: active ? Color(0xFFD0E8FF) : Color(0xFFE3E3E3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "next".tr,
                    style: TextStyle(
                      fontSize: getWidth(17),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onTap: () async {
                  if (active) {
                    forgotPasswordController.resetSuccess.value =
                        await forgotPasswordController.checkOTP();
                    if (forgotPasswordController.resetSuccess.value) {
                      Get.to(() => NewPasswordScreen());
                    }
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
