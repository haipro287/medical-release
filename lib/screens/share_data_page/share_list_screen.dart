import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/searchUserController/search_user_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_list_page/share_list_controller.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';
import 'package:medical_chain_mobile_ui/widgets/search_navigator.dart';

class ShareListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShareListController shareListController = Get.put(ShareListController());
    SearchUserController searchUserController = Get.put(SearchUserController());
    return Scaffold(
      appBar: appBar(
        context,
        "リクエスト送信先選択",
      ),
      backgroundColor: Colors.white,
      body: Column(children: [
        searchNavigator(),
        Expanded(
          child: PageView(
            controller: searchUserController.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    userInputSearch(
                      context,
                      hintText: "searchInput".tr,
                      textEditingController: shareListController.searchInput1,
                      onSearch: shareListController.search,
                    ),
                    Obx(
                      () => shareListController.userData["id"] == "NullID"
                          ? Column(
                              children: [
                                SizedBox(
                                  height: getHeight(41.15),
                                ),
                                Container(
                                  child: SvgPicture.asset(
                                      "assets/images/no-result.svg"),
                                ),
                                SizedBox(
                                  height: getHeight(33.3),
                                ),
                                Text("userNotFound".tr),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: getHeight(18),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius:
                                        BorderRadius.circular(getHeight(4)),
                                    border: Border.all(
                                      color: Color(0xF2F3F7F2),
                                      width: getHeight(1),
                                    ),
                                  ),
                                  height: getHeight(56),
                                  child: Row(
                                    children: [
                                      SizedBox(width: getWidth(15)),
                                      Text(
                                        "送信先を選択してください。",
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: getWidth(15),
                                    right: getWidth(15),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xF2F3F7F2),
                                        width: getHeight(3),
                                      ),
                                    ),
                                  ),
                                  height: getHeight(78),
                                  child: ListView(
                                    children: List.generate(
                                      10,
                                      (index) => Container(
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: true,
                                              groupValue: false,
                                              onChanged: (var a) {},
                                            ),
                                            SvgPicture.asset(
                                                "assets/images/avatar.svg"),
                                            SizedBox(width: getWidth(15)),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "秋原新一 (Akihara Shinichi)"),
                                                  Text("akiharashinichi1"),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    userInputSearch(
                      context,
                      hintText: "userId".tr,
                      textEditingController: shareListController.searchInput2,
                      onSearch: shareListController.searchById,
                    ),
                    Obx(
                      () => shareListController.userData["id"] == "NullID"
                          ? Column(
                              children: [
                                SizedBox(
                                  height: getHeight(41.15),
                                ),
                                Container(
                                  child: SvgPicture.asset(
                                      "assets/images/no-result.svg"),
                                ),
                                SizedBox(
                                  height: getHeight(33.3),
                                ),
                                Text("userNotFound".tr),
                              ],
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
