import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/home_page/home_page_controller.dart';
import 'package:medical_chain_mobile_ui/screens/scanQR/scan_QR_screen.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';

Container bottomNavigator() {
  HomePageController homePageController = Get.put(HomePageController());

  return Container(
    height: getHeight(80),
    width: double.infinity,
    color: Colors.white,
    child: Stack(
      children: [
        Container(
          height: 1,
          color: Color(0xFFE5E5E5),
        ),
        Align(
          alignment: Alignment.center,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() {
                    return Bouncing(
                      onPress: () {
                        homePageController.onChangeTab(0);
                      },
                      child: Container(
                        color: Colors.white,
                        width: getWidth(60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/home.svg",
                              width: getWidth(24),
                              color: homePageController.currentPage.value == 0
                                  ? Color(0xFF61B3FF)
                                  : Color(0xFF878C92),
                            ),
                            Text(
                              "home".tr,
                              style: TextStyle(
                                  fontSize: getWidth(12),
                                  color:
                                      homePageController.currentPage.value == 0
                                          ? Color(0xFF61B3FF)
                                          : Color(0xFF878C92)),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Bouncing(
                      onPress: () {
                        homePageController.onChangeTab(1);
                      },
                      child: Container(
                        width: getWidth(60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/share.svg",
                              width: getWidth(24),
                              color: homePageController.currentPage.value == 1
                                  ? Color(0xFF61B3FF)
                                  : Color(0xFF878C92),
                            ),
                            Text(
                              "share".tr,
                              style: TextStyle(
                                  fontSize: getWidth(12),
                                  color:
                                      homePageController.currentPage.value == 1
                                          ? Color(0xFF61B3FF)
                                          : Color(0xFF878C92)),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ScanQRScreen());
                    },
                    child: SvgPicture.asset(
                      "assets/images/qr.svg",
                      width: getWidth(45),
                    ),
                  ),
                  Obx(() {
                    return Bouncing(
                      onPress: () {
                        homePageController.onChangeTab(2);
                      },
                      child: Container(
                        width: getWidth(60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/view.svg",
                              width: getWidth(24),
                              color: homePageController.currentPage.value == 2
                                  ? Color(0xFF61B3FF)
                                  : Color(0xFF878C92),
                            ),
                            Text(
                              "view".tr,
                              style: TextStyle(
                                  fontSize: getWidth(12),
                                  color:
                                      homePageController.currentPage.value == 2
                                          ? Color(0xFF61B3FF)
                                          : Color(0xFF878C92)),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Bouncing(
                      onPress: () {
                        homePageController.onChangeTab(3);
                      },
                      child: Container(
                        width: getWidth(65),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/user.svg",
                              width: getWidth(24),
                              color: homePageController.currentPage.value == 3
                                  ? Color(0xFF61B3FF)
                                  : Color(0xFF878C92),
                            ),
                            Text(
                              "user".tr,
                              style: TextStyle(
                                  fontSize: getWidth(12),
                                  color:
                                      homePageController.currentPage.value == 3
                                          ? Color(0xFF61B3FF)
                                          : Color(0xFF878C92)),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
