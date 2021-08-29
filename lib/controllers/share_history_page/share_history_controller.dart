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
  RxList<dynamic> searchList = [].obs;
  var isHideNotiSearch = true.obs;

  var itemSelected = {}.obs;

  @override
  void onInit() async {
    var records = await getRecords(getStatusFromValue(currentPage.value));
    print("current" + currentPage.value.toString());
    historyRecords.value = records;
    searchList.value = records;
    super.onInit();
  }

  void search() {
    print(searchInput.text);
    if (searchInput.text == "") {
      searchList.value = historyRecords.value;
      searchInput.clear();
      isHideNotiSearch.value = true;
    } else {
      isHideNotiSearch.value = false;
      searchList.value = historyRecords.value.where((ele) {
        String pattern = searchInput.text.toLowerCase();
        var listCheck = ["username", "name", "kanji", "romanji"];
        for (int i = 0; i < listCheck.length; i++) {
          if (ele[listCheck[i]]!.toString().toLowerCase().contains(pattern))
            return true;
        }
        return false;
      }).toList();
    }
  }

  String getStatusFromValue(int value) {
    if (value == 0) {
      return ("");
    } else if (value == 1) {
      return ("sharing");
    } else if (value == 2) {
      return ("expired");
    } else if (value == 3) {
      return ("pending");
    } else if (value == 4) {
      return ("rejected");
    } else
      return "";
  }

  void onChangeTab(int value) async {
    if (value != currentPage.value) {
      print("valueeee: " + value.toString());
      currentPage.value = value;
      searchInput.clear();
      isHideNotiSearch.value = true;
      var records;
      var status = getStatusFromValue(value);
      records = await getRecords(status);
      historyRecords.value = records;
      searchList.value = records;
      pageController
        ..animateToPage(
          value,
          duration: Duration(milliseconds: 1000),
          curve: Curves.ease,
        );
    }
  }

  Future<List<Map<String, dynamic>>> getRecords(String status) async {
    try {
      var userID = globalController.user.value.id.toString();
      var mode = globalController.historyStatus.value;
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();

      if (mode == "SENDING_MODE") {
        response = await customDio.get("/requests/list?", {
          "primary_id": userID,
          "status": status,
        });
      } else {
        response = await customDio.get("/requests/list?", {
          "secondary_id": userID,
          "status": status,
        });
      }
      var json = jsonDecode(response.toString());
      var list = json["data"];
      List<Map<String, dynamic>> listRecords = [];

      for (var i = 0; i < list.length; i++) {
        Map<String, dynamic> item = {};
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
        item["services"] = [];
        for (var j = 0; j < list[i]["services"].length; j++) {
          var service = {};
          service["id"] = list[i]["services"][j]["id"];
          service["name"] = list[i]["services"][j]["name"];
          service["icon"] = list[i]["services"][j]["icon"];
          item["services"].add(service);
        }
        listRecords.add(item);
      }
      calculatorTimeOption(list[0]["fromTime"], list[0]["endTime"]);
      return listRecords;
    } catch (e, s) {
      print(e);
      print(s);
      return [];
    }
  }

  void calculatorTimeOption(String fromTime, String endTime) {
    var fromTimeParsed = DateTime.parse(fromTime);
    var endTimeParsed = DateTime.parse(endTime);
    var diffTime = endTimeParsed.difference(fromTimeParsed);
    var hourDiff = diffTime.inHours;
    // TO DO: determine time options: 1 day, 1 week, 1 month or until turn off
    // print(hourDiff.toString());
  }
}
