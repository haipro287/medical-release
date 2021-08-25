import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ShareHistoryController extends GetxController {
  PageController pageController =
      PageController(initialPage: 0, keepPage: false);

  var currentPage = 0.obs;
  TextEditingController searchInput = TextEditingController();

  var userData = {}.obs;

  var itemSelected = {"status": "sharing"}.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  void search() async {}

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
