import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                                    "※ユーザーIDは、一旦登録してしまうと変更できません。",
                                  ),
                                  guideText(
                                      "※ユーザーIDには、半角英数字のみを使用する事ができます。 （記号、スペースは使用する事ができません） "),
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
                                    "※メールアドレスには、半角英数字のみ登録できます。",
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
                                    "※電話番号は、半角数字のみ登録できます。",
                                  ),
                                  guideText(
                                    "※ハイフン、スペース等を入れずに、数字のみ入力して下さい。",
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
                                    "※半角英数字、記号を混在させて、8文字以上、32文字以内で登録を実施して下さい。",
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
                      var checkAccount =
                          await signupPageController.checkAccount();
                      if (checkAccount) {
                        showDialog(
                            context: Get.context!,
                            barrierColor: Colors.black38,
                            builder: (builder) {
                              return Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        getWidth(5),
                                      ),
                                    ),
                                    child: Material(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        padding: EdgeInsets.all(getWidth(18)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/question-icon.svg",
                                              width: getWidth(56),
                                              height: getWidth(56),
                                            ),
                                            SizedBox(
                                              height: getHeight(26),
                                            ),
                                            Text(
                                              "email_alert".tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: getWidth(17)),
                                            ),
                                            SizedBox(
                                              height: getHeight(40),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Bouncing(
                                                    child: Container(
                                                      width: getWidth(145),
                                                      height: getHeight(50),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFE9E9E9),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          getWidth(4),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "back".tr,
                                                          style: TextStyle(
                                                            fontSize:
                                                                getWidth(17),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onPress: () {
                                                      Get.back();
                                                    }),
                                                Bouncing(
                                                    child: Container(
                                                      width: getWidth(145),
                                                      height: getHeight(50),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFD0E8FF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          getWidth(4),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "next".tr,
                                                          style: TextStyle(
                                                            fontSize:
                                                                getWidth(17),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onPress: () async {
                                                      var res =
                                                          await signupPageController
                                                              .signup();

                                                      if (signupPageController
                                                              .signupError
                                                              .value ==
                                                          "") {
                                                        Get.back();
                                                        Get.to(() =>
                                                            ConfirmSignupScreen(
                                                                type:
                                                                    "signup"));
                                                      } else
                                                        Get.back();
                                                    }),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
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
