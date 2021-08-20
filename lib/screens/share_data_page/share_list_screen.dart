import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/searchUserController/search_user_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_list_page/share_list_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/screens/contact_page/user_saved_screen.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';
import 'package:medical_chain_mobile_ui/widgets/search_navigator.dart';

class ShareListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShareListController shareListController = Get.put(ShareListController());
    SearchUserController searchUserController = Get.put(SearchUserController());
    UserSearchController userSearchController = Get.put(UserSearchController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    inputSearchWithQrCode(
                      context,
                      hintText: "searchInput".tr,
                      textEditingController: shareListController.searchInput1,
                      onSearch: shareListController.search,
                    ),
                    Obx(
                      () => shareListController.searchList.length == 0
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
                                    color: Color(0xF2F3F7F2),
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
                                  height: getHeight(442),
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    children: shareListController
                                        .searchList.value
                                        .map(
                                          (e) => Container(
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
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: shareListController
                                                          .userSelected.value !=
                                                      e["secondaryUsername"],
                                                  groupValue: false,
                                                  onChanged: (var a) {
                                                    shareListController
                                                            .userSelected
                                                            .value =
                                                        e["secondaryUsername"] ??
                                                            "";
                                                  },
                                                ),
                                                SvgPicture.asset(
                                                    "assets/images/avatar.svg"),
                                                SizedBox(width: getWidth(15)),
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          e["secondaryUsername"] ??
                                                              ""),
                                                      Text(e["phone"] ??
                                                          "unknown phone number"),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
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
                      textEditingController: userSearchController.searchInput,
                      onSearch: userSearchController.search,
                    ),
                    userSearchController.userData["id"] == "NullID"
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
                  ],
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => searchUserController.currentPage == 0
              ? Container(
                  margin: EdgeInsets.only(
                    bottom: getHeight(12),
                  ),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor:
                          shareListController.userSelected.value != ""
                              ? Color(0xFFD0E8FF)
                              : Color(0xE3E3E3E3),
                      side: BorderSide(
                        color: shareListController.userSelected.value != ""
                            ? Color(0xFFD0E8FF)
                            : Color(0xE3E3E3E3),
                      ),
                      padding: EdgeInsets.only(
                        top: getHeight(14),
                        bottom: getHeight(14),
                        left: getHeight(170),
                        right: getHeight(170),
                      ),
                    ),
                    onPressed: () {
                      print(shareListController.userSelected.value);
                      if (shareListController.userSelected.value != "") {
                        var userData = shareListController.contactList
                            .where((e) =>
                                e["secondaryUsername"] ==
                                shareListController.userSelected.value)
                            .first;
                        userSearchController.userData = userData;
                        userSearchController.isEditing.value = false;
                        print("userDataOfSharing: " + userData.toString());
                        Get.to(() => UserSavedScreen());
                      }
                    },
                    child: Text(
                      'next'.tr,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              : Container(),
        ),
      ]),
    );
  }
}
