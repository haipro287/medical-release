import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/scanQRController/scanQR_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/screens/my_account/my_account_components.dart';
import 'package:medical_chain_mobile_ui/screens/share_data_page/share_list_service.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/dialog.dart';

class UserSavedScreen extends StatelessWidget {
  UserSearchController userSearchController = Get.put(UserSearchController());
  GlobalController globalController = Get.put(GlobalController());
  String? scan;
  UserSavedScreen({this.scan});
  @override
  Widget build(BuildContext context) {
    var userInfo = userSearchController.userData;
    return WillPopScope(
      onWillPop: () async {
        if (scan == "scan") {
          Get.put(QrScanController()).controller!.resumeCamera();
          Get.put(QrScanController()).qr = "";
          Get.back();
        } else
          Get.back();
        return false;
      },
      child: Stack(
        children: [
          Container(
            height: screenHeight(),
            color: Color(0xFFf4FaFF),
          ),
          Container(
            height: getHeight(350),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/my_account_background.png'),
              ),
            ),
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: appBar(
                context,
                "",
                GestureDetector(
                  onTap: () async {
                    CustomDialog(context, "DELETE_CONTACT").show();
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      'assets/images/delete-icon.svg',
                    ),
                  ),
                ),
                null,
                null,
                scan),
            body: Container(
              padding: EdgeInsets.only(top: getHeight(30)),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: getHeight(70),
                    width: getWidth(70),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                      shape: BoxShape.circle,
                      color: Color(userSearchController.userData["avatar"] ??
                          0xFFD0E8FF),
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: getWidth(17),
                          right: getWidth(17),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          bottom: getHeight(4),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Colors.black12,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: getWidth(24),
                            ),
                            Obx(
                              () => userSearchController.isEditing.value == true
                                  ? Container(
                                      margin: EdgeInsets.only(
                                        bottom: getHeight(4),
                                      ),
                                      width: getWidth(200),
                                      // height: getHeight(36),
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        // maxLength: 60,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF2F3842),
                                          fontSize: getWidth(20),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        controller:
                                            userSearchController.nickname,
                                        autofocus: true,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(60),
                                        ],
                                        decoration: InputDecoration(
                                          hintText: "ニックネーム",
                                          hintStyle: TextStyle(
                                              color: Color(0xFF838AA2)),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: getWidth(16),
                                              right: getWidth(16)),
                                          labelStyle: TextStyle(
                                              color: Color(0xFF878C92),
                                              fontSize: getWidth(16)),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      // margin: EdgeInsets.only(
                                      //   bottom: getHeight(4),
                                      // ),
                                      width: getWidth(200),
                                      // height: getHeight(36),
                                      alignment: Alignment.center,
                                      child: userSearchController
                                                  .userData["secondaryName"] !=
                                              ""
                                          ? Text(
                                              userSearchController.userData[
                                                      "secondaryName"] ??
                                                  "",
                                              style: TextStyle(
                                                color: Color(0xFF2F3842),
                                                fontSize: getWidth(20),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Text(
                                              "ニックネーム",
                                              style: TextStyle(
                                                  fontSize: getWidth(20),
                                                  color: Color(0xFF838AA2)),
                                            ),
                                    ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: getWidth(8)),
                              child: GestureDetector(
                                onTap: () async {
                                  print('change');
                                  await userSearchController.changeEditStatus();
                                },
                                child: Obx(
                                  () => userSearchController.isEditing.value
                                      ? SvgPicture.asset(
                                          "assets/images/tick-icon.svg")
                                      : SvgPicture.asset(
                                          "assets/images/edit-icon.svg"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    margin: EdgeInsets.only(
                      top: getHeight(40),
                      left: getWidth(17),
                      right: getWidth(17),
                    ),
                    padding: EdgeInsets.only(
                      top: getHeight(30),
                      left: getWidth(20),
                      right: getWidth(20),
                    ),
                    alignment: Alignment.center,
                    width: getWidth(343),
                    child: Column(
                      children: [
                        myAccountField(
                          myAccountText(('ユーザーID')),
                          myAccountText('${userInfo["secondaryUsername"]}'),
                        ),
                        (userInfo["isBanned"] == null ||
                                userInfo["isBanned"] == false)
                            ? myAccountFieldWithoutSeperateLine(
                                myAccountText(('氏名')),
                                myAccountText(convertLongString(
                                      string: userInfo["kanji"].toString(),
                                      firstLength: 4,
                                      lastLength: 4,
                                    ) +
                                    " (" +
                                    convertLongString(
                                      string: userInfo["katakana"].toString(),
                                      firstLength: 5,
                                      lastLength: 5,
                                    ) +
                                    ")"),
                              )
                            : Column(
                                children: [
                                  myAccountField(
                                    myAccountText(('氏名')),
                                    myAccountText(convertLongString(
                                          string: userInfo["kanji"].toString(),
                                          firstLength: 4,
                                          lastLength: 4,
                                        ) +
                                        " (" +
                                        convertLongString(
                                          string:
                                              userInfo["katakana"].toString(),
                                          firstLength: 5,
                                          lastLength: 5,
                                        ) +
                                        ")"),
                                  ),
                                  myAccountFieldWithoutSeperateLine(
                                    myAccountText(('status_account'.tr)),
                                    myAccountText('unActive'.tr),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                  (userInfo["isBanned"] == null ||
                          userInfo["isBanned"] == false)
                      ? Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: getHeight(24),
                            left: getWidth(16),
                            right: getWidth(16),
                          ),
                          child: Column(
                            children: [
                              OutlinedButton(
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
                                  globalController.sharingStatus.value =
                                      "SENT_DATA";
                                  Get.to(() => ShareListService());
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.28,
                                    ),
                                    SvgPicture.asset(
                                        "assets/images/share-icon.svg"),
                                    SizedBox(
                                      width: getWidth(10),
                                    ),
                                    Text(
                                      "データ共有",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: getWidth(17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getHeight(14),
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
                                  ),
                                ),
                                onPressed: () {
                                  globalController.sharingStatus.value =
                                      "SENT_REQUEST";
                                  Get.to(() => ShareListService());
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.28,
                                    ),
                                    SvgPicture.asset(
                                        "assets/images/sent-icon.svg"),
                                    SizedBox(
                                      width: getWidth(10),
                                    ),
                                    Text(
                                      "リクエスト送信",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: getWidth(17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
