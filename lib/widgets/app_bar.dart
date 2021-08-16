import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

AppBar appBar([BuildContext? context, String? title, Widget? button]) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Color(0xFF454B52),
      ),
      onPressed: () {
        Get.back();
      },
    ),
    title: Text(
      title ?? '',
      style: TextStyle(
          color: Color(0xFF2F3842),
          fontWeight: FontWeight.w600,
          fontSize: getWidth(20)),
    ),
    centerTitle: true,
    actions: button == null
        ? []
        : [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: button,
            ),
          ],
  );
}
