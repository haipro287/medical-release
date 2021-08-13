import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

Text myAccountText(String text) {
  return Text(
    text,
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
        children: [left, right],
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
