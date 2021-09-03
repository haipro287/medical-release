import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/confirm_approve_record.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/dialog.dart';
import 'package:medical_chain_mobile_ui/widgets/text_box.dart';

class DetailHistoryPage extends StatelessWidget {
  ShareHistoryController shareHistoryController =
      Get.put(ShareHistoryController());
  GlobalController globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    var itemSelected = shareHistoryController.itemSelected;
    var mode = globalController.historyStatus.value == "SENDING_MODE";
    var subMode = ["sharing", "expired"].contains(itemSelected["status"]);
    List<dynamic> servicesList = itemSelected["services"];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: getHeight(12)),
        child: globalController.historyStatus.value == "SENDING_MODE"
            ? sentButtonContainer(
                sharingStatus:
                    shareHistoryController.itemSelected["status"] ?? "pending",
                shareHistoryController: shareHistoryController,
                context: context,
              )
            : requestButtonContainer(
                sharingStatus: shareHistoryController.itemSelected["status"],
                shareHistoryController: shareHistoryController,
                context: context,
              ),
      ),
      appBar: mode
          ? appBarWithButton(
              context,
              subMode ? "detail_sharing".tr : "detail_request".tr,
              subMode
                  ? null
                  : InkWell(
                      onTap: () {
                        shareHistoryController.editToShare("SENT_DATA");
                      },
                      child: Text(
                        'edit'.tr,
                        style: TextStyle(
                            color: Colors.blue, fontSize: getWidth(17)),
                      ),
                    ),
            )
          : appBar(context, subMode ? "data_reference".tr : "data_request".tr),
      backgroundColor: Colors.white,
      body: Container(
        color: Color(0xFFF6F7FB),
        child: ListView(
          children: [
            customBoxHeader(
              mode
                  ? (subMode ? 'dataReceiver'.tr : 'requestSender'.tr)
                  : (subMode ? 'dataSender'.tr : 'requestReceived'.tr),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: getWidth(15)),
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
                        Text(getHintText(itemSelected)),
                        Text(
                          itemSelected["username"] ?? "",
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
            // Obx(
            //   () =>
            Container(
              color: Colors.white,
              child: Column(
                children: servicesList
                    .map(
                      (e) => Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFECEFF1),
                              width: e["id"] !=
                                      servicesList[servicesList.length - 1]
                                          ["id"]
                                  ? getHeight(1)
                                  : getHeight(0),
                            ),
                          ),
                        ),
                        margin: EdgeInsets.only(
                          left: getWidth(15),
                          right: getWidth(15),
                        ),
                        height: getHeight(78),
                        child: Row(
                          children: [
                            Container(
                              width: getWidth(24),
                              child: e["icon"].toString().contains('http')
                                  ? Image.network(e["icon"].toString())
                                  : SvgPicture.asset(
                                      "assets/images/avatar.svg",
                                      width: getWidth(16),
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
            // ),
            customBoxHeaderWithTag(
              subMode ? "timeSharing".tr : 'timeRequest'.tr,
              tagBox(
                  sharingStatus:
                      shareHistoryController.itemSelected["status"] ??
                          "pending"),
            ),
            Container(
              color: Colors.white,
              height: getHeight(78),
              padding: EdgeInsets.symmetric(horizontal: getWidth(15)),
              child: Text(
                TimeService.getTimeFormat(itemSelected["fromTime"], ""),
              ),
              alignment: Alignment.centerLeft,
            ),
            itemSelected["status"] == "expired"
                ? customBoxHeader(
                    "timeStop".tr,
                  )
                : Container(),
            itemSelected["status"] == "expired"
                ? Container(
                    color: Colors.white,
                    height: getHeight(78),
                    padding: EdgeInsets.symmetric(horizontal: getWidth(15)),
                    child: Text(
                      TimeService.getTimeFormat(itemSelected["endTime"], ""),
                    ),
                    alignment: Alignment.centerLeft,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

Container layout({required Widget child}) {
  return Container(
    margin: EdgeInsets.only(
      bottom: getHeight(46),
      left: getWidth(16),
      right: getWidth(16),
    ),
    height: getHeight(48),
    width: double.infinity,
    child: child,
  );
}

Container sentButtonContainer({
  required String sharingStatus,
  required ShareHistoryController shareHistoryController,
  required BuildContext context,
}) {
  Container result;
  switch (sharingStatus) {
    case "sharing":
      result = layout(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFFE9E9E9),
                  side: BorderSide(
                    color: Color(0xFFE9E9E9),
                  ),
                ),
                onPressed: () {
                  CustomDialog(context, "STOP_SHARING").show();
                },
                child: Text(
                  'stop_sharing'.tr,
                  style: TextStyle(color: Colors.black, fontSize: getWidth(15)),
                ),
              ),
            ),
            SizedBox(
              width: getWidth(8),
            ),
            Expanded(
              flex: 2,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFFD0E8FF),
                  side: BorderSide(
                    color: Color(0xFFD0E8FF),
                  ),
                ),
                onPressed: () {
                  shareHistoryController.editToShare("SENT_DATA");
                  print('edit to share');
                },
                child: Text(
                  'edit_data_to_share'.tr,
                  style: TextStyle(color: Colors.black, fontSize: getWidth(15)),
                ),
              ),
            ),
          ],
        ),
      );
      break;
    case "rejected":
      result = layout(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFFD0E8FF),
                  side: BorderSide(
                    color: Color(0xFFD0E8FF),
                  ),
                ),
                onPressed: () {
                  Get.to(() => ConfirmApproveRecordPage());
                  print('approve');
                },
                child: Text(
                  'accept'.tr,
                  style: TextStyle(color: Colors.black, fontSize: getWidth(15)),
                ),
              ),
            ),
          ],
        ),
      );
      break;
    case "expired":
      result = layout(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFFD0E8FF),
                  side: BorderSide(
                    color: Color(0xFFD0E8FF),
                  ),
                ),
                onPressed: () {
                  shareHistoryController.editToShare("SENT_DATA");
                  print('edit to share');
                },
                child: Text(
                  'edit_data_to_share'.tr,
                  style: TextStyle(color: Colors.black, fontSize: getWidth(15)),
                ),
              ),
            ),
          ],
        ),
      );
      break;
    case "pending":
    default:
      result = layout(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFFE9E9E9),
                  side: BorderSide(
                    color: Color(0xFFE9E9E9),
                  ),
                ),
                onPressed: () async {
                  var a = await shareHistoryController.sharingService(
                    context,
                    status: "REJECTED_REQUEST",
                  );
                  print(a.toString());
                  print('reject');
                },
                child: Text(
                  'rejected_color'.tr,
                  style: TextStyle(color: Colors.black, fontSize: getWidth(15)),
                ),
              ),
            ),
            SizedBox(
              width: getWidth(19),
            ),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFFD0E8FF),
                  side: BorderSide(
                    color: Color(0xFFD0E8FF),
                  ),
                ),
                onPressed: () {
                  Get.to(() => ConfirmApproveRecordPage());
                  print('approve');
                },
                child: Text(
                  'accept'.tr,
                  style: TextStyle(color: Colors.black, fontSize: getWidth(15)),
                ),
              ),
            ),
          ],
        ),
      );
      break;
  }
  return result;
}

