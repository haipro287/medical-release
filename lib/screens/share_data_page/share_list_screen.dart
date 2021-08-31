import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/searchUserController/search_user_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_list_page/share_list_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/screens/contact_page/user_saved_screen.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';
import 'package:medical_chain_mobile_ui/widgets/search_navigator.dart';
import 'package:medical_chain_mobile_ui/widgets/text_box.dart';

class ShareListScreen extends StatelessWidget {
  ShareListController shareListController = Get.put(ShareListController());
  SearchUserController searchUserController = Get.put(SearchUserController());
  UserSearchController userSearchController = Get.put(UserSearchController());
  GlobalController globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
        context,
        globalController.sharingStatus.value == "SENT_DATA"
            ? "shareListScreenTitle".tr
            : "sendRequestScreenTitle".tr,
        null,
        true,
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
                child: ListView(
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
                                customBoxHeader(
                                    globalController.sharingStatus.value ==
                                            "SENT_DATA"
                                        ? "chooseUserToSent".tr
                                        : "chooseUserToRequest".tr),
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
                                                  color: Color(0xFFF2F3F7),
                                                  width: getHeight(2),
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
                                                        e["secondaryName"] != ""
                                                            ? e["secondaryName"]
                                                            : getHintText(e),
                                                        style: TextStyle(
                                                          fontSize:
                                                              getWidth(17),
                                                        ),
                                                      ),
                                                      Text(
                                                        e["secondaryUsername"] ??
                                                            "Unknown",
                                                        style: TextStyle(
                                                            fontSize:
                                                                getWidth(13),
                                                            color: Color(
                                                                0xFF838AA2)),
                                                      )
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
                      hintText: "searchById".tr,
                      textEditingController: userSearchController.searchInput,
                      onSearch: userSearchController.search,
                    ),
                    Obx(
                      () => userSearchController.userData["id"] == "NullID"
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
        Obx(
          () => searchUserController.currentPage == 0
              ? Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    bottom: getHeight(12),
                    left: getWidth(16),
                    right: getWidth(16),
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
                        userSearchController.userData.value = userData;
                        userSearchController.isEditing.value = false;
                        print("userDataOfSharing: " + userData.toString());
                        Get.to(() => UserSavedScreen());
                      }
                    },
                    child: Text(
                      'next'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getWidth(13),
                      ),
                    ),
                  ),
                )
              : Container(),
        ),
      ]),
    );
  }
}
