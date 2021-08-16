import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';

class ContactPageController extends GetxController {
  TextEditingController searchInput = TextEditingController();

  var contactList = [].obs;

  @override
  void onInit() async {
    var response = await getContactList("");
    contactList.value = response;
    searchInput.addListener(() {});
    super.onInit();
  }

  Future getContactList(String searchInput) async {
    try {
      var userID = Get.put(GlobalController()).user.value.id.toString();
      var response;
      CustomDio customDio = CustomDio();
      var certificate = Get.put(GlobalController()).user.value.certificate.toString();
      customDio.dio.options.headers["Authorization"] = certificate;
      response =
          await customDio.get("/user/$userID/contacts", {
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
}
