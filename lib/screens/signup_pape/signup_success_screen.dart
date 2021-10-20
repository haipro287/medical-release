import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/edit_my_account_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/my_account_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/signup_page/signup_page_controller.dart';
import 'package:medical_chain_mobile_ui/screens/my_account/edit_my_account_screen.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';

class SignupSuccessScreen extends StatelessWidget {
  bool? isLogin;
  SignupSuccessScreen({this.isLogin});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var signupController = Get.put(SignupPageController());
        var editMyAccountController = Get.put(EditMyAccountController());
        editMyAccountController.signup.value = true;
        editMyAccountController.email.text = signupController.email.text;
        editMyAccountController.phone.text = signupController.phone.text;
        editMyAccountController.avatar.value = 1;

        Get.to(() => EditMyAccountScreen());
        return true;
      },
      child: Material(
        child: Stack(
          children: [
            Container(
              height: screenHeight(),
              width: screenWidth(),
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: getHeight(410),
                  ),
                  Text(
                    "accountConfirm".tr,
                    style: TextStyle(
                      color: Color(0xFF2F3842),
                      fontSize: getWidth(22),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: getHeight(27),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: getWidth(40),
                      right: getWidth(40),
                    ),
                    child: Text(
                      "accountConfirmMessage".tr,
                      style: TextStyle(fontSize: getWidth(17)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: getHeight(170),
                  ),
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
                        "next".tr,
                        style: TextStyle(
                          fontSize: getWidth(17),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onPress: () {
                      var signupController = Get.put(SignupPageController());
                      var editMyAccountController =
                          Get.put(EditMyAccountController());
                      editMyAccountController.signup.value = true;
                      editMyAccountController.email.text =
                          signupController.email.text;
                      editMyAccountController.phone.text =
                          signupController.phone.text;
                      editMyAccountController.avatar.value =
                          MyAccountController.avatarList[1];

                      Get.to(() => EditMyAccountScreen());
                    },
                  )
                ],
              ),
            ),
            Container(
              height: getHeight(380),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/my_account_background.png'),
                ),
              ),
            ),
            Container(
              height: getHeight(380),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/images/confirm.svg',
                width: getWidth(120),
                height: getHeight(120),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
