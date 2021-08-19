import 'package:flutter/material.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/edit_my_account_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/my_account_controller.dart';
import 'package:medical_chain_mobile_ui/screens/my_account/my_account_components.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';

class EditMyAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditMyAccountController editMyAccountController =
        Get.put(EditMyAccountController());
    MyAccountController myAccountController = Get.put(MyAccountController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context, 'myAccount'.tr),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        reverse: true,
        child: Container(
          padding: EdgeInsets.only(
            top: getHeight(26),
            left: getWidth(16),
            right: getWidth(16),
          ),
          // width: double.infinity,
          // height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                return Container(
                  margin: EdgeInsets.only(bottom: getHeight(18)),
                  height: getHeight(100),
                  width: getWidth(100),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    ),
                    shape: BoxShape.circle,
                    color: Color(editMyAccountController.avatar.value),
                  ),
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  colorButton(0xFFD0E8FF),
                  colorButton(0xFFFFF0D1),
                  colorButton(0xFFDAD5FF),
                  colorButton(0xFFF7EBE8),
                ],
              ),
              SizedBox(
                height: getHeight(24),
              ),
              inputWithHint(
                context,
                hintText: "山田太郎",
                labelText: 'editName'.tr,
                initialText: myAccountController.fullName.value,
                textEditingController: editMyAccountController.name,
              ),
              SizedBox(
                height: getHeight(12),
              ),
              inputWithHint(
                context,
                hintText: "Yamada Taro",
                labelText: 'editAlphabetName'.tr,
                initialText: myAccountController.alphabetName.value,
                textEditingController: editMyAccountController.alphabetName,
              ),
              SizedBox(
                height: getHeight(12),
              ),
              inputDate(
                context,
                hintText: "山田太郎",
                labelText: 'dob'.tr,
                textEditingController: editMyAccountController.dob,
              ),
              SizedBox(
                height: getHeight(12),
              ),
              inputWithHint(
                context,
                hintText: "山田太郎",
                labelText: 'email'.tr,
                initialText: myAccountController.email.value,
                textEditingController: editMyAccountController.email,
              ),
              SizedBox(
                height: getHeight(12),
              ),
              inputWithHint(
                context,
                hintText: "山田太郎",
                labelText: 'phoneNumber'.tr,
                initialText: myAccountController.phoneNumber.value,
                textEditingController: editMyAccountController.phone,
              ),
              SizedBox(
                height: getHeight(12),
              ),
              inputWithHint(
                context,
                hintText: "123456789012",
                labelText: 'citizenCode'.tr,
                initialText: myAccountController.citizenCode.value,
                textEditingController: editMyAccountController.citizenCode,
              ),
              SizedBox(
                height: getHeight(12),
              ),
              Obx(() {
                if (editMyAccountController.err.value) {
                  return Text(
                    'マイアカウント',
                    style: TextStyle(color: Colors.red),
                  );
                } else
                  return Container();
              }),
              SizedBox(
                height: getHeight(12),
              ),
              Row(
                children: [
                  Bouncing(
                    child: Container(
                      alignment: Alignment.center,
                      height: getHeight(48),
                      width: getWidth(116),
                      child: myAccountText('cancel'.tr),
                      decoration: BoxDecoration(
                        color: Color(0xFFE9E9E9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPress: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    width: getWidth(8),
                  ),
                  Bouncing(
                    child: Container(
                      alignment: Alignment.center,
                      height: getHeight(48),
                      width: getWidth(219),
                      child: myAccountText('save'.tr),
                      decoration: BoxDecoration(
                        color: Color(0xFFD0E8FF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPress: () {
                      if (editMyAccountController.isValid()) {
                        editMyAccountController.err.value = false;
                        myAccountController.editUserInfo(
                          kanji: editMyAccountController.name.text,
                          romanji: editMyAccountController.alphabetName.text,
                          mail: editMyAccountController.email.text,
                          birthday: TimeService.timeToBackEnd(
                              editMyAccountController.birthday),
                          pid: editMyAccountController.citizenCode.text,
                          phone: editMyAccountController.phone.text,
                        );
                        Get.back();
                      } else {
                        editMyAccountController.err.value = true;
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