Container requestButtonContainer({
  required String sharingStatus,
  required ShareHistoryController shareHistoryController,
  required BuildContext context,
}) {
  return layout(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Color(0xFFD0E8FF),
              side: BorderSide(
                color: Color(0xFFD0E8FF),
              ),
            ),
            onPressed: () {
              if (sharingStatus == "sharing") {
                print('hahaha');
              } else {
                shareHistoryController.editToShare("SENT_REQUEST");
              }
            },
            child: Text(
              '${sharingStatus}_reqModeBtn'.tr,
              style: TextStyle(color: Colors.black, fontSize: getWidth(15)),
            ),
          ),
        ),
      ],
    ),
  );
}

Container tagBox({required String sharingStatus}) {
  return Container(
    height: getWidth(22),
    alignment: Alignment.center,
    padding: EdgeInsets.only(
      left: getWidth(12),
      right: getWidth(12),
    ),
    color: colorTag(sharingStatus),
    child: Text("${sharingStatus}_color".tr,
        style: TextStyle(fontSize: getWidth(13), color: Colors.white)),
  );
}

Color colorTag(String sharingStatus) {
  Color result;
  switch (sharingStatus) {
    case "sharing":
      result = Color(0xFF2CD282);
      break;
    case "expired":
      result = Color(0xFF6C39DB);
      break;
    case "pending":
      result = Color(0xFFFFBC0F);
      break;
    case "rejected":
      result = Color(0xFFED4D4D);
      break;
    default:
      result = Color(0xFFFFBC0F);
      break;
  }
  return result;
}
