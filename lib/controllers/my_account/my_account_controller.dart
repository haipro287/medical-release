import 'dart:convert';

import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/my_account/edit_my_account_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';

class MyAccountController extends GetxController {
  static const avatarList = [0, 0xFFD0E8FF, 0xFFFFF0D1, 0xFFDAD5FF, 0xFFF7EBE8];

  var avatar = avatarList[0].obs;
  String userName = "hang1234";
  RxString kanjiName = "佐藤桜".obs;
  RxString katakanaName = "Sato Sakura".obs;
  Rx<DateTime> dob = DateTime.parse("0001-01-01T00:00:00Z").obs;
  RxString email = "hang@gmail.com".obs;
  RxString phoneNumber = "09876543".obs;
  RxString citizenCode = "1234567".obs;

  bool emailVerified = true;
  bool phoneVerified = true;

  GlobalController globalController = Get.put(GlobalController());

  Future<Map> getUserInfo() async {
    try {
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
      return (json["data"]);
    } catch (e, s) {
      print(e);
      print(s);
      return {};
    }
  }

  Future<Map> editUserInfo(
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
      return (json["data"]);
    } catch (e, s) {
      print(e);
      print(s);
      return {};
    }
  }
}
