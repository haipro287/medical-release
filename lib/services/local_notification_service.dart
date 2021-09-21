import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/notification/notification_controller.dart';

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
      await Get.put(NotificationController()).notiAction(route.toString());
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
