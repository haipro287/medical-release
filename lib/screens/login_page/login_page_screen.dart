import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/login_page/login_page_controller.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_screen.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';

class LoginPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginPageController loginController = Get.put(LoginPageController());
    return Scaffold(
      appBar: appBar(context, "ログイン"),
      backgroundColor: Colors.white,
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
              hintText: "ログインID",
              textEditingController: loginController.username,
            ),
            SizedBox(
              height: getHeight(40),
            ),
            Obx(
              () => inputPassword(
                  context,
                  loginController.password,
                  "パスワード",
                  loginController.isHidePassword.value,
                  loginController.changeHidePassword),
            ),
            // Obx(() {
            //   return AnimatedSwitcher(
            //     duration: Duration(milliseconds: 500),
            //     child: loginController.messValidateUsername.value == ""
            //         ? SizedBox(
            //             height: getHeight(50),
            //           )
            //         : Container(
            //             height: getHeight(50),
            //             child: Center(
            //               child: Text(
            //                 loginController.messValidateUsername.value,
            //                 style: TextStyle(
            //                     fontSize: getWidth(14),
            //                     color: Colors.red),
            //               ),
            //             ),
            //           ),
            //   );
            // }),
            SizedBox(
              height: getHeight(21),
            ),
            InkWell(
              child: Text("パスワードをお忘れですか。"),
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
                color: Color(0xFF61B3FF),
                alignment: Alignment.center,
                child: Text('ログイン'),
              ),
              onPress: () async {
                bool result = await loginController.login(context);
                if (result) {
                  Get.to(() => HomePageScreen());
                }
              },
            ),
            SizedBox(
              height: getHeight(30),
            ),
            InkWell(
              child: Text("次へ"),
              onTap: () {
                print('signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
