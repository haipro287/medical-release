import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  TextEditingController password = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final RegExp passwordReg0 = new RegExp(r'^[0-9a-zA-Z!@#$%&/=?_.,:;-\\]+$');
  final RegExp passwordReg1 = new RegExp(r'^[0-9]+$');
  final RegExp passwordReg2 = new RegExp(r'^[a-zA-Z]+$');
  final RegExp passwordReg3 = new RegExp(r'^[!@#$%&/=?_.,:;-\\]+$');

  var isHidePassword = false.obs;
  var isHideNewPassword = false.obs;
  var isHideConfirmPassword = false.obs;

  var focusPassword = false.obs;
  var focusNewPassword = false.obs;
  var focusConfirmPassword = false.obs;

  var isSuccess = false.obs;
  var errPassword = "".obs;
  var errNewPassword = "".obs;
  var errConfirmPassword = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  void changeHidePassword() {
    isHidePassword.value = !isHidePassword.value;
  }

  void changeHideNewPassword() {
    isHideNewPassword.value = !isHideNewPassword.value;
  }

  void changeHideConfirmPassword() {
    isHideConfirmPassword.value = !isHideConfirmPassword.value;
  }

  String errMsgNewPassword() {
    var text = newPassword.text;
    if (text == "") {
      return "パスワードを入力してください。";
    } else if (!passwordReg0.hasMatch(text)) {
      return "パスワードは半角英数字で入力してください。";
    } else if (passwordReg1.hasMatch(text) ||
        passwordReg2.hasMatch(text) ||
        passwordReg3.hasMatch(text)) {
      return "パスワードは英字、数字、記号のうち2種類以上を混在させてください。";
    } else if (text.length < 8 || text.length > 32) {
      return "パスワードは8～32文字以内で入力してください。";
    } else {
      return "";
    }
  }

  String errMsgConfirmPassword() {
    var text = newPassword.text;
    var confirmText = confirmPassword.text;
    if (confirmText == "") {
      return "再入力パスワードを入力してください。";
    } else if (text != confirmText) {
      return "再入力パスワードは合っていません。";
    } else {
      return "";
    }
  }

  void changePassword() {
    errNewPassword.value = errMsgNewPassword();
    errConfirmPassword.value = errMsgConfirmPassword();
    if (errNewPassword.value == "" && errConfirmPassword.value == "") {
      // Todo change password api
      print(password.text);
      if (password.text == "123456") {
        isSuccess.value = true;
        errPassword.value = "";
        password.clear();
        newPassword.clear();
        confirmPassword.clear();
      } else {
        errPassword.value = "パスワードが合っていません。";
      }
    }
  }
}
