import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/share_service_list_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_screen.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/sharing_history_page.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/utils/utils.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/dialog.dart';
import 'package:medical_chain_mobile_ui/widgets/text_box.dart';

class ShareConfirmScreen extends StatelessWidget {
  GlobalController globalController = Get.put(GlobalController());
  ShareServiceListController shareServiceListController =
      Get.put(ShareServiceListController());
  UserSearchController userSearchController = Get.put(UserSearchController());
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
          context,
          globalController.sharingStatus.value == "SENT_DATA"
              ? "confirmSentData".tr
              : "confirmSentRequest".tr),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: getHeight(12)),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            bottom: getHeight(46),
            left: getWidth(16),
            right: getWidth(16),
          ),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Color(0xFFD0E8FF),
              side: BorderSide(
                color: Color(0xFFD0E8FF),
              ),
              padding: EdgeInsets.only(
                top: getHeight(13),
                bottom: getHeight(13),
              ),
            ),
            onPressed: () async {
              if (isClick == false) {
                isClick = true;
                try {
                  showLoading();
                  var editMode = globalController.editToShareMode.value;
                  if (editMode == "STOP_SHARING") {
                    var stopResult =
                        await Get.put(ShareHistoryController()).sharingService(
                      context,
                      status: "STOP_SHARING",
                    );
                    print(stopResult.toString());
                  }

                  var result = await shareServiceListController.shareService(
                    id: userSearchController.userData["secondaryId"],
                    sharingStatus: globalController.sharingStatus.value,
                  );

                  if (globalController.sharingStatus.value == "SENT_DATA") {
                    globalController.historyStatus.value = "SENDING_MODE";
                  } else {
                    globalController.historyStatus.value = "REQUEST_MODE";
                  }

                  if (result["id"] != null) {
                    var tabChange =
                        globalController.historyStatus.value == "SENDING_MODE"
                            ? 1
                            : 3;
                    globalController.recordsTabMode.value = tabChange;
                    Get.back();
                    Get.offAll(() => HomePageScreen());
                    globalController.onChangeTab(0);
                    Get.to(() => ShareHistoryPage());
                  }

                  if (result["success"] == false) {
                    print({"servicesss": result["services"]});
                    Get.back();
                    CustomDialog(context, "ALREADY_SHARED")
                        .show({"servicesList": result["services"]});
                  }
                  isClick = false;
                } catch (e) {
                  Get.back();
                  Get.rawSnackbar(
                      boxShadows: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                      borderRadius: getWidth(6),
                      margin: EdgeInsets.only(
                        bottom: getHeight(40),
                        left: getWidth(16),
                        right: getWidth(16),
                      ),
                      messageText: Text(
                        "エラーが発生しました。",
                        style: TextStyle(fontSize: getWidth(17)),
                      ),
                      backgroundColor: Colors.white,
                      icon: SvgPicture.asset("assets/images/error.svg"));
                  isClick = false;
                }
              }
            },
            child: Text(
              globalController.sharingStatus.value == "SENT_DATA"
                  ? 'sentDataBtn'.tr
                  : 'sentRequestBtn'.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: getWidth(15),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Color(0xFFF6F7FB),
        child: ListView(
          children: [
            customBoxHeader(
              "dataReceiver".tr,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                left: getWidth(15),
                right: getWidth(15),
              ),
              height: getHeight(78),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(56),
                    child: Container(
                      width: getWidth(36),
                      height: getWidth(36),
                      color: Color(userSearchController.userData["avatar"]),
                    ),
                  ),
                  SizedBox(width: getWidth(15)),
                  Container(
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(getHintText(userSearchController.userData)),
                          Text(
                            userSearchController.userData["username"] ??
                                userSearchController
                                    .userData["secondaryUsername"] ??
                                "userid1234",
                            style: TextStyle(color: Color(0xFF838AA2)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              alignment: Alignment.centerLeft,
            ),
            customBoxHeader("data".tr),
            Obx(
              () => Column(
                children: shareServiceListController.checkList
                    .map(
                      (e) => Container(
                        padding: EdgeInsets.only(
                          left: getWidth(15),
                          right: getWidth(15),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                              color: Color(0xFFECEFF1),
                              width: e["id"] !=
                                      shareServiceListController.checkList[0]
                                          ["id"]
                                  ? getHeight(1)
                                  : getHeight(0),
                            ),
                          ),
                        ),
                        height: getHeight(78),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(27),
                              child: Container(
                                width: getWidth(27),
                                height: getWidth(27),
                                child: e["icon"].toString().contains("http")
                                    ? Image.asset(
                                        e["icon"].toString(),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.memory(
                                        base64Decode(
                                            e["icon"].toString().split(",")[1]),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            SizedBox(width: getWidth(15)),
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(upperFirstString(e["name"])),
                                ],
                              ),
                            )
                          ],
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    )
                    .toList(),
              ),
            ),
            customBoxHeader(globalController.sharingStatus.value == "SENT_DATA"
                ? "timeSharing".tr
                : "timeRequest".tr),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                left: getWidth(15),
                right: getWidth(15),
              ),
              height: getHeight(78),
              child: Text(shareServiceListController.getFormatTimeCal()),
              alignment: Alignment.centerLeft,
            ),
            SizedBox(
              height: getHeight(13),
            ),
            globalController.sharingStatus.value == "SENT_DATA"
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: getWidth(16)),
                    padding: EdgeInsets.symmetric(horizontal: getWidth(12)),
                    width: double.infinity,
                    height: getHeight(74),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getWidth(6),
                      ),
                      color: Color(0xFFFFBC0F).withOpacity(0.1),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/images/alert.svg"),
                        SizedBox(
                          width: getWidth(12),
                        ),
                        Text(
                          "共有を停止するまでデータは共有さ\nれます。",
                          style: TextStyle(
                            fontSize: getWidth(17),
                          ),
                        )
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
