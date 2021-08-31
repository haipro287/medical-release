import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/notification/notification_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/detail_history_page.dart';

class HomePageController extends GetxController {
  PageController pageController =
      PageController(initialPage: 0, keepPage: false);
  var currentPage = 0.obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    NotificationController notificationController =
        Get.put(NotificationController());
    super.onInit();
  }

  void onChangeTab(int value) {
    currentPage.value = value;
    pageController
      ..animateToPage(
        value,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
  }

  Future<void> backgroundHandler(RemoteMessage message) async {
    var item = await Get.put(NotificationController())
        .getRequest(id: message.data["id"]);
    Get.put(ShareHistoryController()).itemSelected.value = item;
    Get.to(() => DetailHistoryPage());
  }
}
