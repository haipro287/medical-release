import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ShareListController extends GetxController {
  TextEditingController searchInput1 = TextEditingController();
  TextEditingController searchInput2 = TextEditingController();

  var contactList = [
    {
      "longName": "秋原新一 (Akihara Shinichi)",
      "username": "akiharashinichi1",
      "phone": "012312318"
    },
    {
      "longName": "秋原新一 (Asd Basd)",
      "username": "abcd1aw2",
      "phone": "01231231228"
    },
    {
      "longName": "秋原新一 (Asaasd Asd)",
      "username": "assd12",
      "phone": "012312323218"
    },
    {
      "longName": "秋原新一 (Asd Asaasd)",
      "username": "abc21",
      "phone": "012312321118"
    },
    {
      "longName": "秋原新一 (Asaasd Basd)",
      "username": "agfssa",
      "phone": "09931232118"
    },
    {
      "longName": "秋原新一 (Basd Basd)",
      "username": "abassa",
      "phone": "02311231218"
    },
    {
      "longName": "秋原新一 (Asd BasdBasd)",
      "username": "assw",
      "phone": "0431231228"
    },
    {
      "longName": "秋原新一 (Asd BasdBasd)",
      "username": "ass11",
      "phone": "092312318"
    },
    {
      "longName": "秋原新一 (Asd BasdBasd)",
      "username": "abxx",
      "phone": "014312218"
    },
    {
      "longName": "秋原新一 (Asd BasdBasd)",
      "username": "abqw",
      "phone": "012312218"
    },
    {
      "longName": "秋原新一 (Asd BasdBasd)",
      "username": "a2ffas",
      "phone": "022312318"
    },
    {
      "longName": "秋原新一 (Asd BasdBasd)",
      "username": "abbas2",
      "phone": "052312318"
    },
    {
      "longName": "秋原新一 (Asd BasdBasd)",
      "username": "aasddc2",
      "phone": "053312318"
    },
    {
      "longName": "秋原新一 (Asd BasdBasd)",
      "username": "ababda2",
      "phone": "055312318"
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

  Future<dynamic> searchById() async {
    var fakeData = {
      "longName": "秋新一 (Alex Libra)",
      "username": "alexander_libra",
      "phone": "0922999112"
    };
    if (searchInput2.text == "123456") {
      userData.value = fakeData;
      userSelected.value = "alexander_libra";
      searchInput2.clear();
      return fakeData;
    }
    userData.value = {
      "id": "NullID",
      "longName": "",
      "username": "",
      "phone": ""
    };
    return null;
  }
}
