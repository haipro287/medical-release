import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/notification/notification_controller.dart';

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
    await Get.put(NotificationController()).notiAction(message.data["id"]);
  }
}
