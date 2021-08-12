import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  PageController pageController =
      PageController(initialPage: 0, keepPage: false);
  var currentPage = 0.obs;

  void onChangeTab(int value) {
    currentPage.value = value;
    pageController
      ..animateToPage(
        value,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
  }
}
