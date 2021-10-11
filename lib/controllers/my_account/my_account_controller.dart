import 'dart:convert';

import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/edit_my_account_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/signup_page/signup_page_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';

class MyAccountController extends GetxController {
  static const avatarList = [0, 0xFFD0E8FF, 0xFFFFF0D1, 0xFFDAD5FF, 0xFFF7EBE8];

  var avatar = avatarList[0].obs;
  String userName = Get.put(GlobalController()).user.value.username ?? "";
  RxString kanjiName = "".obs;
  RxString katakanaName = "".obs;
  Rx<DateTime> dob = DateTime.now().obs;
  RxString email = "".obs;
  RxString phoneNumber = "".obs;
  RxString citizenCode = "".obs;
  RxString editError = "".obs;
  RxString mailErr = "".obs;
  RxString phoneErr = "".obs;

  bool emailVerified = true;
  bool phoneVerified = true;

  GlobalController globalController = Get.put(GlobalController());

  Future getUserInfo() async {
    try {
      MyAccountController myAccountController = Get.put(MyAccountController());

      var userID = globalController.user.value.id.toString();
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      response = await customDio.get("/user/$userID/my-account");
      var json = jsonDecode(response.toString());
      print(json.toString());
      print(userID);
      print(globalController.user.value.certificate.toString());
      var userInfo = json["data"];

      myAccountController.userName = userInfo['username'] ?? "";
      myAccountController.kanjiName.value = userInfo['kanji'] ?? "";
      myAccountController.katakanaName.value = userInfo['katakana'] ?? "";
      myAccountController.dob.value =
          TimeService.stringToDateTime(userInfo["birthday"])!;
      myAccountController.email.value = userInfo['mail'] ?? "";
      myAccountController.phoneNumber.value = userInfo['phone'] ?? "";
      myAccountController.citizenCode.value = userInfo['pid'] ?? "";
      myAccountController.avatar.value =
          MyAccountController.avatarList[userInfo["avatar"]];

      Get.put(GlobalController()).user.value.username =
          myAccountController.userName;
      Get.put(GlobalController()).user.value.kanji =
          myAccountController.kanjiName.value;
      Get.put(GlobalController())
          .db
          .put("user", Get.put(GlobalController()).user.value);

      print(kanjiName.value);

      return (json["data"]);
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  Future requestMailOTP(String mail) async {
    var response;
    CustomDio customDio = CustomDio();
    customDio.dio.options.headers["Authorization"] =
        globalController.user.value.certificate.toString();
    response = await customDio.post(
      "/auth/mail",
      {
        "data": {
          "mail": mail,
        }
      },
    );
    var json = jsonDecode(response.toString());
    if (json["success"] == true) {
      var data = json["data"];
      editError.value = "";
      print(data);
      Get.put(SignupPageController()).otpId = data["otpId"];
      return data["otpId"];
    } else {
      editError.value = json["error"];
      signupErrorMessage(editError.value);
      return "";
    }
  }

  void signupErrorMessage(mess) {
    if (mess == "ERROR.API.MAIL_EXISTED") {
      Get.put(EditMyAccountController()).mailErr.value =
          "登録されたメールアドレスは、既に登録されています。";
      return;
    }

    if (mess == "ERROR.AUTH.USER_CREDENTIAL.PHONE_EXISTED") {
      Get.put(EditMyAccountController()).phoneErr.value =
          "登録された電話番号は、既に登録されています。";
      return;
    }
    if (mess == "ERROR.USER.PID_EXISTED") {
      Get.put(EditMyAccountController()).citizenCodeErr.value =
          "入力された住民番号は、既に登録されています。";
      return;
    }
  }

  Future editUserInfo(
      {required String romanji,
      required String kanji,
      required int? birthday,
      required String mail,
      required String phone,
      required String pid,
      required int avatar}) async {
    try {
      MyAccountController myAccountController = Get.put(MyAccountController());
      var color = MyAccountController.avatarList.indexOf(avatar);
      print("new:" + color.toString());
      var userID = globalController.user.value.id.toString();
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      response = await customDio.put(
        "/user/$userID/my-account",
        {
          "data": {
            "katakana": romanji,
            "kanji": kanji,
            "birthday": birthday,
            "mail": mail,
            "phone": phone,
            "pid": pid,
            "avatar": color,
          }
        },
      );
      var json = jsonDecode(response.toString());
      if (json["success"] == true) {
        var data = json["data"];
        editError.value = "";
        print(data);

        myAccountController.kanjiName.value = data['kanji'].toString();
        myAccountController.katakanaName.value = data['katakana'].toString();
        myAccountController.dob.value =
            DateTime.fromMicrosecondsSinceEpoch(data['birthday'] * 1000);
        myAccountController.email.value = data['mail'].toString();
        myAccountController.phoneNumber.value = data['phone'].toString();
        myAccountController.citizenCode.value = data['pid'].toString();
        myAccountController.avatar.value =
            MyAccountController.avatarList[data['avatar']];
        return json["data"];
      } else {
        editError.value = json["error"];
        signupErrorMessage(editError.value);
        return "";
      }
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }
}
