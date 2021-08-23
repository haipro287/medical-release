import 'package:flutter/cupertino.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

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
