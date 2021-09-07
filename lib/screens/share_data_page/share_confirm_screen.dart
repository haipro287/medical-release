import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/share_service_list_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/sharing_history_page.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/dialog.dart';
import 'package:medical_chain_mobile_ui/widgets/text_box.dart';

class ShareConfirmScreen extends StatelessWidget {
  GlobalController globalController = Get.put(GlobalController());
  ShareServiceListController shareServiceListController =
      Get.put(ShareServiceListController());
  UserSearchController userSearchController = Get.put(UserSearchController());
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

                Get.offAll(() => ShareHistoryPage());
              }

              if (result["services"] != null) {
                CustomDialog(context, "ALREADY_SHARED")
                    .show({"servicesList": result["services"]});
              }
            },
            child: Text(
              globalController.sharingStatus.value == "SENT_DATA"
                  ? 'sentDataBtn'.tr
                  : 'sentRequestBtn'.tr,
              style: TextStyle(color: Colors.black, fontSize: getWidth(15)),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Color(0xFFF6F7FB),
        child: Column(
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
                  SvgPicture.asset("assets/images/avatar.svg"),
                  SizedBox(width: getWidth(15)),
                  Container(
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
                            e["icon"].toString().contains('http')
                                ? Container(
                                    width: getWidth(27),
                                    child: Image.network(e["icon"].toString()))
                                : SvgPicture.asset(
                                    'assets/images/avatar.svg',
                                    width: getWidth(27),
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
          ],
        ),
      ),
    );
  }
}
