import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/my_account_controller.dart';
import 'package:medical_chain_mobile_ui/screens/my_account/my_account_components.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';

class MyAccountScreen extends StatelessWidget {
  MyAccountController myAccountController = Get.put(MyAccountController());
  GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: screenHeight(),
          color: Color(0xFFf4FaFF),
        ),
        Container(
          height: getHeight(350),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/my_account_background.png'),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar(
              context,
              "myAccount".trParams(),
              Container(
                padding: EdgeInsets.only(top: 20),
                width: getWidth(30),
                height: getHeight(30),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFABC2D6).withOpacity(0.3),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/qr_button.svg',
                    ),
                  ),
                ),
              )),
          body: Container(
            padding: EdgeInsets.only(top: getHeight(30)),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: getHeight(70),
                  width: getWidth(70),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    ),
                    shape: BoxShape.circle,
                    color: Color(myAccountController.avatar),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(globalController.userName,
                      style: TextStyle(
                        color: Color(0xFF2F3842),
                        fontSize: getWidth(20),
                        fontWeight: FontWeight.w500,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  margin: EdgeInsets.only(
                    top: getHeight(40),
                    left: getWidth(17),
                    right: getWidth(17),
                  ),
                  padding: EdgeInsets.only(
                    top: getHeight(30),
                    left: getWidth(20),
                    right: getWidth(20),
                  ),
                  alignment: Alignment.center,
                  width: getWidth(343),
                  height: getHeight(410),
                  child: Column(
                    children: [
                      myAccountField(
                        myAccountText('name'.trParams()),
                        myAccountText(globalController.fullName),
                      ),
                      myAccountField(
                        myAccountText('alphabetName'.trParams()),
                        myAccountText(globalController.alphabetName),
                      ),
                      myAccountField(
                        myAccountText('dob'.trParams()),
                        myAccountText(globalController.dob),
                      ),
                      myAccountField(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            myAccountText('email'.trParams()),
                            verifiedIcon(myAccountController.emailVerified),
                          ],
                        ),
                        myAccountText(globalController.email),
                      ),
                      myAccountField(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            myAccountText('phoneNumber'.trParams()),
                            verifiedIcon(myAccountController.phoneVerified),
                          ],
                        ),
                        myAccountText(globalController.phoneNumber),
                      ),
                      Row(
                        children: [
                          myAccountText('citizenCode'.trParams()),
                          myAccountText(globalController.citizenCode),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: getHeight(24),
                  ),
                  width: getWidth(343),
                  height: getHeight(48),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xFFD0E8FF),
                      side: BorderSide(
                        color: Color(0xFFD0E8FF),
                      ),
                    ),
                    onPressed: () {},
                    child: myAccountText('edit'.trParams()),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
