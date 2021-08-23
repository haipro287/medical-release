import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';

class ShareListController extends GetxController {
  TextEditingController searchInput1 = TextEditingController();
  TextEditingController searchInput2 = TextEditingController();

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
      response = await customDio.get("/user/$userID/contacts");
      var json = jsonDecode(response.toString());

      var responseData = json["data"];

      print(responseData[0]["phone"]);

      List<Map<dynamic, dynamic>> res = [];

      for (int i = 0; i < responseData.length; i++) {
        Map<dynamic, dynamic> item = {};
        item["phone"] = responseData[i]["phone"];
        item["id"] = responseData[i]["id"];
        item["secondaryId"] = responseData[i]["secondaryId"];
        item["secondaryName"] = responseData[i]["secondaryName"] ?? "";
        item["primaryId"] = responseData[i]["primaryId"];
        item["secondaryUsername"] = responseData[i]["secondaryUsername"];
        item["romanji"] = responseData[i]["romanji"];
        item["kanji"] = responseData[i]["kanji"];
        res.add(item);
      }
      res.sort(
          (a, b) => a["secondaryUsername"].compareTo(b["secondaryUsername"]));
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
          "romanji"
        ];
        for (int i = 0; i < listCheck.length; i++) {
          if (ele[listCheck[i]]!.toString().toLowerCase().contains(pattern))
            return true;
        }
        return false;
      }).toList();
    }
  }

  String getHintText(dynamic userData) {
    if (userData["romanji"] != null && userData["kanji"] != null) {
      return userData["kanji"] + " (" + userData["romanji"] + ")";
    }
    return "佐藤桜(Sato Sakura)";
  }
}
