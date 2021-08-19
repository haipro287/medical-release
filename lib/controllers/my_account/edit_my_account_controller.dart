import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/my_account_controller.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';

class EditMyAccountController extends GetxController {
  MyAccountController myAccountController = Get.put(MyAccountController());

  TextEditingController kanjiName = TextEditingController();
  TextEditingController katakanaName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController citizenCode = TextEditingController();
  TextEditingController dob = TextEditingController();
  late DateTime birthday = myAccountController.dob.value;
  late RxInt avatar;
  RxString err = "".obs;

  @override
  void onInit() {
    avatar = myAccountController.avatar.value.obs;
    kanjiName.text = myAccountController.kanjiName.value;
    katakanaName.text = myAccountController.katakanaName.value;
    dob.text = TimeService.dateTimeToString4(myAccountController.dob.value);
    email.text = myAccountController.email.value;
    phone.text = myAccountController.phoneNumber.value;
    citizenCode.text = myAccountController.citizenCode.value;
    super.onInit();
  }

  bool isValid() {
    RegExp kanji = new RegExp(r'[^ -~｡-ﾟ\x00-\x1f\t]+$');
    RegExp katakana = new RegExp(r'^([ァ-ン]|ー)+$');
    RegExp idNumber = new RegExp(r'^[0-9]+$');

    if (this.kanjiName.text == "") {
      this.err.value = '氏名を入力してください。';
      return false;
    }

    if (!kanji.hasMatch(this.kanjiName.text)) {
      this.err.value = '氏名（全角）は全角文字で入力してください。';
      return false;
    }

    if (this.katakanaName.text == "") {
      this.err.value = '氏名（カタカナを入力してください。';
      return false;
    }

    if (!katakana.hasMatch(this.katakanaName.text)) {
      this.err.value = '氏名（カタカナ）はカタカナで入力してください。';
      return false;
    }

    if (this.dob.text == "") {
      this.err.value = '生年月日を入力してください。';
      return false;
    }
    
    if (this.citizenCode.text == "") {
      this.err.value = '住民番号を入力してください。';
      return false;
    }

    if (!idNumber.hasMatch(this.citizenCode.text)) {
      this.err.value = '住民番号は半角英数字で入力してください。';
      return false;
    }

    this.err.value = "";
    return true;
  }
}
