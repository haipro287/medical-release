import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/contact_page/contact_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/share_service_list_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';

class ShareConfirmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShareServiceListController shareServiceListController =
        Get.put(ShareServiceListController());
    UserSearchController userSearchController = Get.put(UserSearchController());
    Get.put(ContactPageController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context, "データ共有確認".tr),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: getHeight(12),
            ),
            customBoxHeader(
              "共有先",
            ),
            Container(
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
                  SvgPicture.asset("assets/images/avatar.svg"),
                  SizedBox(width: getWidth(15)),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // romanji kanji name
                      children: [
                        Text(userSearchController.getHintText()),
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
            customBoxHeader("データ"),
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
                            bottom: BorderSide(
                              color: Color(0xFFECEFF1),
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
            customBoxHeader("共有期限"),
            Container(
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
              child: Text(shareServiceListController.getFormatTimeCal()),
              alignment: Alignment.centerLeft,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
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
                      var result = shareServiceListController.shareService(
                          secondaryId:
                              userSearchController.userData["secondaryId"]);
                      print(result);
                    },
                    child: Text(
                      '共有'.tr,
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

Container customBoxHeader(text) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xF2F3F7F2),
      borderRadius: BorderRadius.circular(getHeight(4)),
      border: Border.all(
        color: Color(0xF2F3F7F2),
        width: getHeight(1),
      ),
    ),
    height: getHeight(56),
    child: Row(
      children: [
        SizedBox(width: getWidth(15)),
        Text(
          text,
        ),
      ],
    ),
    alignment: Alignment.centerLeft,
  );
}
