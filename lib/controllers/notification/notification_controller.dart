import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/services/local_notification_service.dart';

class NotificationController extends GetxController {
  GlobalController globalController = Get.put(GlobalController());
  @override
  Future<void> onInit() async {
    // TODO: implement onInit

    //background but kill
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
    });

    //foreground
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.body);
      print(message.notification!.title);
      LocalNotificationService.display(message);
    });

    //background but opened
    FirebaseMessaging.onMessageOpenedApp.listen((message) {});
    super.onInit();
  }
}
