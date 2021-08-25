import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/text_box.dart';

class DetailHistoryItem extends StatelessWidget {
  ShareHistoryController shareHistoryController =
      Get.put(ShareHistoryController());
  @override
  Widget build(BuildContext context) {
    GlobalController globalController = Get.put(GlobalController());
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
                        Text("工藤新一（クドウシンイチ）"),
                        Text(
                          "shinichi12345",
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
              child: Text("1週間(2021/04/13 07:53まで) "),
              alignment: Alignment.centerLeft,
            ),
            Expanded(
              child: Container(),
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: buttonContainer(
                      sharingStatus:
                          shareHistoryController.itemSelected["status"] ??
                              "pending")),
            ),
          ],
        ),
      ),
    );
  }
}

Container buttonContainer({required String sharingStatus}) {
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
                '共有やめる'.tr,
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
                '共有設定編集'.tr,
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
            '承認'.tr,
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
            '共有設定編集'.tr,
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
                '拒否'.tr,
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
                '承認'.tr,
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
        style: TextStyle(fontSize: getWidth(13))),
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
