import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/home_page/home_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/privacy/privacy_controller.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_tab_screen.dart';
import 'package:medical_chain_mobile_ui/screens/user/user_screen.dart';
import 'package:medical_chain_mobile_ui/widgets/bottom_navigator.dart';

class HomePageScreen extends StatelessWidget {
  HomePageController homePageController = Get.put(HomePageController());
  PrivacyController privacyController = Get.put(PrivacyController());
  bool isBack = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isBack == false) {
          isBack = true;
          Future.delayed(Duration(seconds: 3), () {
            isBack = false;
          });
          return false;
        } else {
          exit(0);
        }
      },
      child: Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: bottomNavigator(),
          body: PageView(
            controller: Get.put(GlobalController()).pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomePageTabScreen(),
              UserScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
