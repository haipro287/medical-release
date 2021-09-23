import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/home_page/home_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/login_page/login_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/edit_my_account_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/my_account_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/signup_page/signup_page_controller.dart';
import 'package:medical_chain_mobile_ui/screens/confirm_signup/confirm_signup_screen.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_screen.dart';
import 'package:medical_chain_mobile_ui/screens/login_page/login_welcome_page.dart';
import 'package:medical_chain_mobile_ui/screens/my_account/my_account_components.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';

class EditMyAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditMyAccountController editMyAccountController =
        Get.put(EditMyAccountController());
    MyAccountController myAccountController = Get.put(MyAccountController());

    return WillPopScope(
      onWillPop: () async {
        print("back");
        if (editMyAccountController.signup.value) {
          print("back");
          Get.offAll(() => (LoginWelcomePage()));
        } else
          Get.back();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(context, 'myAccount'.tr, null, false,
            editMyAccountController.signup.value),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          reverse: true,
          child: Container(
            padding: EdgeInsets.only(
              top: getHeight(26),
              left: getWidth(16),
              right: getWidth(16),
            ),
            // width: double.infinity,
            // height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  return Container(
                    margin: EdgeInsets.only(bottom: getHeight(18)),
                    height: getHeight(100),
                    width: getWidth(100),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                      shape: BoxShape.circle,
                      color: Color(editMyAccountController.avatar.value),
                    ),
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    colorButton(MyAccountController.avatarList[1]),
                    colorButton(MyAccountController.avatarList[2]),
                    colorButton(MyAccountController.avatarList[3]),
                    colorButton(MyAccountController.avatarList[4]),
                  ],
                ),
                SizedBox(
                  height: getHeight(24),
                ),
                Obx(() {
                  var err = editMyAccountController.kanjiErr.value != "";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      inputWithHint(
                        context,
                        hintText: "山田太郎",
                        labelText: 'editName'.tr,
                        initialText: myAccountController.kanjiName.value,
                        textEditingController:
                            editMyAccountController.kanjiName,
                        err: err,
                      ),
                      errText(errMess: editMyAccountController.kanjiErr.value),
                    ],
                  );
                }),
                SizedBox(
                  height: getHeight(12),
                ),
                Obx(() {
                  var err = editMyAccountController.katakanaErr.value != "";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      inputWithHint(context,
                          hintText: "ヤマダイチロウ",
                          labelText: 'editAlphabetName'.tr,
                          initialText: myAccountController.katakanaName.value,
                          textEditingController:
                              editMyAccountController.katakanaName,
                          err: err),
                      errText(
                          errMess: editMyAccountController.katakanaErr.value),
                    ],
                  );
                }),
                SizedBox(
                  height: getHeight(12),
                ),
                inputDate(
                  context,
                  hintText: "山田太郎",
                  labelText: 'dob'.tr,
                  textEditingController: editMyAccountController.dob,
                ),
                SizedBox(
                  height: getHeight(12),
                ),
                inputWithHint(context,
                    hintText: "山田太郎",
                    labelText: 'email'.tr,
                    initialText: myAccountController.email.value,
                    textEditingController: editMyAccountController.email,
                    err: false),
                SizedBox(
                  height: getHeight(12),
                ),
                inputWithHint(context,
                    hintText: "山田太郎",
                    labelText: 'phoneNumber'.tr,
                    initialText: myAccountController.phoneNumber.value,
                    textEditingController: editMyAccountController.phone,
                    err: false),
                SizedBox(
                  height: getHeight(12),
                ),
                Obx(() {
                  var err = editMyAccountController.citizenCodeErr.value != "";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      inputWithHint(context,
                          hintText: "123456789012",
                          labelText: 'citizenCode'.tr,
                          initialText: myAccountController.citizenCode.value,
                          textEditingController:
                              editMyAccountController.citizenCode,
                          err: err),
                      errText(
                          errMess:
                              editMyAccountController.citizenCodeErr.value),
                    ],
                  );
                }),
                SizedBox(
                  height: getHeight(24),
                ),
                Obx(() {
                  return editMyAccountController.signup.value
                      ? Bouncing(
                          child: Container(
                            height: getHeight(48),
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFFD0E8FF),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "save".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: getWidth(17),
                              ),
                            ),
                          ),
                          onPress: () async {
                            if (editMyAccountController.isValid()) {
                              if (myAccountController.email.value !=
                                  editMyAccountController.email.text) {
                                editMyAccountController.signup.value = false;
                                editMyAccountController.changeEmailNotSignUp =
                                    true;
                                LoginPageController loginPageController =
                                    Get.put(LoginPageController());

                                SignupPageController signupController =
                                    Get.put(SignupPageController());

                                loginPageController.username.text =
                                    signupController.userId.text;
                                loginPageController.password.text =
                                    signupController.password.text;

                                var login = await loginPageController.login();
                                Get.put(SignupPageController()).otpId =
                                    myAccountController
                                        .requestMailOTP(
                                            editMyAccountController.email.text)
                                        .toString();
                                Get.off(() => ConfirmSignupScreen(
                                    type: "signup_edit_mail"));
                              } else {
                                print("dsadsa");
                                LoginPageController loginPageController =
                                    Get.put(LoginPageController());

                                SignupPageController signupController =
                                    Get.put(SignupPageController());

                                loginPageController.username.text =
                                    signupController.userId.text;
                                loginPageController.password.text =
                                    signupController.password.text;

                                var login = await loginPageController.login();

                                if (login) {
                                  var info =
                                      await myAccountController.editUserInfo(
                                    kanji:
                                        editMyAccountController.kanjiName.text,
                                    romanji: editMyAccountController
                                        .katakanaName.text,
                                    mail: editMyAccountController.email.text,
                                    birthday: TimeService.timeToBackEnd(
                                        editMyAccountController.birthday),
                                    pid: editMyAccountController
                                        .citizenCode.text,
                                    phone: editMyAccountController.phone.text,
                                    avatar:
                                        editMyAccountController.avatar.value,
                                  );

                                  if (info != null) {
                                    // LoginPageController loginPageController =
                                    //     Get.put(LoginPageController());
                                    //
                                    // SignupPageController signupController =
                                    //     Get.put(SignupPageController());
                                    //
                                    // loginPageController.username.text =
                                    //     signupController.userId.text;
                                    // loginPageController.password.text =
                                    //     signupController.password.text;
                                    //
                                    // var login = await loginPageController.login();
                                    Get.put(HomePageController())
                                        .onChangeTab(0);
                                    Get.offAll(() => HomePageScreen());
                                  }
                                }
                              }
                            }
                          })
                      : Row(
                          children: [
                            Bouncing(
                              child: Container(
                                alignment: Alignment.center,
                                height: getHeight(48),
                                width: getWidth(116),
                                child: myAccountText('cancel'.tr),
                                decoration: BoxDecoration(
                                  color: Color(0xFFE9E9E9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPress: () {
                                Get.back();
                              },
                            ),
                            SizedBox(
                              width: getWidth(8),
                            ),
                            Bouncing(
                              child: Container(
                                alignment: Alignment.center,
                                height: getHeight(48),
                                width: getWidth(219),
                                child: myAccountText('save'.tr),
                                decoration: BoxDecoration(
                                  color: Color(0xFFD0E8FF),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPress: () {
                                if (editMyAccountController.isValid()) {
                                  if (myAccountController.email.value !=
                                      editMyAccountController.email.text) {
                                    editMyAccountController.signup.value =
                                        false;
                                    Get.put(SignupPageController()).otpId =
                                        myAccountController
                                            .requestMailOTP(
                                                editMyAccountController
                                                    .email.text)
                                            .toString();
                                    Get.off(() => ConfirmSignupScreen(
                                        type: "signup_edit_mail"));
                                  } else {
                                    myAccountController.editUserInfo(
                                      kanji: editMyAccountController
                                          .kanjiName.text,
                                      romanji: editMyAccountController
                                          .katakanaName.text,
                                      mail: editMyAccountController.email.text,
                                      birthday: TimeService.timeToBackEnd(
                                          editMyAccountController.birthday),
                                      pid: editMyAccountController
                                          .citizenCode.text,
                                      phone: editMyAccountController.phone.text,
                                      avatar:
                                          editMyAccountController.avatar.value,
                                    );
                                    Get.back();
                                  }
                                }
                              },
                            ),
                          ],
                        );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
