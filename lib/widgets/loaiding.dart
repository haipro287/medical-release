import 'package:flutter/material.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/spinning.dart';

Widget loading() {
  return Spinning(
    child: Image.asset(
      "assets/images/loading.png",
      width: getWidth(40),
    ),
  );
}
