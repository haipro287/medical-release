import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/api/certificate_service.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/my_account_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';

class SignupPageController extends GetxController {
  final String correctOtp = '777777';

  TextEditingController userId = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  TextEditingController otp = TextEditingController();

  RxBool confirmActive = false.obs;
  RxBool confirmSuccess = true.obs;

  RxBool userIdGuide = false.obs;
  RxBool mailGuide = false.obs;
  RxBool phoneGuide = false.obs;
  RxBool passwordGuide = false.obs;
  RxBool confirmPasswordFocus = false.obs;

  RxString userIdErr = "".obs;
  RxString mailErr = "".obs;
  RxString phoneErr = "".obs;
  RxString passwordErr = "".obs;
  RxString confirmPasswordErr = "".obs;

  RxBool passwordIsHide = true.obs;
  RxBool confirmPasswordIsHide = true.obs;

  RxString signupError = "".obs;

  final RegExp userIdReg = new RegExp(r'^[A-Za-z0-9]+$');
  final RegExp userIdReg1 = new RegExp(r'[!-/#{-~₫%&/_:-@\[-^]+$');
  final RegExp emailReg = new RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  final RegExp phoneReg = new RegExp(r'^[0-9]+$');
  final RegExp passwordReg0 = new RegExp(r'^[0-9a-zA-Z!-/#{-~₫%&/_:-@\[-^]+$');
  final RegExp passwordReg1 = new RegExp(r'^[0-9]+$');
  final RegExp passwordReg2 = new RegExp(r'^[a-zA-Z]+$');
  final RegExp passwordReg3 = new RegExp(r'^[!-/#{-~₫%&/_:-@\[-^]+$');

  String? otpId;

  void changeHidePassword() {
    passwordIsHide.value = !passwordIsHide.value;
  }

  void changeHideConfirmPassword() {
    confirmPasswordIsHide.value = !confirmPasswordIsHide.value;
  }

  void confirmButtonActive() {
    confirmActive.value = this.otp.text.length == 6;
  }

  Future<bool> otpValidate() async {
    print(this.otp.text);
    confirmSuccess.value = await validateOTP(this.otp.text);
    return confirmSuccess.value;
  }

  bool isValid() {
    var isValid = true;

    userIdErr.value = "";
    mailErr.value = "";
    phoneErr.value = "";
    passwordErr.value = "";
    confirmPasswordErr.value = "";

    // this.email.text = this.email.text.toString().replaceAll(' ', '');
    this.email.text = this.email.text.toString().trimLeft();
    this.email.text = this.email.text.toString().trimRight();

    if (this.userId.text == "") {
      isValid = false;
      userIdErr.value = "ユーザーIDを入力してください。";
    } else if (this.userId.text.contains(' ') ||
        userIdReg1.hasMatch(this.userId.text)) {
      isValid = false;
      userIdErr.value = "ユーザーIDは記号、スペースはご使用いただけません。";
    } else if (!userIdReg.hasMatch(this.userId.text)) {
      isValid = false;
      userIdErr.value = "ユーザーIDは半角英数字で入力してください。";
    }

    if (this.email.text == "") {
      isValid = false;
      mailErr.value = "メールアドレスを入力してください。";
    } else if (!emailReg.hasMatch(this.email.text)) {
      isValid = false;
      mailErr.value = "メールアドレスは正しい形式で入力してください。";
    }

    if (this.phone.text == "") {
      isValid = false;
      phoneErr.value = "電話番号を入力してください。";
    } else if (!phoneReg.hasMatch(this.phone.text)) {
      isValid = false;
      phoneErr.value = "電話番号は半角数字で入力してください。";
    } else if (this.phone.text.length != 10 ||
        this.phone.text.toString()[0] != '0') {
      isValid = false;
      phoneErr.value = "電話番号は正しい値を入力してください。";
    }

    if (this.password.text == "") {
      isValid = false;
      passwordErr.value = "パスワードを入力してください。";
    } else if (!passwordReg0.hasMatch(this.password.text)) {
      isValid = false;
      passwordErr.value = "パスワードは半角英数字で入力してください。";
    } else if (passwordReg1.hasMatch(this.password.text) ||
        passwordReg2.hasMatch(this.password.text) ||
        passwordReg3.hasMatch(this.password.text)) {
      isValid = false;
      passwordErr.value = "パスワードは英字、数字、記号のうち2種類以上を混在させてください。";
    } else if (this.password.text.length < 8 ||
        this.password.text.length > 32) {
      isValid = false;
      passwordErr.value = "パスワードは8～32文字以内で入力してください。";
    }

    if (this.confirmPassword.text == "") {
      isValid = false;
      confirmPasswordErr.value = "再入力パスワードを入力してください。";
    } else if (this.confirmPassword.text != this.password.text) {
      isValid = false;
      confirmPasswordErr.value = "再入力パスワードは合っていません。";
    }

    return isValid;
  }

