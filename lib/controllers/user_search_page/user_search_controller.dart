import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';

class UserSearchController extends GetxController {
  GlobalController globalController = Get.put(GlobalController());
  TextEditingController searchInput = TextEditingController();
  TextEditingController nickname = TextEditingController();

  var contactList = [].obs;
  dynamic userData = {}.obs;
  var isEditing = true.obs;
  var nicknameText = "";

  @override
  void onInit() async {
    super.onInit();
  }

  void changeEditStatus() {
    if (isEditing.value) {
      isEditing.value = false;
      nicknameText = nickname.text;
      nickname.clear();
    } else {
      isEditing.value = !isEditing.value;
      // searchInput.value = TextEditingValue(
      //   text: nicknameText,
      //   selection: TextSelection.fromPosition(
      //     TextPosition(offset: nicknameText.length),
      //   ),
      // );
    }
  }

  Future searchUser(String username) async {
    try {
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate;
      response = await customDio.get("/user", {
        "username": username,
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

  Future<dynamic> search() async {
    var data = await searchUser(searchInput.text);
    print(data.toString());

    if (data["id"] != null) {
      userData = data;
      nicknameText = data["secondaryName"];
      searchInput.clear();
      return data;
    }
    userData.value = {"id": "NullID"};
    return null;
  }

  String getHintText() {
    if (userData["romanji"] != null && userData["kanji"] != null) {
      return userData["romanji"] + " (" + userData["kanji"] + ")";
    }
    return "佐藤桜(Sato Sakura)";
  }
}
