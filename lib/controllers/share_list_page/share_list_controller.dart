import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ShareListController extends GetxController {
  TextEditingController searchInput1 = TextEditingController();
  TextEditingController searchInput2 = TextEditingController();

  var contactList = [].obs;
  var userData = {}.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  Future<dynamic> search() async {
    var fakeData = {"id": "12345XHR", "name": "Alexander"};
    if (searchInput1.text == "trinhvanthuan") {
      userData.value = fakeData;
      searchInput1.clear();
      return fakeData;
    }
    userData.value = {"id": "NullID"};
    return null;
  }

  Future<dynamic> searchById() async {
    var fakeData = {"id": "12345XHR", "name": "Alexander"};
    if (searchInput2.text == "123456") {
      userData.value = fakeData;
      searchInput2.clear();
      return fakeData;
    }
    userData.value = {"id": "NullID"};
    return null;
  }
}
