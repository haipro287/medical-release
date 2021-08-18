import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ShareListController extends GetxController {
  TextEditingController searchInput1 = TextEditingController();
  TextEditingController searchInput2 = TextEditingController();

  var contactList = [
    {
      "id": "LNmBW-PTDilttfsVw-NbM",
      "username": "account1",
      "phone": "0123456781",
      "mail": "acc1@gmail.com",
      "romanji": "tokuda1",
      "kanji": "田中",
      "secondaryName": "",
    },
    {
      "id": "LNmBW-PTDilttfsVw-NbM",
      "username": "account2",
      "phone": "0123456782",
      "mail": "acc2@gmail.com",
      "romanji": "tokuda2",
      "kanji": "田中",
      "secondaryName": "",
    },
    {
      "id": "LNmBW-PTDilttfsVw-NbM",
      "username": "account3",
      "phone": "0123456783",
      "mail": "acc3@gmail.com",
      "romanji": "tokuda3",
      "kanji": "田中",
      "secondaryName": "",
    },
    {
      "id": "LNmBW-PTDilttfsVw-NbM",
      "username": "account4",
      "phone": "0123456784",
      "mail": "acc4@gmail.com",
      "romanji": "tokuda4",
      "kanji": "田中",
      "secondaryName": "",
    },
  ].obs;

  var userSelected = "".obs;
  var searchList = [].obs;
  var userData = {}.obs;

  @override
  void onInit() async {
    searchList.value = contactList;
    super.onInit();
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
