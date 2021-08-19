import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/edit_my_account_controller.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';

Text myAccountText(String text) {
  return Text(
    text,
    overflow: TextOverflow.visible,
    style: TextStyle(
        color: Color(0xFF22262B),
        fontSize: getWidth(17),
        fontWeight: FontWeight.w400),
  );
}

Column myAccountField(Widget left, Widget right) {
  return Column(
    children: [
      Row(
        children: [
          left,
          Container(
            width: getWidth(150),
            child: right,
            alignment: Alignment.centerRight,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      Container(
        padding: EdgeInsets.only(
          top: getHeight(12),
          bottom: getHeight(12),
        ),
        child: SvgPicture.asset(
          'assets/images/separate_line.svg',
          width: getWidth(303),
        ),
      ),
    ],
  );
}

Container verifiedIcon(bool isVerified) {
  return Container(
    decoration: BoxDecoration(
      color: Color(isVerified ? 0xFF74B566 : 0xFFEB5757),
      borderRadius: BorderRadius.circular(2),
    ),
    width: getWidth(54),
    height: getHeight(20),
    alignment: Alignment.center,
    child: Text(
      'Verified',
      style: TextStyle(
        color: Colors.white,
        fontSize: getWidth(13),
      ),
    ),
  );
}

Bouncing colorButton(int color) {
  EditMyAccountController editMyAccountController =
      Get.put(EditMyAccountController());

  return Bouncing(
    onPress: () {
      editMyAccountController.avatar.value = color;
    },
    child: Obx(() => Container(
          padding: EdgeInsets.only(
            top: getHeight(10),
            left: getWidth(8),
            bottom: getHeight(10),
            right: getWidth(8),
          ),
          margin: EdgeInsets.only(
            left: getWidth(6),
            right: getWidth(6),
          ),
          width: getWidth(36),
          height: getHeight(36),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(color),
          ),
          child: editMyAccountController.avatar.value == color
              ? SvgPicture.asset(
                  'assets/images/tick-icon.svg',
                  color: Colors.white,
                )
              : Container(),
        )),
  );
}
