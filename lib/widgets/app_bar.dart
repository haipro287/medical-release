import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/scanQRController/scanQR_controller.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_screen.dart';
import 'package:medical_chain_mobile_ui/screens/login_page/login_welcome_page.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

AppBar appBar(
    [BuildContext? context,
    String? title,
    Widget? button,
    bool? backHome,
    bool? backToLogin,
    String? scan]) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Color(0xFF454B52),
      ),
      onPressed: () {
        if (backHome == true) {
          Get.put(GlobalController()).currentPage.value = 0;
          Get.put(GlobalController()).onChangeTab(0);
          Get.offAll(HomePageScreen(), transition: Transition.leftToRight);
        } else if (backToLogin == true) {
          Get.offAll(LoginWelcomePage());
        } else if (scan == "scan") {
          Get.put(QrScanController()).controller!.resumeCamera();
          Get.put(QrScanController()).qr = "";
          Get.back();
        } else
          Get.back();
      },
    ),
    title: Text(
      title ?? '',
      style: TextStyle(
          color: Color(0xFF2F3842),
          fontWeight: FontWeight.w600,
          fontSize: getWidth(20)),
    ),
    centerTitle: true,
    actions: button == null
        ? []
        : [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: button,
            ),
          ],
  );
}

AppBar appBarWithButton(
    [BuildContext? context, String? title, Widget? button]) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Color(0xFF454B52),
      ),
      onPressed: () {
        Get.back();
      },
    ),
    title: Text(
      title ?? '',
      style: TextStyle(
          color: Color(0xFF2F3842),
          fontWeight: FontWeight.w600,
          fontSize: getWidth(20)),
    ),
    centerTitle: true,
    actions: button == null
        ? []
        : [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 20),
              child: button,
            ),
          ],
  );
}
