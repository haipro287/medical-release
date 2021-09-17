import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';

class ContactPageController extends GetxController {
  TextEditingController searchInput = TextEditingController();

  RxList<dynamic> contactList = [].obs;

  RxList<dynamic> searchList = [].obs;

  var category = ''.obs;

  @override
  void onInit() async {
    var response = await getContactList();
    print('response: ' + response.toString());
    super.onInit();
  }

  Future getContactList() async {
    try {
      var userID = Get.put(GlobalController()).user.value.id.toString();
      var response;
      CustomDio customDio = CustomDio();
      var certificate =
          Get.put(GlobalController()).user.value.certificate.toString();
      customDio.dio.options.headers['Authorization'] = certificate;
      response = await customDio.get('/user/$userID/contacts');
      var json = jsonDecode(response.toString());

      var responseData = json['data']['contacts'] ?? [];

      print({'responseData': responseData});

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
        res.add(item);
      }
      res.sort(
          (a, b) => a['secondaryUsername'].compareTo(b['secondaryUsername']));
      contactList.value = res;
      searchList.value = res;
      return res;
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  void search() {
    print(searchInput.text);
    if (searchInput.text == '') {
      searchList.value = contactList.value;
      searchInput.clear();
    } else {
      searchList.value = contactList.value.where((ele) {
        String pattern = searchInput.text.toLowerCase();
        var listCheck = [
          'secondaryUsername',
          'secondaryName',
          'kanji',
          'romanji'
        ];
        for (int i = 0; i < listCheck.length; i++) {
          if (ele[listCheck[i]]!.toString().toLowerCase().contains(pattern))
            return true;
        }
        return false;
      }).toList();
    }
  }

  String newCategory(String character) {
    print(character);
    if (character != category.value) {
      category.value = character;
      return upperFirstString(character);
    }
    return '';
  }
}
