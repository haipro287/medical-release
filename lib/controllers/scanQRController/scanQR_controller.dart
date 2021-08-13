import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanController extends GetxController {
  Barcode? result;
  QRViewController? controller;

  RxInt i = 0xFFD0E8FF.obs;
  var isFlash = false.obs;
  PageController pageController =
      PageController(initialPage: 0, keepPage: false);
  var index = 0.obs;

  void changeTab(int tab) {
    index.value = tab;
    pageController
      ..animateToPage(
        index.value,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
  }
}
