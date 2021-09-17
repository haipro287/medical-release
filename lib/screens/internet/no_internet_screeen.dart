import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/no_internet.svg"),
                SizedBox(
                  height: getHeight(30),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(95)),
                  child: Text(
                    "check_internet_connection".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: getWidth(17)),
                  ),
                )
              ],
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: getHeight(50)),
                child: Text(
                  "Logo",
                  style: TextStyle(
                    fontSize: getWidth(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
