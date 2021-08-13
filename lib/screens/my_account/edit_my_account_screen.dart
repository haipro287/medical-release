import 'package:flutter/material.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/my_account_controller.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:get/get.dart';

class EditMyAccountScreen extends StatelessWidget {
  MyAccountController myAccountController = Get.put(MyAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'myAccount'.tr),
      body: Container(
        padding: EdgeInsets.only(top: getHeight(26)),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: getHeight(100),
              width: getWidth(100),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
                shape: BoxShape.circle,
                color: Color(myAccountController.avatar),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
