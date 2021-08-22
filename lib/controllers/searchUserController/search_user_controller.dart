import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/share_list_page/share_list_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';

class SearchUserController extends GetxController {
  PageController pageController =
      PageController(initialPage: 0, keepPage: false);

  var currentPage = 0.obs;

  void onChangeTab(int value) {
    currentPage.value = value;
    Get.put(ShareListController()).searchInput1.clear();
    Get.put(UserSearchController()).searchInput.clear();
    pageController
      ..animateToPage(
        value,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
  }
}
