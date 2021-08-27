import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

class CustomDialog {
  UserSearchController userSearchController = Get.put(UserSearchController());
  BuildContext context;
  CustomDialog(this.context);
  void show() {
    AlertDialog alert;
    alert = AlertDialog(
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
                          padding:
                              EdgeInsets.symmetric(vertical: getHeight(12)),
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
                          padding:
                              EdgeInsets.symmetric(vertical: getHeight(12)),
                        ),
                        onPressed: () async {
                          var a = await userSearchController.deleteContact();
                          Navigator.of(context).pop();
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

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
