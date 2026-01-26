import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.local);

    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
    );

    await _plugin.initialize(initSettings);
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(dateTime, tz.local);
    // ✅ DEBUG LOG (ADD THIS)
    print("🔔 Notification scheduled at: $scheduledDate");

    await _plugin.zonedSchedule(
  id,
  title,
  body,
  scheduledDate,
  const NotificationDetails(
    android: AndroidNotificationDetails(
      'event_channel',
      'Event Notifications',
      channelDescription: 'Reminder alerts',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    ),
  ),
  androidScheduleMode: AndroidScheduleMode.inexact, // 🔹 Use inexact
);

  }

  static Future<void> cancel(int id) async {
    await _plugin.cancel(id);
  }
}
