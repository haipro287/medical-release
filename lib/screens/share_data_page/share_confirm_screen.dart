import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/contact_page/contact_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/share_service_list_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/sharing_history_page.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/text_box.dart';

class ShareConfirmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalController globalController = Get.put(GlobalController());
    ShareServiceListController shareServiceListController =
        Get.put(ShareServiceListController());
    UserSearchController userSearchController = Get.put(UserSearchController());
    Get.put(ContactPageController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
          context,
          globalController.sharingStatus.value == "SENT_DATA"
              ? "confirmSentData".tr
              : "confirmSentRequest".tr),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: getHeight(12),
            ),
            customBoxHeader(
              "userReceived".tr,
            ),
            Container(
              margin: EdgeInsets.only(
                left: getWidth(15),
                right: getWidth(15),
              ),
              height: getHeight(78),
              child: Row(
                children: [
                  SvgPicture.asset("assets/images/avatar.svg"),
                  SizedBox(width: getWidth(15)),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // romanji kanji name
                      children: [
                        Text(getHintText(userSearchController.userData)),
                        Text(
                          userSearchController.userData["username"] ??
                              userSearchController
                                  .userData["secondaryUsername"] ??
                              "userid1234",
                          style: TextStyle(color: Colors.blueGrey.shade300),
                        ),
                      ],
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
                        margin: EdgeInsets.only(
                          left: getWidth(15),
                          right: getWidth(15),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: e["id"] !=
                                      shareServiceListController.checkList[0]
                                          ["id"]
                                  ? Color(0xFFECEFF1)
                                  : Colors.white,
                              width: getHeight(1),
                            ),
                          ),
                        ),
                        height: getHeight(78),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/avatar.svg"),
                            SizedBox(width: getWidth(15)),
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(e["name"]),
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
            customBoxHeader("timeSharing".tr),
            Container(
              margin: EdgeInsets.only(
                left: getWidth(15),
                right: getWidth(15),
              ),
              height: getHeight(78),
              child: Text(shareServiceListController.getFormatTimeCal()),
              alignment: Alignment.centerLeft,
            ),
            Expanded(
              child: Container(),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
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
                        top: getHeight(14),
                        bottom: getHeight(14),
                      ),
                    ),
                    onPressed: () {
                      var result = shareServiceListController.shareService(
                        id: userSearchController.userData["secondaryId"],
                        sharingStatus: globalController.sharingStatus.value,
                      );
                      print(result);
                      if (globalController.sharingStatus.value == "SENT_DATA") {
                        globalController.historyStatus.value = "SENDING_MODE";
                      } else {
                        globalController.historyStatus.value = "REQUEST_MODE";
                      }
                      Get.put(ShareHistoryController()).currentPage.value = 3;
                      Get.to(() => ShareHistoryPage());
                    },
                    child: Text(
                      globalController.sharingStatus.value == "SENT_DATA"
                          ? 'sentDataBtn'.tr
                          : 'sentRequestBtn'.tr,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
