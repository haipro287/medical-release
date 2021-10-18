import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/share_service_list_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/screens/share_data_page/share_confirm_screen.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/text_box.dart';

class ShareListService extends StatelessWidget {
  ShareServiceListController shareServiceListController =
      Get.put(ShareServiceListController());
  UserSearchController userSearchController = Get.put(UserSearchController());
  GlobalController globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
          context,
          globalController.sharingStatus.value == "SENT_DATA"
              ? "shareListServiceTitle".tr
              : "sentRequestServiceTitle".tr),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: getHeight(12)),
        child: Obx(
          () => Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              bottom: getHeight(46),
              left: getWidth(16),
              right: getWidth(16),
            ),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: shareServiceListController.checkList.length > 0
                    ? Color(0xFFD0E8FF)
                    : Color(0xE3E3E3E3),
                side: BorderSide(
                  color: shareServiceListController.checkList.length > 0
                      ? Color(0xFFD0E8FF)
                      : Color(0xE3E3E3E3),
                ),
                padding: EdgeInsets.only(
                  top: getHeight(14),
                  bottom: getHeight(14),
                ),
              ),
              onPressed: () {
                if (shareServiceListController.checkList.length > 0) {
                  Get.to(() => ShareConfirmScreen());
                }
              },
              child: Text(
                'next'.tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Color(0xFFF6F7FB),
        child: Column(
          children: [
            customBoxHeader(globalController.sharingStatus.value == "SENT_DATA"
                ? "chooseServiceToShare".tr
                : "chooseServiceToSentRequest".tr),
            Obx(
              () => Container(
                child: Expanded(
                    flex: 1,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: shareServiceListController.serviceList
                          .map(
                            (e) => (globalController.sharingStatus.value ==
                                    "SENT_DATA")
                                ? Container(
                                    padding: EdgeInsets.only(
                                      left: getWidth(15),
                                      right: getWidth(15),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(0xFFECEFF1),
                                          width: getHeight(1),
                                        ),
                                      ),
                                    ),
                                    height: getHeight(78),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: getWidth(50),
                                          child: e["status"] == ""
                                              ? Checkbox(
                                                  value:
                                                      shareServiceListController
                                                              .checkList
                                                              .where((item) =>
                                                                  item["id"] ==
                                                                  e["id"])
                                                              .length >
                                                          0,
                                                  onChanged: (bool? isCheck) {
                                                    if (isCheck == true) {
                                                      shareServiceListController
                                                          .checkList
                                                          .clear();
                                                      shareServiceListController
                                                          .checkList
                                                          .add(e);
                                                    } else
                                                      shareServiceListController
                                                          .checkList
                                                          .remove(e);
                                                  })
                                              : Container(),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(27),
                                          child: Container(
                                            width: getWidth(27),
                                            height: getWidth(27),
                                            child: e["icon"]
                                                    .toString()
                                                    .contains("http")
                                                ? Image.asset(
                                                    e["icon"].toString(),
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.memory(
                                                    base64Decode(e["icon"]
                                                        .toString()
                                                        .split(",")[1]),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(width: getWidth(15)),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(upperFirstString(e["name"])),
                                              (globalController.sharingStatus
                                                              .value ==
                                                          "SENT_DATA" &&
                                                      e["username"] != null)
                                                  ? Text(
                                                      e["username"],
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF838AA2)),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: getWidth(15)),
                                        e["status"] == "sharing"
                                            ? Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: getWidth(12),
                                                  vertical: getHeight(3),
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    getWidth(2),
                                                  ),
                                                  color: Color(0xff2CD282),
                                                ),
                                                child: Text(
                                                  "共有中",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                    alignment: Alignment.centerLeft,
                                  )
                                : Container(
                                    padding: EdgeInsets.only(
                                      left: getWidth(15),
                                      right: getWidth(15),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(0xFFECEFF1),
                                          width: getHeight(1),
                                        ),
                                      ),
                                    ),
                                    height: getHeight(78),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          child: Checkbox(
                                              value: shareServiceListController
                                                      .checkList
                                                      .where((item) =>
                                                          item["id"] == e["id"])
                                                      .length >
                                                  0,
                                              onChanged: (bool? isCheck) {
                                                if (isCheck == true) {
                                                  shareServiceListController
                                                      .checkList
                                                      .clear();
                                                  shareServiceListController
                                                      .checkList
                                                      .add(e);
                                                } else
                                                  shareServiceListController
                                                      .checkList
                                                      .remove(e);
                                              }),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(27),
                                          child: Container(
                                            width: getWidth(27),
                                            height: getWidth(27),
                                            child: e["icon"]
                                                    .toString()
                                                    .contains("http")
                                                ? Image.asset(
                                                    e["icon"].toString(),
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.memory(
                                                    base64Decode(e["icon"]
                                                        .toString()
                                                        .split(",")[1]),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(width: getWidth(15)),
                                        Text(upperFirstString(e["name"])),
                                        SizedBox(width: getWidth(15)),
                                        if (e["status"] == "sharing")
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: getWidth(12),
                                              vertical: getHeight(3),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                getWidth(2),
                                              ),
                                              color: Color(0xff2CD282),
                                            ),
                                            child: Text(
                                              "共有中",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        if (e["status"] == "pending")
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: getWidth(12),
                                              vertical: getHeight(3),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                getWidth(2),
                                              ),
                                              color: Color(0xffFFBC0F),
                                            ),
                                            child: Text(
                                              "承認待ち",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                      ],
                                    ),
                                    alignment: Alignment.centerLeft,
                                  ),
                          )
                          .toList(),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
