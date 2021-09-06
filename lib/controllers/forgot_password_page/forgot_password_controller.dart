import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final String correctOtp = '777777';

  TextEditingController email = TextEditingController();

  TextEditingController otp = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  RxBool passwordIsHide = true.obs;
  RxBool confirmPasswordIsHide = true.obs;
  RxString passwordErr = "".obs;

  RxString errMess = "".obs;
  RxBool buttonActive = false.obs;

  RxBool resetActive = false.obs;
  RxBool resetSuccess = true.obs;

  final RegExp passwordReg0 = new RegExp(r'^[0-9a-zA-Z!-/#{-~₫%&/_:-@\[-^]+$');
  final RegExp passwordReg1 = new RegExp(r'^[0-9]+$');
  final RegExp passwordReg2 = new RegExp(r'^[a-zA-Z]+$');
  final RegExp passwordReg3 = new RegExp(r'^[!-/#{-~₫%&/_:-@\[-^]+$');
  final RegExp emailReg = new RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

  void changeHidePassword() {
    passwordIsHide.value = !passwordIsHide.value;
  }

  void changeHideConfirmPassword() {
    confirmPasswordIsHide.value = !confirmPasswordIsHide.value;
  }

  void activeButton() {
    buttonActive.value = email.text != "";
  }

  void resetButtonActive() {
    resetActive.value = this.otp.text.length == 6;
  }

  bool otpValidate() {
    print(this.otp.text);
    resetSuccess.value = this.otp.text == correctOtp;
    return resetSuccess.value;
  }

  bool isValid() {
    errMess.value = "";

    if (!emailReg.hasMatch(email.text)) {
      errMess.value = "メールアドレスは不正な値です。";
      return false;
    }

    return true;
  }

  bool isPasswordValid() {
    var isValid = true;

    passwordErr.value = "";

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
    } else if (this.confirmPassword.text == "") {
      isValid = false;
      passwordErr.value = "再入力パスワードを入力してください。";
    } else if (this.confirmPassword.text != this.password.text) {
      isValid = false;
      passwordErr.value = "再入力パスワードは合っていません。";
    }

    return isValid;
  }
}
