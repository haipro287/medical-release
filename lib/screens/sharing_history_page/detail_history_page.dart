import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/text_box.dart';

class DetailHistoryPage extends StatelessWidget {
  ShareHistoryController shareHistoryController =
      Get.put(ShareHistoryController());
  GlobalController globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    var itemSelected = shareHistoryController.itemSelected;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: itemSelected["status"] == "pending"
          ? appBarWithButton(
              context,
              "detail_request".tr,
              InkWell(
                onTap: () {},
                child: Text(
                  'edit'.tr,
                  style: TextStyle(color: Colors.blue, fontSize: getWidth(17)),
                ),
              ))
          : appBar(
              context,
              ["sharing", "expired"].contains(itemSelected["status"])
                  ? "detail_sharing".tr
                  : "detail_request".tr),
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
                      children: [
                        Text(getHintText(itemSelected)),
                        Text(
                          itemSelected["username"],
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
            // Obx(
            //   () =>
            Column(
              children: List.generate(2, (index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFECEFF1),
                        width: getHeight(1),
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
                      SvgPicture.asset("assets/images/facebook.svg"),
                      SizedBox(width: getWidth(15)),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Facebook'),
                          ],
                        ),
                      )
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                );
              }),
            ),
            // ),
            customBoxHeaderWithTag(
              "timeSharing".tr,
              tagBox(
                  sharingStatus:
                      shareHistoryController.itemSelected["status"] ??
                          "pending"),
            ),
            Container(
              margin: EdgeInsets.only(
                left: getWidth(15),
                right: getWidth(15),
              ),
              height: getHeight(78),
              child: Text("1週間" +
                  "(" +
                  TimeService.getTimeFormat(itemSelected["endTime"], "まで") +
                  ")"),
              alignment: Alignment.centerLeft,
            ),
            Expanded(
              child: Container(),
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: globalController.historyStatus.value == "SENDING_MODE"
                      ? sentButtonContainer(
                          sharingStatus:
                              shareHistoryController.itemSelected["status"] ??
                                  "pending")
                      : requestButtonContainer(
                          sharingStatus:
                              shareHistoryController.itemSelected["status"])),
            ),
          ],
        ),
      ),
    );
  }
}

Container sentButtonContainer({required String sharingStatus}) {
  Container result;
  switch (sharingStatus) {
    case "sharing":
      result = Container(
        margin: EdgeInsets.only(
          bottom: getHeight(46),
          left: getWidth(16),
          right: getWidth(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xFFE9E9E9),
                side: BorderSide(
                  color: Color(0xFFD0E8FF),
                ),
                padding: EdgeInsets.only(
                  top: getHeight(14),
                  bottom: getHeight(14),
                  left: getWidth(17),
                  right: getWidth(17),
                ),
              ),
              onPressed: () {
                print('hahaha');
              },
              child: Text(
                'stop_sharing'.tr,
                style: TextStyle(color: Colors.black, fontSize: getWidth(17)),
              ),
            ),
            SizedBox(
              width: getWidth(8),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xFFD0E8FF),
                side: BorderSide(
                  color: Color(0xFFD0E8FF),
                ),
                padding: EdgeInsets.only(
                  top: getHeight(14),
                  bottom: getHeight(14),
                  left: getWidth(56),
                  right: getWidth(56),
                ),
              ),
              onPressed: () {
                print('hahaha');
              },
              child: Text(
                'edit_data_to_share'.tr,
                style: TextStyle(color: Colors.black, fontSize: getWidth(17)),
              ),
            ),
          ],
        ),
      );
      break;
    case "rejected":
      result = Container(
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
              left: getWidth(154),
              right: getWidth(154),
            ),
          ),
          onPressed: () {
            print('hahaha');
          },
          child: Text(
            'accept'.tr,
            style: TextStyle(color: Colors.black, fontSize: getWidth(17)),
          ),
        ),
      );
      break;
    case "expired":
      result = Container(
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
              left: getWidth(120),
              right: getWidth(120),
            ),
          ),
          onPressed: () {
            print('hahaha');
          },
          child: Text(
            'edit_data_to_share'.tr,
            style: TextStyle(color: Colors.black, fontSize: getWidth(17)),
          ),
        ),
      );
      break;
    case "pending":
    default:
      result = Container(
        margin: EdgeInsets.only(
          bottom: getHeight(46),
          left: getWidth(16),
          right: getWidth(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xFFE9E9E9),
                side: BorderSide(
                  color: Color(0xFFD0E8FF),
                ),
                padding: EdgeInsets.only(
                  top: getHeight(14),
                  bottom: getHeight(14),
                  left: getWidth(62),
                  right: getWidth(62),
                ),
              ),
              onPressed: () {
                print('hahaha');
              },
              child: Text(
                'accept'.tr,
                style: TextStyle(color: Colors.black, fontSize: getWidth(17)),
              ),
            ),
            SizedBox(
              width: getWidth(19),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xFFD0E8FF),
                side: BorderSide(
                  color: Color(0xFFD0E8FF),
                ),
                padding: EdgeInsets.only(
                  top: getHeight(14),
                  bottom: getHeight(14),
                  left: getWidth(62),
                  right: getWidth(62),
                ),
              ),
              onPressed: () {
                print('hahaha');
              },
              child: Text(
                'accept'.tr,
                style: TextStyle(color: Colors.black, fontSize: getWidth(17)),
              ),
            ),
          ],
        ),
      );
      break;
  }
  return result;
}

Container requestButtonContainer({required String sharingStatus}) {
  return Container(
    margin: EdgeInsets.only(
      bottom: getHeight(46),
      left: getWidth(16),
      right: getWidth(16),
    ),
    width: double.infinity,
    height: getHeight(48),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Color(0xFFD0E8FF),
        side: BorderSide(
          color: Color(0xFFD0E8FF),
        ),
      ),
      onPressed: () {
        print('hahaha');
      },
      child: Text(
        '${sharingStatus}_reqModeBtn'.tr,
        style: TextStyle(color: Colors.black, fontSize: getWidth(17)),
      ),
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