  void signupErrorMessage(mess) {
    if (mess == "invalid username or existed") {
      userIdErr.value = "ユーザーIDは既に存在しています。";
      return;
    }

    if (mess == "invalid mail or existed") {
      mailErr.value = "メールアドレスは既に存在しています。";
      return;
    }

    if (mess == "invalid phone number or existed") {
      phoneErr.value = "電話番号は既に存在しています。";
      return;
    }
  }

  Future<bool> validateSignupInfo(context) async {
    try {
      var response;
      CustomDio customDio = CustomDio();
      response = await customDio.get("/user/check", {
        "username": userId.text,
        "mail": email.text,
        "phone": phone.text,
      });

      var json = jsonDecode(response.toString());

      print(json);

      if (json["success"] == true) {
        signupError.value = "";
        return true;
      }

      signupError.value = json["error"];
      print(signupError.value);

      signupErrorMessage(signupError.value);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> validateOTP(String otp) async {
    try {
      var response;
      CustomDio customDio = CustomDio();
      response = await customDio.post("/auth/otp", {
        "data": {"otpId": otpId.toString(), "otp": otp}
      });

      var json = jsonDecode(response.toString());

      print(json);

      if (json["success"] == true) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getOTPAgain() async {
    try {
      var response;
      CustomDio customDio = CustomDio();
      response = await customDio.post("/auth/otp/resend", {
        "data": {"id": otpId.toString()}
      });

      var json = jsonDecode(response.toString());

      print(json);
      var data = json["data"];

      if (json["success"] == true) {
        otpId = data["id"];
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future signup() async {
    try {
      var response;
      var keyPair = generateKeyPairAndEncrypt(password.text);
      CustomDio customDio = CustomDio();
      response = await customDio.post(
          "/user",
          {
            "data": {
              "username": userId.text,
              "mail": email.text,
              "phone": phone.text,
              "encryptedPrivateKey": keyPair["encryptedPrivateKey"],
              "publicKey": keyPair["publicKey"],
            },
          },
          sign: false);
      var json = jsonDecode(response.toString());
      print(json);

      var data = json["data"];

      if (json["success"] == true) {
        signupError.value = "";
        otpId = data["otpId"];
        MyAccountController myAccountController =
            Get.put(MyAccountController());

        myAccountController.kanjiName.value = data["kanji"];
        myAccountController.katakanaName.value = data["romanji"];
        myAccountController.dob.value = DateTime.parse(data["birthday"]);
        myAccountController.userName = data["username"];
        myAccountController.email.value = data["mail"];
        myAccountController.phoneNumber.value = data["phone"];
        myAccountController.citizenCode.value = data["pid"];
        myAccountController.phoneVerified = data["isPhoneValidated"];
        myAccountController.emailVerified = data["isMailValidated"];
        return true;
      }

      signupError.value = json["error"];
      print(signupError.value);

      signupErrorMessage(signupError.value);

      return data;
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }
}
