import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/text_box.dart';

class ConfirmApproveRecordPage extends StatelessWidget {
  ShareHistoryController shareHistoryController =
      Get.put(ShareHistoryController());
  GlobalController globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    var itemSelected = shareHistoryController.itemSelected;
    List<dynamic> servicesList = itemSelected["services"];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(top: getHeight(12)),
          child: confirmButtonContainer(
            context,
            shareHistoryController: shareHistoryController,
          )),
      appBar: appBar(context, "confirmSentData".tr),
      backgroundColor: Colors.white,
      body: Container(
        color: Color(0xFFF6F7FB),
        child: ListView(
          children: [
            customBoxHeader('dataReceiver'.tr),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: getWidth(15)),
              height: getHeight(78),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(56),
                    child: Container(
                      width: getWidth(36),
                      height: getWidth(36),
                      color: Color(itemSelected["avatar"]),
                    ),
                  ),
                  SizedBox(width: getWidth(15)),
                  Container(
                    child: Expanded(
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
                    ),
                  )
                ],
              ),
              alignment: Alignment.centerLeft,
            ),
            customBoxHeader("data".tr),
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
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  upperFirstString(e["name"]),
                                  overflow: TextOverflow.ellipsis,
                                ),
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
            customBoxHeader(
              shareHistoryController.itemSelected.value["status"] != "rejected"
                  ? "timeSentRequestTitle".tr
                  : 'timeSharing'.tr,
            ),
            Container(
              color: Colors.white,
              height: getHeight(78),
              padding: EdgeInsets.symmetric(horizontal: getWidth(15)),
              child: Text(
                TimeService.getTimeFormat(
                    TimeService.getTimeNow().toUtc().millisecondsSinceEpoch,
                    ""),
              ),
              alignment: Alignment.centerLeft,
            ),
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

Container confirmButtonContainer(
  BuildContext context, {
  required ShareHistoryController shareHistoryController,
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
            onPressed: () async {
              var a = await shareHistoryController.sharingService(
                context,
                status: "APPROVE_REQUEST",
              );
              print(a.toString());
            },
            child: Text(
              "share".tr,
              style: TextStyle(color: Colors.black, fontSize: getWidth(15)),
            ),
          ),
        ),
      ],
    ),
  );
}
