import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/notification/notification_controller.dart';

class HomePageController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    NotificationController notificationController =
        Get.put(NotificationController());
    super.onInit();
  }

  Future<void> backgroundHandler(RemoteMessage message) async {
    await Get.put(NotificationController()).notiAction(message.data["id"]);
  }
}
