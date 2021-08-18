import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';

class ShareListController extends GetxController {
  TextEditingController searchInput1 = TextEditingController();
  TextEditingController searchInput2 = TextEditingController();

  RxList<Map<String, String>> contactList = [
    {
      "id": "K_Zaj8IVqO1bWI7lXaO6H",
      "secondaryId": "LNmBW - PTDilttfsVw - NbM",
      "secondaryName": "Template",
      "primaryId": "gZ1bDTd46q8vzxofjOz0w",
      "secondaryUsername": "account1"
    },
    {
      "id": "-F - LbOUewpbZQvvoKNpAh",
      "secondaryId": "XAgxrs9wzKaycOy2Kug1B",
      "secondaryName": "Magic",
      "primaryId": "gZ1bDTd46q8vzxofjOz0w",
      "secondaryUsername": "account2"
    }
  ].obs;

  RxList<Map<String, String>> searchList = [
    {
      "id": "K_Zaj8IVqO1bWI7lXaO6H",
      "secondaryId": "LNmBW - PTDilttfsVw - NbM",
      "secondaryName": "Template",
      "primaryId": "gZ1bDTd46q8vzxofjOz0w",
      "secondaryUsername": "account1"
    },
    {
      "id": "-F - LbOUewpbZQvvoKNpAh",
      "secondaryId": "XAgxrs9wzKaycOy2Kug1B",
      "secondaryName": "Magic",
      "primaryId": "gZ1bDTd46q8vzxofjOz0w",
      "secondaryUsername": "account2"
    }
  ].obs;

  var userSelected = "".obs;
  var userData = {}.obs;

  @override
  void onInit() async {
    var response = await getContactList("");
    print("response: " + response.toString());
    contactList.value = response;
    searchList.value = response;
    super.onInit();
  }

  Future getContactList(String searchInput) async {
    try {
      var userID = Get.put(GlobalController()).user.value.id.toString();
      var response;
      CustomDio customDio = CustomDio();
      var certificate =
          Get.put(GlobalController()).user.value.certificate.toString();
      customDio.dio.options.headers["Authorization"] = certificate;
      response = await customDio.get("/user/$userID/contacts", {
        "offset": 0,
        "limit": 2,
      });
      var json = jsonDecode(response.toString());
      var list = json["data"];
      List<Map<String, String>> res = [];
      for (var i = 0; i < list.length; i++) {
        var item = list[i];
        res.add(item);
      }
      return res;
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  void search() {
    if (searchInput1.text == "") {
      searchList.value = contactList.value;
      searchInput1.clear();
    } else {
      searchList.value = contactList.value
          .where((ele) => ele["username"]!.contains(searchInput1.text))
          .toList();
    }
  }
}
