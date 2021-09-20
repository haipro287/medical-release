import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

Container customBoxHeader(text) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFF6F7FB),
      border: Border.all(
        color: Colors.white,
        width: getHeight(1),
      ),
    ),
    height: getHeight(56),
    child: Row(
      children: [
        SizedBox(width: getWidth(15)),
        Text(
          text,
          style: TextStyle(fontSize: getWidth(13)),
        ),
      ],
    ),
    alignment: Alignment.centerLeft,
  );
}

Container customBoxHeaderWithTag(text, Widget widget) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFF6F7FB),
      border: Border.all(
        color: Colors.white,
        width: getHeight(1),
      ),
    ),
    height: getHeight(56),
    child: Row(
      children: [
        SizedBox(width: getWidth(15)),
        Text(
          text,
          style: TextStyle(fontSize: getWidth(13)),
        ),
        SizedBox(width: getWidth(15)),
        widget,
      ],
    ),
    alignment: Alignment.centerLeft,
  );
}
