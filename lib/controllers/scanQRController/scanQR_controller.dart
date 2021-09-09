import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanController extends GetxController {
  Barcode? result;
  QRViewController? controller;
  String? qr;

  RxInt i = 0xFFD0E8FF.obs;
  var isFlash = false.obs;
  late PageController pageController;
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

  void init(int page) {
    pageController = PageController(initialPage: page, keepPage: false);
    index.value = page;
  }
}
