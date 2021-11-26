import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();
  static const int notificationId = 341;
  static const String channelId = "98";
  static const String channelName = "e_cm_channel";
  static const String channelDesc = "E-CM Notifications";

  static Future<void> show(String title, String body) async {
    var android = const AndroidNotificationDetails(channelId, channelName,
        channelDescription: channelDesc,
        priority: Priority.high,
        importance: Importance.max);
    var iOS = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);

    await plugin.show(notificationId, title, body, platform);
  }
}
