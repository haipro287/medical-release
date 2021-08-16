import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/home_page/home_page_controller.dart';
import 'package:medical_chain_mobile_ui/screens/list_service/list_service_screen.dart';
import 'package:medical_chain_mobile_ui/screens/user/user_screen.dart';
import 'package:medical_chain_mobile_ui/widgets/bottom_navigator.dart';

class HomePageScreen extends StatelessWidget {
  HomePageController homePageController = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: bottomNavigator(),
        body: PageView(
          controller: homePageController.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: Text("home".tr),
            ),
            Center(
              child: Text("share".tr),
            ),
            // ListServiceScreen(),
            Center(
              child: Text("view".tr),
            ),
            UserScreen(),
          ],
        ),
      ),
    );
  }
}
