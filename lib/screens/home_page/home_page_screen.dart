import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/home_page/home_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/privacy/privacy_controller.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_tab_screen.dart';
import 'package:medical_chain_mobile_ui/screens/user/user_screen.dart';
import 'package:medical_chain_mobile_ui/widgets/bottom_navigator.dart';

class HomePageScreen extends StatelessWidget {
  HomePageController homePageController = Get.put(HomePageController());
  PrivacyController privacyController = Get.put(PrivacyController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: bottomNavigator(),
          body: PageView(
            controller: homePageController.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomePageTabScreen(),
              Center(
                child: Text("share".tr),
              ),
              Center(
                child: Text("view".tr),
              ),
              UserScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
