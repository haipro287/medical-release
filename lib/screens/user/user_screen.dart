import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/my_account_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/privacy/privacy_controller.dart';
import 'package:medical_chain_mobile_ui/screens/change_password_page/change_password_page.dart';
import 'package:medical_chain_mobile_ui/screens/my_account/my_account_screen.dart';
import 'package:medical_chain_mobile_ui/screens/scanQR/scan_QR_screen.dart';
import 'package:medical_chain_mobile_ui/screens/terms_and_conditions/terms_and_conditions.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PrivacyController privacyController = Get.put(PrivacyController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(243, 245, 250, 1),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getHeight(36),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.put(MyAccountController()).getUserInfo();
                          Get.to(() => MyAccountScreen());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Obx(() {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(56),
                                  child: Container(
                                    width: getWidth(56),
                                    height: getWidth(56),
                                    color: Color(Get.put(MyAccountController())
                                        .avatar
                                        .value),
                                  ),
                                );
                              }),
                              SizedBox(
                                width: getWidth(18),
                              ),
                              Text(
                                Get.put(GlobalController())
                                    .user
                                    .value
                                    .username
                                    .toString(),
                                style: TextStyle(
                                    fontSize: getWidth(20),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(24),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(16),
                  ),
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(20),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.put(MyAccountController()).getUserInfo();
                          Get.to(() => MyAccountScreen());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: getWidth(24),
                                        height: getWidth(24),
                                        child: SvgPicture.asset(
                                          "assets/images/telegram.svg",
                                          height: getWidth(24),
                                        ),
                                      ),
                                      SizedBox(
                                        width: getWidth(12),
                                      ),
                                      Text(
                                        'my_account'.tr,
                                        style:
                                            TextStyle(fontSize: getWidth(16)),
                                      )
                                    ],
                                  ),
                                  SvgPicture.asset("assets/images/arrow.svg"),
                                ],
                              ),
                              SizedBox(
                                height: getHeight(12),
                              ),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Color(0xFFF8F8F9),
                              ),
                              SizedBox(
                                height: getHeight(12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ScanQRScreen());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: getWidth(24),
                                        height: getWidth(24),
                                        child: SvgPicture.asset(
                                          "assets/images/qrcode.svg",
                                          height: getWidth(24),
                                        ),
                                      ),
                                      SizedBox(
                                        width: getWidth(12),
                                      ),
                                      Text(
                                        'my_qr'.tr,
                                        style:
                                            TextStyle(fontSize: getWidth(16)),
                                      )
                                    ],
                                  ),
                                  SvgPicture.asset("assets/images/arrow.svg"),
                                ],
                              ),
                              SizedBox(
                                height: getHeight(12),
                              ),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Color(0xFFF8F8F9),
                              ),
                              SizedBox(
                                height: getHeight(12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ChangePasswordPageScreen());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: getWidth(24),
                                        height: getWidth(24),
                                        child: SvgPicture.asset(
                                          "assets/images/lock.svg",
                                          height: getWidth(24),
                                        ),
                                      ),
                                      SizedBox(
                                        width: getWidth(12),
                                      ),
                                      Text(
                                        'change_password'.tr,
                                        style:
                                            TextStyle(fontSize: getWidth(16)),
                                      )
                                    ],
                                  ),
                                  SvgPicture.asset("assets/images/arrow.svg"),
                                ],
                              ),
                              SizedBox(
                                height: getHeight(12),
                              ),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Color(0xFFF8F8F9),
                              ),
                              SizedBox(
                                height: getHeight(12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Get.to(
                            () => TermsAndConditionPage(),
                          )
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: getWidth(24),
                                        height: getWidth(24),
                                        child: SvgPicture.asset(
                                          "assets/images/shield.svg",
                                          height: getWidth(24),
                                        ),
                                      ),
                                      SizedBox(
                                        width: getWidth(12),
                                      ),
                                      Container(
                                        width: getWidth(200),
                                        child: Text(
                                          'tac'.tr,
                                          style:
                                              TextStyle(fontSize: getWidth(16)),
                                        ),
                                      )
                                    ],
                                  ),
                                  SvgPicture.asset("assets/images/arrow.svg"),
                                ],
                              ),
                              SizedBox(
                                height: getHeight(12),
                              ),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Color(0xFFF8F8F9),
                              ),
                              SizedBox(
                                height: getHeight(12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: getWidth(24),
                                      height: getWidth(24),
                                      child: SvgPicture.asset(
                                        "assets/images/privacy.svg",
                                        height: getWidth(24),
                                      ),
                                    ),
                                    SizedBox(
                                      width: getWidth(12),
                                    ),
                                    Container(
                                      width: getWidth(200),
                                      child: Text(
                                        'privacy_guide'.tr,
                                        style:
                                            TextStyle(fontSize: getWidth(16)),
                                      ),
                                    )
                                  ],
                                ),
                                Obx(() {
                                  return CupertinoSwitch(
                                    value: privacyController.privacy.value,
                                    onChanged: (bool value) {
                                      privacyController.upPrivacy(value);
                                    },
                                  );
                                })
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(20),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(12),
                ),
                GestureDetector(
                  onTap: () async {
                    showDialog(
                        // barrierDismissible: false,
                        context: context,
                        builder: (builder) {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: MediaQuery.of(context).size.width -
                                  getWidth(32),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    getWidth(6),
                                  ),
                                  color: Colors.white),
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: getHeight(27),
                                    ),
                                    SvgPicture.asset(
                                        "assets/images/logout.svg"),
                                    SizedBox(
                                      height: getHeight(25),
                                    ),
                                    Text(
                                      'alert_logout'.tr,
                                      style: TextStyle(
                                        fontSize: getWidth(17),
                                      ),
                                    ),
                                    SizedBox(
                                      height: getHeight(40),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: getWidth(17),
                                        ),
                                        Expanded(
                                          child: Bouncing(
                                            onPress: () {
                                              Get.back();
                                            },
                                            child: Container(
                                              height: getHeight(48),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  getWidth(4),
                                                ),
                                                color: Color(0xFFE9E9E9),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'logout_cancel'.tr,
                                                  style: TextStyle(
                                                      fontSize: getWidth(17),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: getWidth(17),
                                        ),
                                        Expanded(
                                          child: Bouncing(
                                            onPress: () async {
                                              await privacyController.logout();
                                            },
                                            child: Container(
                                              height: getHeight(48),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  getWidth(4),
                                                ),
                                                color: Color(0xFFEB5757),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'logout_confirm'.tr,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: getWidth(17),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: getWidth(17),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getHeight(30),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: getWidth(16),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getHeight(17),
                        ),
                        Row(
                          children: [
                            Container(
                              width: getWidth(24),
                              height: getWidth(24),
                              child: SvgPicture.asset(
                                "assets/images/log-out.svg",
                                height: getWidth(24),
                              ),
                            ),
                            SizedBox(
                              width: getWidth(12),
                            ),
                            Text(
                              'log_out'.tr,
                              style: TextStyle(fontSize: getWidth(16)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getHeight(17),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
