import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/home_page/home_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/edit_my_account_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/my_account_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/otp_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/signup_page/signup_page_controller.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_screen.dart';
import 'package:medical_chain_mobile_ui/screens/signup_pape/signup_success_screen.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ConfirmSignupScreen extends StatelessWidget {
  String? type;
  SignupPageController signupPageController = Get.put(SignupPageController());
  OTPController otpController = Get.put(OTPController());
  ConfirmSignupScreen({this.type});

  @override
  Widget build(BuildContext context) {
    EditMyAccountController editMyAccountController =
        Get.put(EditMyAccountController());
    signupPageController.otp.text = "";

    return Scaffold(
        appBar: appBar(
            context,
            editMyAccountController.signup.value
                ? "confirmSignup".tr
                : "confirmEmail".tr),
        body: Container(
          height: double.infinity,
          margin: EdgeInsets.only(
            left: getWidth(16),
            right: getWidth(16),
          ),
          child: Column(
            children: [
              SizedBox(
                height: getHeight(62),
              ),
              RichText(
                text: TextSpan(
                  text: editMyAccountController.signup.value
                      ? signupPageController.email.text
                      : editMyAccountController.email.text,
                  style: TextStyle(
                    color: Color(0xFF2F3842),
                    fontSize: getWidth(17),
                  ),
                  children: [
                    TextSpan(
                      text: "confirmEmailMessage".tr,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(22),
              ),
              Obx(() {
                // bool success = signupPageController.confirmSuccess.value;
                return Container(
                  child: PinCodeTextField(
                    onTextChanged: (text) {
                      signupPageController.confirmButtonActive();
                    },
                    hasError: !signupPageController.confirmSuccess.value,
                    autofocus: false,
                    maxLength: 6,
                    controller: signupPageController.otp,
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
              Obx(() => signupPageController.confirmSuccess.value
                  ? Container()
                  : Container(
                      margin: EdgeInsets.only(
                        top: getHeight(12),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "emailCodeNotMatch".tr,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: getWidth(13),
                        ),
                      ),
                    )),
              SizedBox(
                height: getHeight(26),
              ),
              Countdown(
                controller: otpController.countdownController,
                seconds: 60,
                build: (BuildContext context, double time) {
                  if (time > 0)
                    return Text(
                      "emailResendParam"
                          .trParams({'time': time.toInt().toString()}),
                      style: TextStyle(
                        color: Color(0xFF878C92),
                        fontSize: getWidth(17),
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  else
                    return Bouncing(
                      child: Text(
                        "emailResend".tr,
                        style: TextStyle(
                          color: Color(0xFF2F3842),
                          fontSize: getWidth(17),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPress: () async {
                        if (type == "signup") {
                          var isRequest =
                              await signupPageController.getOTPAgain();
                          if (isRequest) {
                            otpController.countdownController.restart();
                          }
                        } else if (type == "signup_edit_mail") {
                          Get.put(SignupPageController()).otpId =
                              Get.put(MyAccountController())
                                  .requestMailOTP(
                                      editMyAccountController.email.text)
                                  .toString();
                          otpController.countdownController.restart();
                        }
                      },
                    );
                },
                interval: Duration(seconds: 1),
              ),
              SizedBox(
                height: getHeight(106),
              ),
              Obx(() {
                bool active = signupPageController.confirmActive.value;

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
                      "confirm".tr,
                      style: TextStyle(
                        fontSize: getWidth(17),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (active) {
                      if (await signupPageController.otpValidate()) {
                        if (editMyAccountController.signup.value) {
                          Get.to(() => SignupSuccessScreen());
                        } else {
                          print(editMyAccountController.kanjiName.text);
                          if (editMyAccountController.changeEmailNotSignUp) {
                            editMyAccountController.changeEmailNotSignUp =
                                false;
                            var info = await Get.put(MyAccountController())
                                .editUserInfo(
                              kanji: editMyAccountController.kanjiName.text,
                              romanji:
                                  editMyAccountController.katakanaName.text,
                              mail: editMyAccountController.email.text,
                              birthday: TimeService.timeToBackEnd(
                                  editMyAccountController.birthday),
                              pid: editMyAccountController.citizenCode.text,
                              phone: editMyAccountController.phone.text,
                              avatar: editMyAccountController.avatar.value,
                            );
                            Get.put(HomePageController()).onChangeTab(0);
                            Get.offAll(() => HomePageScreen());
                          } else {
                            var info = await Get.put(MyAccountController())
                                .editUserInfo(
                              kanji: editMyAccountController.kanjiName.text,
                              romanji:
                                  editMyAccountController.katakanaName.text,
                              mail: editMyAccountController.email.text,
                              birthday: TimeService.timeToBackEnd(
                                  editMyAccountController.birthday),
                              pid: editMyAccountController.citizenCode.text,
                              phone: editMyAccountController.phone.text,
                              avatar: editMyAccountController.avatar.value,
                            );
                            if (Get.put(MyAccountController())
                                    .editError
                                    .value ==
                                "") Get.back();
                          }
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
