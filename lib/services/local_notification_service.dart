import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/notification/notification_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/detail_history_page.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void init() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("notification_image"));
    notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? route) async {
      print(route);
      var item = await Get.put(NotificationController())
          .getRequest(id: route.toString());
      Get.put(ShareHistoryController()).itemSelected.value = item;
      Get.to(() => DetailHistoryPage());
    });
  }

  static Future<void> display(RemoteMessage message) async {
    try {
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "medical",
        "medical channel",
        "this is channel",
        importance: Importance.max,
        priority: Priority.high,
      ));

      await notificationsPlugin.show(1, message.notification!.title,
          message.notification!.body!, notificationDetails,
          payload: message.data["id"]);
    } on Exception catch (e) {
      print(e);
    }
  }
}
