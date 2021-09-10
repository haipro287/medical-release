import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/confirm_approve_record.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/detail_history_page.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/sharing_history_page.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/text_box.dart';

class RejectedChangePage extends StatelessWidget {
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
          child: sentButtonContainer(
            sharingStatus: "pending",
            shareHistoryController: shareHistoryController,
            context: context,
          )),
      appBar: appBarWithButton(
        context,
        "detail_request".tr,
        InkWell(
          onTap: () {
            shareHistoryController.editToShare("SENT_DATA");
          },
          child: Text(
            'edit'.tr,
            style: TextStyle(color: Colors.blue, fontSize: getWidth(17)),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Color(0xFFF6F7FB),
        child: ListView(
          children: [
            customBoxHeader('requestSender'.tr),
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
                              child: Text(upperFirstString(e["name"])),
                            ),
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
              'timeRequest'.tr,
              tagBox(sharingStatus: "pending"),
            ),
            Container(
              color: Colors.white,
              height: getHeight(78),
              padding: EdgeInsets.symmetric(horizontal: getWidth(15)),
              child: Text(
                TimeService.getTimeFormat(TimeService.getTimeNow().toString(), ""),
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

Container sentButtonContainer({
  required String sharingStatus,
  required ShareHistoryController shareHistoryController,
  required BuildContext context,
}) {
  Container result = layout(
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
              // var a = await shareHistoryController.sharingService(
              //   context,
              //   status: "REJECTED_REQUEST",
              // );
              // print(a.toString());
              // print('reject');
              Get.put(GlobalController()).recordsTabMode.value = 4;
              Get.to(() => ShareHistoryPage());
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
  return result;
}
