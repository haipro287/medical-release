import 'dart:convert';

import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';

class ShareServiceListController extends GetxController {
  GlobalController globalController = Get.put(GlobalController());

  var checkList = [].obs;
  var timeSelected = 0.obs;

  var fromTime;
  var endTime;

  List<Map<String, dynamic>> timeList = [
    {"value": 0, "name": "1週間"},
    {"value": 1, "name": "1か月"},
    {"value": 2, "name": "オフにするまで"}
  ];

  RxList<Map<String, dynamic>> serviceList = [
    {
      "username": "",
      "name": "Google",
      "url": "google.com",
      "id": "123",
      "connected": false
    },
    {
      "username": "",
      "name": "facebook",
      "url": "facebook.com",
      "id": "234",
      "connected": false
    },
    {
      "username": "",
      "name": "Twitter",
      "url": "twitter.com",
      "id": "345",
      "connected": false
    }
  ].obs;

  @override
  void onInit() async {
    super.onInit();
  }

  String getFormatTimeCal() {
    Duration expired = timeList[timeSelected.value]["value"] == 0
        ? Duration(days: 1)
        : Duration(days: 30);
    String selectedTime = timeList[timeSelected.value]["name"];
    String calTime =
        TimeService.stringToDJP(TimeService.getTimeNow().add(expired));

    fromTime = TimeService.timeToBackEnd(TimeService.getTimeNow());
    endTime = TimeService.timeToBackEnd(TimeService.getTimeNow().add(expired));

    if (timeList[timeSelected.value]["value"] == 2) return selectedTime;
    return selectedTime + " (" + calTime + ")";
  }

  Future shareService(
      {required String id, required String sharingStatus}) async {
    try {
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      List<String> services = [];
      for (int i = 0; i < serviceList.length; i++) {
        var id = serviceList[i]["id"];
        services.add(id);
      }

      if (sharingStatus == "SENT_DATA") {
        response = await customDio.post("/request/share", {
          "data": {
            "secondaryId": id,
            "services": services,
            "fromTime": fromTime,
            "endTime": endTime,
          }
        });
      } else {
        response = await customDio.post("/request/ask", {
          "data": {
            "primaryId": id,
            "services": services,
            "fromTime": fromTime,
            "endTime": endTime,
          }
        });
      }

      var json = jsonDecode(response.toString());
      print(json.toString());
      return (json["data"]);
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }
}
