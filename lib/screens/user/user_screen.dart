import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/login_page/login_page_controller.dart';
import 'package:medical_chain_mobile_ui/screens/change_password_page/change_password_page.dart';
import 'package:medical_chain_mobile_ui/screens/login_page/login_welcome_page.dart';
import 'package:medical_chain_mobile_ui/screens/my_account/my_account_screen.dart';
import 'package:medical_chain_mobile_ui/screens/scanQR/scan_QR_screen.dart';
import 'package:medical_chain_mobile_ui/screens/terms_and_conditions/terms_and_conditions.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/web_view.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalController globalController = Get.put(GlobalController());
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
                          Get.to(() => MyAccountScreen());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(56),
                                child: Container(
                                  width: getWidth(56),
                                  height: getWidth(56),
                                  color: Color(0xFFD0E8FF),
                                ),
                              ),
                              SizedBox(
                                width: getWidth(18),
                              ),
                              Text(
                                Get.put(GlobalController())
                                    .user
                                    .value
                                    .name
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
                        onTap: () => {Get.to(() => MyAccountScreen())},
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
                                      Text(
                                        'tac'.tr,
                                        style:
                                            TextStyle(fontSize: getWidth(16)),
                                      )
                                    ],
                                  ),
                                  SvgPicture.asset("assets/images/arrow.svg"),
                                ],
                              ),
                            ],
                          ),
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
                    String? token = await FirebaseMessaging.instance.getToken();
                    print(token.toString());
                    var unSubcribe = await Get.put(LoginPageController())
                        .unSubcribe(token: token.toString());
                    print(unSubcribe);
                    Get.put(GlobalController()).db.deleteFromDisk();
                    Get.offAll(() => LoginWelcomePage());
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
