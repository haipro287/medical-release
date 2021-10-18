import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';

class ShareListController extends GetxController {
  TextEditingController searchInput1 = TextEditingController();
  TextEditingController searchInput2 = TextEditingController();
  static const avatarList = [0, 0xFFD0E8FF, 0xFFFFF0D1, 0xFFDAD5FF, 0xFFF7EBE8];

  RxList<dynamic> contactList = [].obs;

  RxList<dynamic> searchList = [].obs;

  var userSelected = "".obs;
  var userData = {}.obs;

  @override
  void onInit() async {
    dynamic response = await getContactList();
    print("response: " + response.toString());
    super.onInit();
  }

  Future getContactList() async {
    try {
      var userID = Get.put(GlobalController()).user.value.id.toString();
      var response;
      CustomDio customDio = CustomDio();
      var certificate =
          Get.put(GlobalController()).user.value.certificate.toString();
      customDio.dio.options.headers["Authorization"] = certificate;
      response = await customDio.get("/users/$userID/contacts");

      var json = jsonDecode(response.toString());

      var responseData = json['data']['results'];

      List<Map<dynamic, dynamic>> res = [];

      for (int i = 0; i < responseData.length; i++) {
        Map<dynamic, dynamic> item = {};
        print({'item': responseData[i]});
        item['phone'] = responseData[i]['phone'] ?? '';
        item['id'] = responseData[i]['id'] ?? '';
        item['secondaryId'] = responseData[i]['secondaryId'] ?? '';
        item['secondaryName'] = responseData[i]['secondaryName'] ?? '';
        item['primaryId'] = responseData[i]['primaryId'] ?? '';
        item['secondaryUsername'] = responseData[i]['secondaryUsername'] ?? '';
        item['katakana'] = responseData[i]['katakana'] ?? '';
        item['kanji'] = responseData[i]['kanji'] ?? '';
        item['avatar'] = avatarList[responseData[i]['avatar']];

        res.add(item);
      }
      res.sort(
          (a, b) => a["secondaryUsername"].compareTo(b["secondaryUsername"]));

      print({"aaaaaa": res});
      contactList.value = res;
      searchList.value = res;
      return res;
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  void search() async {
    if (searchInput1.text == "") {
      searchList.value = contactList.value;
      searchInput1.clear();
    } else {
      searchList.value = contactList.value.where((ele) {
        String pattern = searchInput1.text.toLowerCase();
        var listCheck = [
          "secondaryUsername",
          "secondaryName",
          "kanji",
          "katakana"
        ];
        for (int i = 0; i < listCheck.length; i++) {
          if (ele[listCheck[i]]!.toString().toLowerCase().contains(pattern))
            return true;
        }
        return false;
      }).toList();
    }
  }
}
