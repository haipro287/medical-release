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
  RxInt avatar = MyAccountController.avatarList[1].obs;
  RxString kanjiErr = "".obs;
  RxString katakanaErr = "".obs;
  RxString dobErr = "".obs;
  RxString citizenCodeErr = "".obs;
  RxBool signup = true.obs;
  bool changeEmailNotSignUp = false;
  RxString mailErr = "".obs;
  RxString phoneErr = "".obs;

  String? otp;

  @override
  void onInit() {
    avatar.value = myAccountController.avatar.value;
    kanjiName.text = myAccountController.kanjiName.value;
    katakanaName.text = myAccountController.katakanaName.value;
    dob.text = TimeService.dateTimeToString4(myAccountController.dob.value);
    email.text = myAccountController.email.value;
    phone.text = myAccountController.phoneNumber.value;
    citizenCode.text = myAccountController.citizenCode.value;
    super.onInit();
  }

  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }

  @override
  void onClose() {
    print("onclose");
    super.onClose();
  }

  bool isValid() {
    RegExp kanji = new RegExp(r'^([ぁ-ん]+|([ァ-ン]|ー)+|[一-龥])+$');
    RegExp katakana = new RegExp(r'^([ァ-ン]|ー)+$');
    RegExp idNumber = new RegExp(r'^[0-9]+$');
    final RegExp phoneReg = new RegExp(r'^[0-9]+$');
    final RegExp emailReg = new RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

    var isValid = true;

    this.kanjiErr.value = "";
    this.katakanaErr.value = "";

    if (this.kanjiName.text == "") {
      this.kanjiErr.value = '氏名（漢字）を入力してください。';
      isValid = false;
    } else if (!kanji.hasMatch(this.kanjiName.text) ||
        this.kanjiName.text.contains(' ')) {
      this.kanjiErr.value = '氏名（漢字）は全角文字で入力してください。';
      isValid = false;
    }

    if (this.katakanaName.text == "") {
      this.katakanaErr.value = '氏名（カタカナ）を入力してください。';
      isValid = false;
    } else if (!katakana.hasMatch(this.katakanaName.text)) {
      this.katakanaErr.value = '氏名（カタカナ）はカタカナで入力してください。';
      isValid = false;
    }

    if (this.email.text == "") {
      isValid = false;
      mailErr.value = "メールアドレスが入力されていません。";
    } else if (!emailReg.hasMatch(this.email.text)) {
      isValid = false;
      mailErr.value = "登録したメールアドレスの形式に誤りがあります。 正しい形式で入力して下さい。";
    }

    if (this.phone.text == "") {
      isValid = false;
      phoneErr.value = "電話番号が入力されていません。 ";
    } else if (!phoneReg.hasMatch(this.phone.text)) {
      isValid = false;
      phoneErr.value = "電話番号は半角数字のみで、入力して下さい。";
    } else if (this.phone.text.length != 11 ||
        this.phone.text.toString()[0] != '0') {
      isValid = false;
      phoneErr.value = "電話番号の値が不正です。正しい電話番号を入力して下さい。";
    }

    if (this.dob.text == "") {
      this.dobErr.value = '生年月日を入力してください。';
      isValid = false;
    }

    if (this.citizenCode.text == "") {
      this.citizenCodeErr.value = '住民番号を入力してください。';
      isValid = false;
    } else if (!idNumber.hasMatch(this.citizenCode.text)) {
      this.citizenCodeErr.value = '住民番号は半角英数字で入力してください。';
      isValid = false;
    }

    return isValid;
  }
}
