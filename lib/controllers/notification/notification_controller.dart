import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_screen.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/detail_history_page.dart';
import 'package:medical_chain_mobile_ui/services/local_notification_service.dart';
import 'package:medical_chain_mobile_ui/utils/utils.dart';

class NotificationController extends GetxController {
  GlobalController globalController = Get.put(GlobalController());
  static const avatarList = [0, 0xFFD0E8FF, 0xFFFFF0D1, 0xFFDAD5FF, 0xFFF7EBE8];

  @override
  Future<void> onInit() async {
    // TODO: implement onInit

    //background but kill
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        await notiAction(message.data["id"]);
      }
    });

    //foreground
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.body);
      print(message.notification!.title);
      LocalNotificationService.display(message);
    });

    //background but opened
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      await notiAction(message.data["id"]);
    });

    super.onInit();
  }

  Future<dynamic> getRequest({required String id}) async {
    CustomDio customDio = CustomDio();
    customDio.dio.options.headers["Authorization"] =
        globalController.user.value.certificate.toString();
    var response = await customDio.get("/requests/$id");
    print(response);
    var json = jsonDecode(response.toString());
    var list = json["data"];
    Map<String, dynamic> item = {};
    item["id"] = list['id'];
    item["ownerId"] = list['ownerId'];
    item["primaryId"] = list['primaryId'];
    item["secondaryId"] = list['secondaryId'];
    item["name"] = list['name'];
    item["username"] = list["username"];
    item["katakana"] = list["katakana"];
    item["kanji"] = list["kanji"];
    item["fromTime"] = list["fromTime"];
    item["endTime"] = list["endTime"];
    item["status"] = list["status"];
    item['avatar'] = avatarList[list['avatar']];

    item["services"] = [];
    for (var j = 0; j < list["services"].length; j++) {
      var service = {};
      service["id"] = list["services"][j]["id"];
      service["name"] = list["services"][j]["name"];
      service["icon"] = list["services"][j]["icon"];
      service["viewUrl"] = list["services"][j]["viewUrl"];
      service["status"] = true;
      item["services"].add(service);
    }
    return item;
  }

  Future<void> notiAction(String id) async {
    GlobalController globalController = Get.put(GlobalController());
    var item = await Get.put(NotificationController()).getRequest(id: id);
    if (globalController.user.value.id == item["primaryId"]) {
      globalController.historyStatus.value = "SENDING_MODE";
    } else if (globalController.user.value.id == item["secondaryId"]) {
      globalController.historyStatus.value = "REQUEST_MODE";
      var a = await getStatusService(item: item);
      if (!a) {
        item["services"][0]["status"] = false;
      }
    }
    ShareHistoryController shareHistoryController =
        Get.put(ShareHistoryController());
    shareHistoryController.itemSelected.value = item;
    Get.to(() => DetailHistoryPage());
  }

  Future<void> notiAction1(String id) async {
    GlobalController globalController = Get.put(GlobalController());
    var item = await Get.put(NotificationController()).getRequest(id: id);
    if (globalController.user.value.id == item["primaryId"]) {
      globalController.historyStatus.value = "SENDING_MODE";
    } else if (globalController.user.value.id == item["secondaryId"]) {
      globalController.historyStatus.value = "REQUEST_MODE";
      var a = await getStatusService(item: item);
      if (!a) {
        item["services"][0]["status"] = false;
      }
    }
    ShareHistoryController shareHistoryController =
        Get.put(ShareHistoryController());
    shareHistoryController.itemSelected.value = item;
    Get.to(() => HomePageScreen());
    Get.off(() => DetailHistoryPage());
  }
}
