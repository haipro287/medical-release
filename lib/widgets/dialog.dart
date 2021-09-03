import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/screens/list_service/list_service_screen.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/sharing_history_page.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

class CustomDialog {
  BuildContext context;
  String type;
  CustomDialog(this.context, this.type);
  void show([optionData]) {
    AlertDialog alert;
    if (type == "DELETE_CONTACT") {
      alert = deleteDialog(context);
    } else if (type == "CHANGE_PASSWORD") {
      alert = changePasswordDialog(context);
    } else if (type == "STOP_SHARING") {
      alert = stopSharingDialog(context);
    } else if (type == "SERVICES_NOT_CONNECT") {
      alert = servicesNotConnectDialog(context, optionData["servicesList"]);
    } else {
      alert = deleteDialog(context);
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

AlertDialog deleteDialog(context) {
  UserSearchController userSearchController = Get.put(UserSearchController());
  return AlertDialog(
    content: Container(
      width: getWidth(343),
      height: getHeight(253),
      child: Column(
        children: [
          SvgPicture.asset("assets/images/contact-icon.svg"),
          SizedBox(
            height: getHeight(27),
          ),
          Text(
            "このコンタクトを削除してもよろしいでしょうか。",
            style: TextStyle(fontSize: getWidth(17)),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: getHeight(12),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFFE9E9E9),
                        side: BorderSide(
                          color: Color(0xFFE9E9E9),
                        ),
                        padding: EdgeInsets.symmetric(vertical: getHeight(12)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'キャンセル',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getWidth(17),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(width: getWidth(10)),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFFEB5757),
                        side: BorderSide(
                          color: Color(0xFFEB5757),
                        ),
                        padding: EdgeInsets.symmetric(vertical: getHeight(12)),
                      ),
                      onPressed: () async {
                        var a = await userSearchController.deleteContact();
                        Navigator.of(context).pop();
                        Get.back();
                      },
                      child: Text(
                        '削除',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: getWidth(17),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

AlertDialog stopSharingDialog(context) {
  ShareHistoryController shareHistoryController =
      Get.put(ShareHistoryController());
  return AlertDialog(
    content: Container(
      width: getWidth(343),
      height: getHeight(257),
      child: Column(
        children: [
          SvgPicture.asset("assets/images/question-icon.svg"),
          SizedBox(
            height: getHeight(27),
          ),
          Text(
            "佐藤桜  (サトウサクラ)さん はあなたのデータを見ることができなくなります。",
            style: TextStyle(fontSize: getWidth(17)),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: getHeight(12),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFFE9E9E9),
                        side: BorderSide(
                          color: Color(0xFFE9E9E9),
                        ),
                        padding: EdgeInsets.symmetric(vertical: getHeight(12)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'キャンセル',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getWidth(17),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(width: getWidth(10)),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFFEB5757),
                        side: BorderSide(
                          color: Color(0xFFEB5757),
                        ),
                        padding: EdgeInsets.symmetric(vertical: getHeight(12)),
                      ),
                      onPressed: () async {
                        var a = await shareHistoryController.sharingService(
                          context,
                          status: "STOP_SHARING",
                        );
                        Navigator.of(context).pop();
                        Get.to(() => ShareHistoryPage());
                      },
                      child: Text(
                        'やめる',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: getWidth(17),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

AlertDialog changePasswordDialog(context) {
  return AlertDialog(
    content: Container(
      width: getWidth(343),
      height: getHeight(220),
      child: Column(
        children: [
          SvgPicture.asset("assets/images/success-icon.svg"),
          SizedBox(
            height: getHeight(27),
          ),
          Text(
            "パスワード変更しました。",
            style: TextStyle(fontSize: getWidth(17)),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: getHeight(12),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFFD0E8FF),
                        side: BorderSide(
                          color: Color(0xFFD0E8FF),
                        ),
                        padding: EdgeInsets.symmetric(vertical: getHeight(12)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getWidth(17),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

AlertDialog servicesNotConnectDialog(context, List<dynamic> servicesList) {
  return AlertDialog(
    content: Container(
      width: getWidth(343),
      height: getHeight(288),
      child: Column(
        children: [
          Text(
            "データを共有するため、以下のサービスを連携しておいてださい。",
            style: TextStyle(fontSize: getWidth(17)),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: getHeight(27),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: servicesList
                .map((e) => Container(
                      margin: EdgeInsets.only(
                        bottom: getHeight(8),
                      ),
                      child: Row(children: [
                        Container(
                          width: getWidth(27),
                          child: e["icon"].toString().contains('http')
                              ? Image.network(e["icon"].toString())
                              : SvgPicture.asset(
                                  "assets/images/avatar.svg",
                                  width: getWidth(27),
                                ),
                        ),
                        SizedBox(width: getWidth(8)),
                        Container(
                          child: Text(upperFirstString(e["name"])),
                        ),
                      ]),
                    ))
                .toList(),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Color(0xFFE9E9E9),
                                side: BorderSide(
                                  color: Color(0xFFE9E9E9),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: getHeight(12)),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'キャンセル',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getWidth(17),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          SizedBox(width: getWidth(10)),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Color(0xFFEB5757),
                                side: BorderSide(
                                  color: Color(0xFFEB5757),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: getHeight(12)),
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                Get.to(() => ListServiceScreen());
                              },
                              child: Text(
                                '連携',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getWidth(17),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
