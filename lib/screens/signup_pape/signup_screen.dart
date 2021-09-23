import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/signup_page/signup_page_controller.dart';
import 'package:medical_chain_mobile_ui/screens/confirm_signup/confirm_signup_screen.dart';
import 'package:medical_chain_mobile_ui/screens/login_page/login_page_screen.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  Text guideText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: getWidth(13),
      ),
    );
  }

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
    SignupPageController signupPageController = Get.put(SignupPageController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context, "新規アカウント作成"),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        reverse: true,
        child: Container(
            margin: EdgeInsets.only(
                top: getHeight(40), left: getWidth(16), right: getWidth(16)),
            // height: double.infinity,
            child: Column(
              children: [
                Focus(
                  onFocusChange: (focus) {
                    signupPageController.userIdGuide.value = focus;
                  },
                  child: Obx(() {
                    return inputSignup(
                      context,
                      hintText: "userId".tr,
                      textEditingController: signupPageController.userId,
                      focus: signupPageController.userIdGuide.value,
                      err: signupPageController.userIdErr.value != "",
                    );
                  }),
                ),
                Obx(() {
                  return Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: getHeight(5)),
                    child: signupPageController.userIdErr.value != ""
                        ? errText(signupPageController.userIdErr.value)
                        : signupPageController.userIdGuide.value
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  guideText(
                                    "※ユーザーIDは登録後、変更できません。",
                                  ),
                                  guideText("※半角英数字"),
                                  guideText("※記号、スペースはご使用いただけません。"),
                                ],
                              )
                            : Container(),
                  );
                }),
                SizedBox(
                  height: getHeight(12),
                ),
                Focus(
                  onFocusChange: (focus) {
                    signupPageController.mailGuide.value = focus;
                  },
                  child: Obx(() {
                    return inputSignup(
                      context,
                      hintText: "email".tr,
                      textEditingController: signupPageController.email,
                      focus: signupPageController.mailGuide.value,
                      err: signupPageController.mailErr.value != "",
                    );
                  }),
                ),
                Obx(() {
                  return Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: getHeight(5)),
                    child: signupPageController.mailErr.value != ""
                        ? errText(signupPageController.mailErr.value)
                        : signupPageController.mailGuide.value
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  guideText(
                                    "※半角英数字",
                                  ),
                                ],
                              )
                            : Container(),
                  );
                }),
                SizedBox(
                  height: getHeight(12),
                ),
                Focus(
                  onFocusChange: (focus) {
                    signupPageController.phoneGuide.value = focus;
                  },
                  child: Obx(() {
                    return inputSignup(
                      context,
                      hintText: "phoneNumber".tr,
                      textEditingController: signupPageController.phone,
                      focus: signupPageController.phoneGuide.value,
                      err: signupPageController.phoneErr.value != "",
                    );
                  }),
                ),
                Obx(() {
                  return Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: getHeight(5)),
                    child: signupPageController.phoneErr.value != ""
                        ? errText(signupPageController.phoneErr.value)
                        : signupPageController.phoneGuide.value
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  guideText(
                                    "※半角数字",
                                  ),
                                  guideText(
                                    "※ハイフンは入れません。",
                                  ),
                                ],
                              )
                            : Container(),
                  );
                }),
                SizedBox(
                  height: getHeight(12),
                ),
                Focus(
                  onFocusChange: (focus) {
                    signupPageController.passwordGuide.value = focus;
                  },
                  child: Obx(() {
                    return inputPasswordSignup(
                      context,
                      signupPageController.password,
                      "password".tr,
                      signupPageController.passwordIsHide.value,
                      signupPageController.changeHidePassword,
                      signupPageController.passwordGuide.value,
                      signupPageController.passwordErr.value != "",
                    );
                  }),
                ),
                Obx(() {
                  return Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: getHeight(5)),
                    child: signupPageController.passwordErr.value != ""
                        ? errText(signupPageController.passwordErr.value)
                        : signupPageController.passwordGuide.value
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  guideText(
                                    "※半角英数記号で8～32文字以内",
                                  ),
                                  guideText(
                                    "※英字、数字、記号のうち2種類以上を混在させてください。",
                                  ),
                                ],
                              )
                            : Container(),
                  );
                }),
                SizedBox(
                  height: getHeight(12),
                ),
                Focus(
                  onFocusChange: (focus) {
                    signupPageController.confirmPasswordFocus.value = focus;
                  },
                  child: Obx(() {
                    return inputPasswordSignup(
                      context,
                      signupPageController.confirmPassword,
                      "confirmPassword".tr,
                      signupPageController.confirmPasswordIsHide.value,
                      signupPageController.changeHideConfirmPassword,
                      signupPageController.confirmPasswordFocus.value,
                      signupPageController.confirmPasswordErr.value != "",
                    );
                  }),
                ),
                Obx(() {
                  return Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: getHeight(5)),
                    child:
                        errText(signupPageController.confirmPasswordErr.value),
                  );
                }),
                SizedBox(
                  height: getHeight(20),
                ),
                RichText(
                  text: TextSpan(
                    text: "登録することで、",
                    style: TextStyle(
                      fontSize: getWidth(17),
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "利用規約",
                        style: TextStyle(
                          color: Color(0xFF74BDFF),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("term of service");
                          },
                      ),
                      TextSpan(
                        text: "と",
                      ),
                      TextSpan(
                        text: "プライバシーポリシー",
                        style: TextStyle(
                          color: Color(0xFF74BDFF),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("privacy policy");
                          },
                      ),
                      TextSpan(
                        text: "に同意したものとみなされます。",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(108),
                ),
                Bouncing(
                  child: Container(
                    alignment: Alignment.center,
                    width: getWidth(343),
                    height: getHeight(48),
                    decoration: BoxDecoration(
                      color: Color(0xFFD0E8FF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'next'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: getWidth(17),
                      ),
                    ),
                  ),
                  onPress: () async {
                    FocusManager.instance.primaryFocus?.unfocus();

                    if (signupPageController.isValid()) {
                      var res = await signupPageController.signup();

                      if (signupPageController.signupError.value == "") {
                        Get.to(() => ConfirmSignupScreen(type: "signup"));
                      }
                    }
                  },
                ),
                SizedBox(
                  height: getHeight(30),
                ),
                Bouncing(
                  onPress: () {
                    Get.to(() => LoginPageScreen());
                  },
                  child: Text(
                    "登録完了？ログイン",
                    style: TextStyle(
                      fontSize: getWidth(17),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(20),
                )
              ],
            )),
      ),
    );
  }
}
