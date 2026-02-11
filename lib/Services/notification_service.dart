// // ignore_for_file: avoid_print

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:birthdaycounter/config/Routes/routes_name.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:get/get.dart';
// import 'dart:convert';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _plugin =
//       FlutterLocalNotificationsPlugin();

//   // Store payload when app is launched from notification
//   static String? _initialPayload;

//   /// Initialize notifications
//   static Future<void> init() async {
//     tz.initializeTimeZones();
//     tz.setLocalLocation(tz.local);

//     const AndroidInitializationSettings androidInit =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initSettings = InitializationSettings(
//       android: androidInit,
//     );

//     await _plugin.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: (details) {
//         if (details.payload != null && details.payload!.isNotEmpty) {
//           print("Notification tapped with payload: ${details.payload}");
//           _initialPayload = details.payload;

//           // Navigate immediately if app is in foreground/background
//           try {
//             final Map<String, dynamic> reminderData = jsonDecode(
//               details.payload!,
//             );
//             Get.toNamed(AppRoutesName.previewReminder, arguments: reminderData);
//           } catch (e) {
//             print("Error decoding payload: $e");
//           }
//         }
//       },
//     );
//   }

//   /// For cold start: check if app was launched from notification
//   static Future<String?> getInitialPayload() async {
//     final details = await _plugin.getNotificationAppLaunchDetails();
//     if (details != null && details.didNotificationLaunchApp) {
//       _initialPayload = details.notificationResponse?.payload;
//     }
//     return _initialPayload;
//   }

//   /// Schedule a notification with optional payload
//   static Future<void> scheduleNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime dateTime,
//     String? payload,
//   }) async {
//     final tz.TZDateTime scheduledDate = tz.TZDateTime.from(dateTime, tz.local);
//     print("🔔 Notification scheduled at: $scheduledDate");

//     await _plugin.zonedSchedule(
//       id,
//       title,
//       body,
//       scheduledDate,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'event_channel',
//           'Event Notifications',
//           channelDescription: 'Reminder alerts',
//           importance: Importance.max,
//           priority: Priority.high,
//           playSound: true,
//           enableVibration: true,
//         ),
//       ),
//       androidScheduleMode: AndroidScheduleMode.inexact,
//       payload: payload, // Pass JSON string for reminder data
//     );
//   }

// ignore_for_file: avoid_print

//   /// Cancel a notification by id
//   static Future<void> cancel(int id) async {
//     await _plugin.cancel(id);
//   }
// }
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:birthdaycounter/config/Routes/routes_name.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';
import 'dart:convert';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // Store payload when app is launched from notification
  static String? _initialPayload;

  /// Initialize notifications
  static Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.local);

    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null && details.payload!.isNotEmpty) {
          print("Notification tapped with payload: ${details.payload}");
          _initialPayload = details.payload;

          try {
            final Map<String, dynamic> reminderData = jsonDecode(
              details.payload!,
            );
            Get.toNamed(AppRoutesName.previewReminder, arguments: reminderData);
          } catch (e) {
            print("Error decoding payload: $e");
          }
        }
      },
    );
  }

  /// For cold start: check if app was launched from notification
  static Future<String?> getInitialPayload() async {
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _initialPayload = details.notificationResponse?.payload;
    }
    return _initialPayload;
  }

  /// Schedule single notification (UNCHANGED)
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
    String? payload,
  }) async {
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(dateTime, tz.local);

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
      androidScheduleMode: AndroidScheduleMode.inexact,
      payload: payload,
    );
  }

  // ============================================================
  // 🔥 NEW FUNCTION: Schedule Notification With Repeat Support
  // ============================================================
  static Future<void> scheduleNotificationWithRepeat({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
    String? payload,
    bool repeatEnabled = false,
    int repeatCount = 0,
    int repeatIntervalHours = 1,
  }) async {
    final tz.TZDateTime baseTime = tz.TZDateTime.from(dateTime, tz.local);

    print("🔔 Base Notification scheduled at: $baseTime");

    // If repeat not enabled → schedule normal notification
    if (!repeatEnabled || repeatCount <= 0) {
      await scheduleNotification(
        id: id,
        title: title,
        body: body,
        dateTime: dateTime,
        payload: payload,
      );
      return;
    }

    // Schedule multiple notifications
    for (int i = 0; i <= repeatCount; i++) {
      final tz.TZDateTime scheduledTime = baseTime.add(
        Duration(hours: i * repeatIntervalHours),
      );

      await _plugin.zonedSchedule(
        id + i, // unique id for each repeat
        title,
        body,
        scheduledTime,
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
        androidScheduleMode: AndroidScheduleMode.inexact,
        payload: payload,
      );

      print("🔁 Repeat $i scheduled at: $scheduledTime");
    }
  }

  /// Cancel a notification by id
  static Future<void> cancel(int id) async {
    await _plugin.cancel(id);
  }
}
