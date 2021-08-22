import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/share_list_page/share_list_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';

class SearchUserController extends GetxController {
  PageController pageController =
      PageController(initialPage: 0, keepPage: false);

  ShareListController shareListController = Get.put(ShareListController());
  UserSearchController userSearchController = Get.put(UserSearchController());

  var currentPage = 0.obs;

  void onChangeTab(int value) {
    currentPage.value = value;
    shareListController.searchInput1.clear();
    shareListController.search();
    userSearchController.searchInput.clear();
    userSearchController.search();
    pageController
      ..animateToPage(
        value,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
  }
}
