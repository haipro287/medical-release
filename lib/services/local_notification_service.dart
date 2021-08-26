import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void init() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("notification_image"));
    notificationsPlugin.initialize(initializationSettings);
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

      await notificationsPlugin.show(
          100,
          message.notification!.title,
          message.notification!.body! + "\n" + message.data.toString(),
          notificationDetails);
    } on Exception catch (e) {
      print(e);
    }
  }
}
