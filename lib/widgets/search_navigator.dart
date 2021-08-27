import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/searchUserController/search_user_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';

Container searchNavigator() {
  SearchUserController searchUserController = Get.put(SearchUserController());

  return Container(
    height: getHeight(80),
    color: Colors.white,
    margin: EdgeInsets.only(
      right: getWidth(16),
      left: getWidth(16),
    ),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() {
                    return Bouncing(
                      onPress: () {
                        searchUserController.onChangeTab(0);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: getHeight(36),
                        width: getWidth(171.5),
                        color: searchUserController.currentPage.value == 0
                            ? Color(0xFF61B3FF)
                            : Color(0xFFEFF0F4),
                        child: Text(
                          '連携先',
                          style: TextStyle(
                              fontSize: getWidth(12),
                              color: searchUserController.currentPage.value == 0
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Bouncing(
                      onPress: () {
                        searchUserController.onChangeTab(1);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: getHeight(36),
                          width: getWidth(171.5),
                          color: searchUserController.currentPage.value == 1
                              ? Color(0xFF61B3FF)
                              : Color(0xFFEFF0F4),
                          child: Text(
                            '未連携ユーザー',
                            style: TextStyle(
                                fontSize: getWidth(12),
                                color:
                                    searchUserController.currentPage.value == 1
                                        ? Colors.white
                                        : Colors.black),
                          )),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Container sharingHistoryNavigator({required controller}) {
  return Container(
    color: Colors.white,
    margin: EdgeInsets.only(
      right: getWidth(16),
      left: getWidth(16),
    ),
    padding: EdgeInsets.only(
      top: getHeight(20),
    ),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customObx(
                      controller: controller,
                      tabIndex: 0,
                      title: '全部'),
                  customObx(
                      controller: controller,
                      tabIndex: 1,
                      title: '共有中'),
                  customObx(
                      controller: controller,
                      tabIndex: 2,
                      title: '共有中止'),
                  customObx(
                      controller: controller,
                      tabIndex: 3,
                      title: '検討中 '),
                  customObx(
                      controller: controller,
                      tabIndex: 4,
                      title: '拒否'),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Obx customObx({
  required controller,
  required int tabIndex,
  required String title,
}) {
  return Obx(() {
    return Bouncing(
      onPress: () {
        controller.onChangeTab(tabIndex);
        print(tabIndex);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          bottom: getHeight(10),
        ),
        height: getHeight(36),
        decoration: controller.currentPage.value == tabIndex ? BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.blue,
              width: getHeight(3),
            ),
          ) ,
        ) : BoxDecoration(),
        child: Text(
          title,
          style: TextStyle(
              fontSize: getWidth(13),
              color: controller.currentPage.value == tabIndex
                  ? Colors.blue
                  : Colors.black),
        ),
      ),
    );
  });
}
