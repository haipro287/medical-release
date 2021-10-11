import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/edit_my_account_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/my_account_controller.dart';
import 'package:medical_chain_mobile_ui/screens/my_account/edit_my_account_screen.dart';
import 'package:medical_chain_mobile_ui/screens/my_account/my_account_components.dart';
import 'package:medical_chain_mobile_ui/screens/scanQR/scan_QR_screen.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';

class MyAccountScreen extends StatelessWidget {
  GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    MyAccountController myAccountController = Get.put(MyAccountController());

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
                child: Bouncing(
                  onPress: () {
                    Get.to(() => ScanQRScreen());
                  },
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
                Obx(() => Container(
                      height: getHeight(70),
                      width: getWidth(70),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                        shape: BoxShape.circle,
                        color: Color(myAccountController.avatar.value),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(myAccountController.userName,
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
                  child: Obx(() {
                    return Column(
                      children: [
                        myAccountField(
                          myAccountText('name'.trParams()),
                          myAccountText(myAccountController.kanjiName.value),
                        ),
                        myAccountField(
                          myAccountText('alphabetName'.trParams()),
                          myAccountText(myAccountController.katakanaName.value),
                        ),
                        myAccountField(
                          myAccountText('dob'.trParams()),
                          myAccountText(TimeService.dateTimeToString4(
                              myAccountController.dob.value)),
                        ),
                        myAccountField(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myAccountText('email'.trParams()),
                              SizedBox(
                                height: getHeight(5),
                              ),
                              verifiedIcon(myAccountController.emailVerified),
                            ],
                          ),
                          myAccountText(myAccountController.email.value),
                        ),
                        myAccountField(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myAccountText('phoneNumber'.trParams()),
                              SizedBox(
                                height: getHeight(5),
                              ),
                              verifiedIcon(myAccountController.phoneVerified),
                            ],
                          ),
                          myAccountText(myAccountController.phoneNumber.value),
                        ),
                        Row(
                          children: [
                            myAccountText('citizenCode'.trParams()),
                            myAccountText(
                                myAccountController.citizenCode.value),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ],
                    );
                  }),
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
                    onPressed: () {
                      Get.put(EditMyAccountController()).signup.value = false;
                      Get.put(EditMyAccountController()).avatar.value =
                          myAccountController.avatar.value;
                      Get.put(EditMyAccountController()).kanjiName.text =
                          myAccountController.kanjiName.value;
                      Get.put(EditMyAccountController()).katakanaName.text =
                          myAccountController.katakanaName.value;
                      Get.put(EditMyAccountController()).dob.text =
                          TimeService.dateTimeToString4(
                              myAccountController.dob.value);
                      Get.put(EditMyAccountController()).email.text =
                          myAccountController.email.value;
                      Get.put(EditMyAccountController()).phone.text =
                          myAccountController.phoneNumber.value;
                      Get.put(EditMyAccountController()).citizenCode.text =
                          myAccountController.citizenCode.value;
                      Get.to(() => EditMyAccountScreen());
                    },
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
