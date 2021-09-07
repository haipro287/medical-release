import 'dart:convert';

import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/edit_my_account_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';

class MyAccountController extends GetxController {
  static const avatarList = [0, 0xFFD0E8FF, 0xFFFFF0D1, 0xFFDAD5FF, 0xFFF7EBE8];

  var avatar = avatarList[0].obs;
  String userName = "";
  RxString kanjiName = "".obs;
  RxString katakanaName = "".obs;
  Rx<DateTime> dob = DateTime.parse("0000-00-00T00:00:00Z").obs;
  RxString email = "".obs;
  RxString phoneNumber = "".obs;
  RxString citizenCode = "".obs;

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
      myAccountController.katakanaName.value = userInfo['romanji'] ?? "";
      myAccountController.dob.value = DateTime.parse(userInfo['birthday']);
      myAccountController.email.value = userInfo['mail'] ?? "";
      myAccountController.phoneNumber.value = userInfo['phone'] ?? "";
      myAccountController.citizenCode.value = userInfo['pid'] ?? "";
      myAccountController.avatar.value =
          MyAccountController.avatarList[userInfo["avatar"]];

      print(kanjiName.value);

      return (json["data"]);
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  Future editUserInfo(
      {required String romanji,
      required String kanji,
      required String? birthday,
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
          "romanji": romanji,
          "kanji": kanji,
          "birthday": birthday,
          "mail": mail,
          "phone": phone,
          "pid": pid,
          "avatar": color,
        },
      );
      var json = jsonDecode(response.toString());

      var data = json["data"];
      myAccountController.kanjiName.value = data['kanji'].toString();
      myAccountController.katakanaName.value = data['romanji'].toString();
      myAccountController.dob.value = DateTime.parse(data['birthday']);
      myAccountController.email.value = data['mail'].toString();
      myAccountController.phoneNumber.value = data['phone'].toString();
      myAccountController.citizenCode.value = data['pid'].toString();
      myAccountController.avatar.value =
          MyAccountController.avatarList[data['avatar']];
      return json["data"];
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }
}
