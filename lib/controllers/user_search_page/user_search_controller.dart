import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/contact_page/contact_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_list_page/share_list_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';

class UserSearchController extends GetxController {
  GlobalController globalController = Get.put(GlobalController());
  ContactPageController contactPageController =
      Get.put(ContactPageController());
  ShareListController shareListController = Get.put(ShareListController());
  TextEditingController searchInput = TextEditingController();
  TextEditingController nickname = TextEditingController();

  var userData = {}.obs;
  var isEditing = false.obs;

  @override
  void onInit() async {
    nickname.text = userData["secondaryName"] ?? "";
    super.onInit();
  }

  bool isFriend() {
    var res = contactPageController.contactList
        .where((e) => e["primaryId"] == userData["primaryId"]);
    return res.length > 0;
  }

  void refetchList(var newContactList) {
    contactPageController.contactList.value = newContactList;
    shareListController.contactList.value = newContactList;
    contactPageController.searchList.value = newContactList;
    shareListController.searchList.value = newContactList;
  }

  Future changeEditStatus() async {
    print("userData:" + userData.toString());
    if (isEditing.value) {
      nickname.text = getWithoutSpaces(nickname.text);
      if (nickname.text.length > 0) {
        var a = await editUserInfo(
            nickname: nickname.text, contactID: userData["id"]);
        print("a: " + a.toString());
        userData["secondaryName"] = a["secondaryName"] ?? nickname.text;
        var newContactList = await contactPageController.getContactList();
        refetchList(newContactList);
      } else {
        print('0');
      }
      isEditing.value = false;
    } else {
      nickname.text = userData["secondaryName"];
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
      print("searchUser: " + json.toString());
      return (json["data"]["results"])[0];
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
    var userIfExist = contactPageController.contactList
        .where((e) => e["secondaryUsername"] == searchInput.text)
        .toList();
    var data = await searchUser(searchInput.text);
    print("searchData:" + data.toString());
    try {
      if (userIfExist.length > 0) {
        userData.value = userIfExist[0];
        searchInput.clear();
        return userIfExist[0];
      } else if (data["id"] != null) {
        var contactData =
            await createContact(secondaryId: data["id"], nickname: "");
        print('createContact: ' + contactData.toString());
        userData.value = {
          ...data,
          ...contactData,
          "secondaryUsername": data["username"]
        };
        var newContactList = await contactPageController.getContactList();
        refetchList(newContactList);

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
      return (json["data"]);
    } catch (e, s) {
      print(e);
      print(s);
      return {};
    }
  }

  Future deleteContact() async {
    try {
      var userID = globalController.user.value.id.toString();
      var contactID = userData["id"];
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      print(contactID);
      response = await customDio.delete(
        "/user/$userID/contact/$contactID",
        {
          "data": {
            "id": contactID,
          }
        },
      );
      var json = jsonDecode(response.toString());

      if (json["success"] == true) {
        var newContactList = await contactPageController.getContactList();
        refetchList(newContactList);
      }
      return (json["data"]);
    } catch (e, s) {
      print(e);
      print(s);
      return {};
    }
  }
}
