import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';

class ShareHistoryController extends GetxController {
  PageController pageController =
      PageController(initialPage: 0, keepPage: false);

  GlobalController globalController = Get.put(GlobalController());

  var currentPage = 0.obs;
  TextEditingController searchInput = TextEditingController();

  RxList<dynamic> historyRecords = [].obs;

  var itemSelected = {}.obs;

  @override
  void onInit() async {
    var records = await getRecords("");
    print(records.toString());
    historyRecords.value = records;
    super.onInit();
  }

  void search() async {}

  void onChangeTab(int value) async {
    currentPage.value = value;
    var records;
    if (value == 0) {
      records = await getRecords("");
    } else if (value == 1) {
      records = await getRecords("sharing");
    } else if (value == 2) {
      records = await getRecords("expired");
    } else if (value == 3) {
      records = await getRecords("pending");
    } else if (value == 4) {
      records = await getRecords("rejected");
    }
    print(records.toString());
    historyRecords.value = records;
    pageController
      ..animateToPage(
        value,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
  }

  Future<List<dynamic>> getRecords(String status) async {
    try {
      var userID = globalController.user.value.id.toString();
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      response = await customDio.get("/requests/list?", {
        "primary_id": userID,
        "status": status,
      });
      var json = jsonDecode(response.toString());
      print(json["data"]);
      var list = json["data"];
      List<Map<String, String>> listRecords = [];

      for (var i = 0; i < list.length; i++) {
        print(list[i]);
        Map<String, String> item = {};
        item["id"] = list[i]['id'];
        item["primaryId"] = list[i]['primaryId'];
        item["secondaryId"] = list[i]['secondaryId'];
        item["name"] = list[i]['name'];
        item["username"] = list[i]["username"];
        item["romanji"] = list[i]["romanji"];
        item["kanji"] = list[i]["kanji"];
        item["fromTime"] = list[i]["fromTime"];
        item["endTime"] = list[i]["endTime"];
        item["status"] = list[i]["status"];
        item["service"] = list[i]["service"];
        listRecords.add(item);
      }

      return listRecords;
    } catch (e, s) {
      print(e);
      print(s);
      return [];
    }
  }
}
