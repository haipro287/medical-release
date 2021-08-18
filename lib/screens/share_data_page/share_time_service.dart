import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/contact_page/contact_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/share_service_list_controller.dart';
import 'package:medical_chain_mobile_ui/screens/share_data_page/share_confirm_screen.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';

class ShareTimeService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShareServiceListController shareServiceListController =
        Get.put(ShareServiceListController());
    Get.put(ContactPageController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context, "share_service_list".tr),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: getHeight(12),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(getHeight(4)),
                border: Border.all(
                  color: Color(0xFFECEFF1),
                  width: getHeight(1),
                ),
              ),
              height: getHeight(56),
              child: Row(
                children: [
                  SizedBox(width: getWidth(15)),
                  Text(
                    "連携したいサービスを選択してください。",
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
            ),
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
              margin: EdgeInsets.only(
                bottom: getHeight(46),
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
                    left: getHeight(170),
                    right: getHeight(170),
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
