import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings iosInitialize = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    var settingInitialize = InitializationSettings(
      android: androidInitialize,
      iOS: iosInitialize,
    );

    await notificationsPlugin.initialize(
      settingInitialize,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {},
    );
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "channelId",
        "channelName",
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future showNotification(String title, String body, String? payload, {int id = 0}) async {
    return notificationsPlugin.show(id, title, body, await notificationDetails(), payload: payload);
  }
}
