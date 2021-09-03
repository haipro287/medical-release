import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/share_service_list_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';
import 'package:medical_chain_mobile_ui/screens/share_data_page/share_list_service.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/sharing_history_page.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';
import 'package:medical_chain_mobile_ui/widgets/dialog.dart';

class ShareHistoryController extends GetxController {
  PageController pageController =
      PageController(initialPage: 0, keepPage: false);

  GlobalController globalController = Get.put(GlobalController());

  TextEditingController searchInput = TextEditingController();

  RxList<dynamic> historyRecords = [].obs;
  RxList<dynamic> searchList = [].obs;
  var isHideNotiSearch = true.obs;

  var itemSelected = {}.obs;
  var servicesNotConnect = [].obs;

  @override
  void onInit() async {
    var currentPage = globalController.recordsTabMode.value;
    var records = await getRecords(getStatusFromValue(currentPage));
    historyRecords.value = records;
    searchList.value = records;

    // globalController.recordsTabMode.listen((value) async {
    //   print("statuss: " + getStatusFromValue(value));
    //   var records = await getRecords(getStatusFromValue(currentPage));
    //   historyRecords.value = records;
    //   searchList.value = records;
    // });

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
    print("value: " + value.toString());
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
    var currentPage = globalController.recordsTabMode.value;
    if (value != currentPage) {
      globalController.recordsTabMode.value = value;
      searchInput.clear();
      isHideNotiSearch.value = true;
      var records;
      var status = getStatusFromValue(value);
      records = await getRecords(status);
      historyRecords.value = records;
      searchList.value = records;
      pageController..jumpToPage(value);
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
        item["servicesId"] = [];
        for (var j = 0; j < list[i]["services"].length; j++) {
          var service = {};
          service["id"] = list[i]["services"][j]["id"];
          service["name"] = list[i]["services"][j]["name"];
          service["icon"] = list[i]["services"][j]["icon"];
          item["services"].add(service);
          item["servicesId"].add(service["id"]);
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

  Future sharingService(
    BuildContext? context, {
    required String status,
  }) async {
    var redirectToNewTab = false;
    var value = 0;
    var recordID = itemSelected.value["id"];
    try {
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();

      if (status == "STOP_SHARING") {
        value = 2;
        response = await customDio.post(
          '/request/stop',
          {
            "data": {
              "id": recordID,
              "endTime":
                  TimeService.timeToBackEndMaster(TimeService.getTimeNow())
            },
          },
        );
      } else if (status == "APPROVE_REQUEST") {
        value = 1;
        redirectToNewTab = true;
        response = await customDio.post(
          '/request/accept',
          {
            "data": {
              "id": recordID,
              "services": itemSelected.value["servicesId"],
            },
          },
        );
      } else if (status == "EDIT") {
        value = 1;
        var url = "/request/edit";
      } else if (status == "REJECTED_REQUEST") {
        redirectToNewTab = true;
        value = 4;
        response = await customDio.post(
          "/request/deny",
          {
            "data": {"id": recordID},
          },
        );
      }

      var json = jsonDecode(response.toString());

      if (json["success"] == true) {
        globalController.recordsTabMode.value = value;
        var records = await getRecords(getStatusFromValue(value));
        historyRecords.value = records;
        searchList.value = records;
        print("redirect: " + redirectToNewTab.toString());
        if (redirectToNewTab) {
          Get.to(() => ShareHistoryPage());
        }
      } else if (json["success"] == false && status == "APPROVE_REQUEST") {
        handleApproveRequest(json, context as BuildContext);
      }

      return (json["success"]);
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  void handleApproveRequest(json, BuildContext context) {
    var servicesNotConnectedData = json["data"]["services"];
    var servicesNotConnectedList = [];
    for (var j = 0; j < servicesNotConnectedData.length; j++) {
      var service = {};
      service["id"] = servicesNotConnectedData[j]["id"];
      service["name"] = servicesNotConnectedData[j]["name"];
      service["icon"] = servicesNotConnectedData[j]["icon"];
      servicesNotConnectedList.add(service);
    }
    servicesNotConnect.value = servicesNotConnectedList;
    CustomDialog(context, "SERVICES_NOT_CONNECT")
        .show({"servicesList": servicesNotConnect.value});
  }

  void editToShare(String type, [String? optionType]) {
    Map<String, dynamic> userData = {};
    userData["id"] = itemSelected['id'];
    if (globalController.historyStatus.value == "SENDING_MODE") {
      userData["primaryId"] = itemSelected['primaryId'];
      userData["secondaryId"] = itemSelected['secondaryId'];
    } else {
      userData["primaryId"] = itemSelected['secondaryId'];
      userData["secondaryId"] = itemSelected['primaryId'];
    }
    userData["name"] = itemSelected['name'];
    userData["secondaryUsername"] = itemSelected["username"];
    userData["romanji"] = itemSelected["romanji"];
    userData["kanji"] = itemSelected["kanji"];
    print("itemSeeee: " + itemSelected["id"]);
    print("itemSeeee: " + itemSelected["secondaryId"]);
    print("itemSeeee: " + itemSelected["primaryId"]);
    globalController.sharingStatus.value = type;
    Get.put(UserSearchController()).userData.value = userData;
    Get.put(ShareServiceListController()).checkList.value =
        itemSelected["services"];
    globalController.editToShareMode.value = optionType ?? "";
    Get.to(() => ShareListService());
  }
}
