import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/contact_page/contact_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/share_service_list_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/screens/share_data_page/share_time_service.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';

class ShareListService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShareServiceListController shareServiceListController =
        Get.put(ShareServiceListController());
    UserSearchController userSearchController = Get.put(UserSearchController());
    Get.put(ContactPageController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context, "共有データ選択".tr),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: getHeight(12),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xF2F3F7F2),
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
                    children: shareServiceListController.serviceList
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
                            child: Row(
                              children: [
                                Checkbox(
                                    value: shareServiceListController.checkList
                                        .contains(e),
                                    onChanged: (bool? isCheck) => {
                                          if (isCheck == true)
                                            {
                                              shareServiceListController
                                                  .checkList
                                                  .add(e)
                                            }
                                          else
                                            shareServiceListController.checkList
                                                .remove(e)
                                        }),
                                SvgPicture.asset("assets/images/avatar.svg"),
                                SizedBox(width: getWidth(15)),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(e["name"]),
                                      Text(
                                        userSearchController.userData["secondaryUsername"],
                                        style: TextStyle(
                                            color: Colors.blueGrey.shade300),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        )
                        .toList(),
                  )),
            ),
            Obx(
              () => Container(
                margin: EdgeInsets.only(
                  bottom: getHeight(46),
                ),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                        shareServiceListController.checkList.length > 0
                            ? Color(0xFFD0E8FF)
                            : Color(0xE3E3E3E3),
                    side: BorderSide(
                      color: shareServiceListController.checkList.length > 0
                          ? Color(0xFFD0E8FF)
                          : Color(0xE3E3E3E3),
                    ),
                    padding: EdgeInsets.only(
                      top: getHeight(14),
                      bottom: getHeight(14),
                      left: getHeight(170),
                      right: getHeight(170),
                    ),
                  ),
                  onPressed: () {
                    if (shareServiceListController.checkList.length > 0) {
                      Get.to(() => ShareTimeService());
                    }
                  },
                  child: Text(
                    'next'.tr,
                    style: TextStyle(color: Colors.black),
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
