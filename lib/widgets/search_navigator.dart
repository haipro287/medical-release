import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/searchUserController/search_user_controller.dart';
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
