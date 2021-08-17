import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';

class ContactPageController extends GetxController {
  TextEditingController searchInput = TextEditingController();

  var contactList = [
    {"longName": "秋原新一 (Akihara Shinichi)", "username": "akiharashinichi1"},
    {"longName": "秋原新一 (Asd Basd)", "username": "abcd1aw2"},
    {"longName": "秋原新一 (Asaasd Asd)", "username": "assd12"},
    {"longName": "秋原新一 (Asd Asaasd)", "username": "abc21"},
    {"longName": "秋原新一 (Asaasd Basd)", "username": "agfssa"},
    {"longName": "秋原新一 (Basd Basd)", "username": "abassa"},
    {"longName": "秋原新一 (Asd BasdBasd)", "username": "assw"},
    {"longName": "秋原新一 (Asd BasdBasd)", "username": "ass11"},
    {"longName": "秋原新一 (Asd BasdBasd)", "username": "abxx"},
    {"longName": "秋原新一 (Asd BasdBasd)", "username": "abqw"},
    {"longName": "秋原新一 (Asd BasdBasd)", "username": "a2ffas"},
    {"longName": "秋原新一 (Asd BasdBasd)", "username": "abbas2"},
    {"longName": "秋原新一 (Asd BasdBasd)", "username": "aasddc2"},
    {"longName": "秋原新一 (Asd BasdBasd)", "username": "ababda2"},
  ].obs;
  var searchList = [].obs;

  @override
  void onInit() async {
    // var response = await getContactList("");
    // contactList.value = response;
    searchList.value = contactList;
    searchInput.addListener(() {});
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
      print(json.toString());
      return (json["data"]);
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  void search() {
    if (searchInput.text == "") {
      searchList.value = contactList.value;
      searchInput.clear();
    } else {
      searchList.value = contactList.value.where((ele) => ele["username"]!.contains(searchInput.text)).toList();
    }
  }
}
