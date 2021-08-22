import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/contact_page/contact_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';

class UserSearchController extends GetxController {
  GlobalController globalController = Get.put(GlobalController());
  ContactPageController contactPageController =
      Get.put(ContactPageController());
  TextEditingController searchInput = TextEditingController();
  TextEditingController nickname = TextEditingController();

  var userData = {}.obs;
  var isEditing = true.obs;

  @override
  void onInit() async {
    nickname.text = userData["secondaryName"];
    // nickname.value = userData["secondaryName"];
    super.onInit();
  }

  bool isFriend() {
    var res = contactPageController.contactList
        .where((e) => e["primaryId"] == userData["primaryId"]);
    return res.length > 0;
  }

  Future changeEditStatus() async {
    print("userData:" + userData.toString());
    if (isEditing.value) {
      var a = await editUserInfo(
          nickname: nickname.text, contactID: userData["id"]);
      print("a: " + a.toString());
      userData["secondaryName"] = a["secondaryName"] ?? nickname.text;
      isEditing.value = false;
      contactPageController.contactList.value =
          await contactPageController.getContactList();
    } else {
      nickname.text = userData["secondaryName"];
      // nickname.value = userData["secondaryName"];
      isEditing.value = !isEditing.value;
    }
  }

  Future<dynamic> searchUser(String username) async {
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
      return {};
    }
  }

  Future<dynamic> search() async {
    if (searchInput.text == "") {
      userData.value = {"id": "NullID"};
      print(userData["id"]);
      return null;
    }
    var data = await searchUser(searchInput.text);
    print("searchData:" + data.toString());
    try {
      if (data["id"] != null) {
        var contactData =
            await createContact(secondaryId: data["id"], nickname: "");
        print('createContact: ' + contactData.toString());
        userData.value = {...data, ...contactData};
        contactPageController.contactList.value =
            await contactPageController.getContactList();
        searchInput.clear();
        return data;
      } else {
        userData.value = {"id": "NullID"};
        print(userData["id"]);
        return null;
      }
    } catch (e, s) {
      userData.value = {"id": "NullID"};
      print(userData["id"]);
      return null;
    }
  }

  String getHintText() {
    if (userData["romanji"] != null && userData["kanji"] != null) {
      return userData["kanji"] + " (" + userData["romanji"] + ")";
    }
    return "佐藤桜(Sato Sakura)";
  }

  Future<Map> editUserInfo({
    required String nickname,
    required String contactID,
  }) async {
    try {
      var userID = globalController.user.value.id.toString();
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      response = await customDio.put(
        "/user/$userID/contact/$contactID",
        {
          "secondaryName": nickname,
        },
      );
      var json = jsonDecode(response.toString());
      print(json["data"].toString());
      return (json["data"]);
    } catch (e, s) {
      print(e);
      print(s);
      return {};
    }
  }

  Future<Map> createContact({
    required String nickname,
    required String secondaryId,
  }) async {
    try {
      var userID = globalController.user.value.id.toString();
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      response = await customDio.post(
        "/user/$userID/contact",
        {
          "data": {
            "secondaryId": secondaryId,
            "secondaryName": nickname,
          }
        },
      );
      var json = jsonDecode(response.toString());
      print(json["data"].toString());
      return (json["data"]);
    } catch (e, s) {
      print(e);
      print(s);
      return {};
    }
  }
}
