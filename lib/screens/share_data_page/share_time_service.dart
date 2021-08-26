import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/contact_page/contact_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/share_service_list_controller.dart';
import 'package:medical_chain_mobile_ui/screens/share_data_page/share_confirm_screen.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/text_box.dart';

class ShareTimeService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShareServiceListController shareServiceListController =
        Get.put(ShareServiceListController());
    GlobalController globalController = Get.put(GlobalController());
    Get.put(ContactPageController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
          context,
          globalController.sharingStatus.value == "SENT_DATA"
              ? "timeSharingTitle".tr
              : "timeSentRequestTitle".tr),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: getHeight(12),
            ),
            customBoxHeader("chooseTimeSharing".tr),
            Obx(
              () => Expanded(
                  flex: 1,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: shareServiceListController.timeList
                        .map(
                          (e) => Container(
                            margin: EdgeInsets.only(
                              left: getWidth(15),
                              right: getWidth(15),
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFFECEFF1),
                                  width: getHeight(1),
                                ),
                              ),
                            ),
                            height: getHeight(78),
                            child: Row(children: [
                              Radio(
                                value: shareServiceListController
                                        .timeSelected.value !=
                                    e["value"],
                                groupValue: false,
                                onChanged: (var a) {
                                  shareServiceListController
                                      .timeSelected.value = e["value"];
                                },
                              ),
                              Text(e["name"]),
                            ]),
                            alignment: Alignment.centerLeft,
                          ),
                        )
                        .toList(),
                  )),
            ),
            Container(
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
                  Get.to(() => ShareConfirmScreen());
                },
                child: Text(
                  'next'.tr,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
