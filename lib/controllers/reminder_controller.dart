// // ignore_for_file: unused_local_variable

// import 'dart:async';
// import 'package:birthdaycounter/config/Colors/colors.dart';
// import 'package:birthdaycounter/services/notification_service.dart';
// import 'package:birthdaycounter/models/reminder_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ReminderController extends GetxController {
//   var reminders = <Reminder>[].obs;
//   var filteredReminders = <Reminder>[].obs;

//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   StreamSubscription<User?>? _authListener;
//   StreamSubscription<QuerySnapshot>? _reminderListener;

//   // Controllers for add/edit
//   var nameController = TextEditingController();
//   var relationshipController = TextEditingController();
//   var phoneController = TextEditingController();
//   var emailController = TextEditingController();
//   var reminderTypeController = TextEditingController();
//   var dateController = TextEditingController();
//   var timeController = TextEditingController();
//   var wishController = TextEditingController();
//   var imagePath = ''.obs;

//   var name = ''.obs;
//   var relationship = ''.obs;
//   var phone = ''.obs;
//   var email = ''.obs;
//   var reminderType = ''.obs;
//   var date = ''.obs;
//   var time = ''.obs;
//   var wish = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();

//     /// 🔥 AUTH STATE LISTENER (THIS IS THE FIX)
//     _authListener = FirebaseAuth.instance.authStateChanges().listen((
//       User? user,
//     ) {
//       // 🚿 Clear OLD user data immediately
//       reminders.clear();
//       filteredReminders.clear();

//       // ❌ stop previous Firestore listener
//       _reminderListener?.cancel();
//       _reminderListener = null;

//       // ✅ Load data for NEW user
//       if (user != null) {
//         _startReminderListener(user.uid);
//       }
//     });
//   }

//   @override
//   void onClose() {
//     _authListener?.cancel();
//     _reminderListener?.cancel();
//     super.onClose();
//   }

//   /// 🔄 Start Firestore listener for specific user
//   void _startReminderListener(String uid) {
//     _reminderListener = firestore
//         .collection('reminders')
//         .where('userId', isEqualTo: uid)
//         .snapshots()
//         .listen((snapshot) {
//           reminders.value = snapshot.docs
//               .map((doc) => Reminder.fromMap(doc.id, doc.data()))
//               .toList();

//           filteredReminders.value = List.from(reminders);
//         });
//   }

//   // --------------------------------------------------
//   // ADD REMINDER (UNCHANGED LOGIC)
//   // --------------------------------------------------
//   void addReminder() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;

//     int remainingDays = calculateRemainingDays(date.value);

//     Reminder newReminder = Reminder(
//       id: '',
//       name: name.value,
//       relationship: relationship.value,
//       phone: phone.value,
//       email: email.value,
//       reminderType: reminderType.value,
//       date: date.value,
//       time: time.value,
//       wish: wish.value,
//       remainingDays: remainingDays,
//       imageUrl: imagePath.value.isEmpty ? null : imagePath.value,
//     );

//     await firestore.collection('reminders').add({
//       ...newReminder.toMap(),
//       'userId': user.uid,
//     });

//     final DateTime notificationTime = _combineDateTime(date.value, time.value);
//     await NotificationService.scheduleNotification(
//       id: notificationTime.millisecondsSinceEpoch ~/ 1000,
//       title: "Reminder: ${name.value}",
//       body: wish.value.isEmpty ? "You have an event today" : wish.value,
//       dateTime: notificationTime,
//     );
//   }

//   // --------------------------------------------------
//   // UPDATE / DELETE / FILTER (UNCHANGED)
//   // --------------------------------------------------

//   void updateReminder(Reminder reminder) async {
//     final docRef = firestore.collection('reminders').doc(reminder.id);

//     try {
//       int remainingDays = calculateRemainingDays(date.value);

//       await docRef.update({
//         'name': name.value,
//         'relationship': relationship.value,
//         'phone': phone.value,
//         'email': email.value,
//         'reminderType': reminderType.value,
//         'date': date.value,
//         'time': time.value,
//         'wish': wish.value,
//         'remainingDays': remainingDays,
//         'imageUrl': imagePath.value.isEmpty ? null : imagePath.value,
//       });

//       final index = reminders.indexWhere((r) => r.id == reminder.id);
//       if (index != -1) {
//         reminders[index] = Reminder(
//           id: reminder.id,
//           name: name.value,
//           relationship: relationship.value,
//           phone: phone.value,
//           email: email.value,
//           reminderType: reminderType.value,
//           date: date.value,
//           time: time.value,
//           wish: wish.value,
//           remainingDays: remainingDays,
//           imageUrl: imagePath.value.isEmpty ? null : imagePath.value,
//         );
//         reminders.refresh();
//       }

//       filteredReminders.value = List.from(reminders);

//       DateTime scheduledDateTime = _combineDateTime(date.value, time.value);
//       if (scheduledDateTime.isAfter(DateTime.now())) {
//         await NotificationService.scheduleNotification(
//           id: reminder.id.hashCode,
//           title: "Reminder",
//           body: wishController.text,
//           dateTime: scheduledDateTime,
//         );
//       }

//       Get.snackbar(
//         "Success",
//         "Reminder updated successfully",
//         backgroundColor: AppColors.primary,
//         colorText: Colors.white,
//       );
//     } catch (e) {
//       Get.snackbar("Error", "Failed to update reminder");
//     }
//   }

//   Future<void> deleteReminder(Reminder reminder) async {
//     await firestore.collection('reminders').doc(reminder.id).delete();
//     reminders.removeWhere((r) => r.id == reminder.id);
//     filteredReminders.value = List.from(reminders);
//     await NotificationService.cancel(reminder.id.hashCode);
//   }

//   // --------------------------------------------------
//   // HELPERS
//   // --------------------------------------------------
//   /// ✅ Used by HomeScreen filters
//   DateTime combineDateTime(String date, String time) {
//     return _combineDateTime(date, time);
//   }

//   int calculateRemainingDays(String dateStr) {
//     try {
//       DateTime target = DateTime.parse(dateStr);
//       return target.difference(DateTime.now()).inDays;
//     } catch (e) {
//       return 0;
//     }
//   }

//   DateTime _combineDateTime(String date, String time) {
//     final dateParts = date.split('/');
//     final month = int.parse(dateParts[0]);
//     final day = int.parse(dateParts[1]);
//     final year = int.parse(dateParts[2]);

//     final timeParts = time.split(' ');
//     final hm = timeParts[0].split(':');
//     int hour = int.parse(hm[0]);
//     final minute = int.parse(hm[1]);

//     if (timeParts[1] == 'PM' && hour != 12) hour += 12;
//     if (timeParts[1] == 'AM' && hour == 12) hour = 0;

//     return DateTime(year, month, day, hour, minute);
//   }

//   // int calculateRemainingDays(String dateStr) {
//   //   try {
//   //     DateTime target = DateTime.parse(dateStr);
//   //     return target.difference(DateTime.now()).inDays;
//   //   } catch (e) {
//   //     return 0;
//   //   }
//   // }

//   // DateTime _combineDateTime(String date, String time) {
//   //   final dateParts = date.split('/');
//   //   final month = int.parse(dateParts[0]);
//   //   final day = int.parse(dateParts[1]);
//   //   final year = int.parse(dateParts[2]);

//   //   final timeParts = time.split(' ');
//   //   final hm = timeParts[0].split(':');
//   //   int hour = int.parse(hm[0]);
//   //   final minute = int.parse(hm[1]);

//   //   if (timeParts[1] == 'PM' && hour != 12) hour += 12;
//   //   if (timeParts[1] == 'AM' && hour == 12) hour = 0;

//   //   return DateTime(year, month, day, hour, minute);
//   // }
// }

// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/services/notification_service.dart';
import 'package:birthdaycounter/models/reminder_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReminderController extends GetxController {
  var reminders = <Reminder>[].obs;
  var filteredReminders = <Reminder>[].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription<User?>? _authListener;
  StreamSubscription<QuerySnapshot>? _reminderListener;

  // Controllers for add/edit
  var nameController = TextEditingController();
  var relationshipController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var reminderTypeController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var wishController = TextEditingController();
  var imagePath = ''.obs;

  var name = ''.obs;
  var relationship = ''.obs;
  var phone = ''.obs;
  var email = ''.obs;
  var reminderType = ''.obs;
  var date = ''.obs;
  var time = ''.obs;
  var wish = ''.obs;

  @override
  void onInit() {
    super.onInit();

    /// 🔥 AUTH STATE LISTENER (THIS IS THE FIX)
    _authListener = FirebaseAuth.instance.authStateChanges().listen((
      User? user,
    ) {
      // 🚿 Clear OLD user data immediately
      reminders.clear();
      filteredReminders.clear();

      // ❌ stop previous Firestore listener
      _reminderListener?.cancel();
      _reminderListener = null;

      // ✅ Load data for NEW user
      if (user != null) {
        _startReminderListener(user.uid);
      }
    });
  }

  @override
  void onClose() {
    _authListener?.cancel();
    _reminderListener?.cancel();
    super.onClose();
  }
  

  /// 🔄 Start Firestore listener for specific user
  void _startReminderListener(String uid) {
    _reminderListener = firestore
        .collection('reminders')
        .where('userId', isEqualTo: uid)
        .snapshots()
        .listen((snapshot) {
          reminders.value = snapshot.docs
              .map((doc) => Reminder.fromMap(doc.id, doc.data()))
              .toList();

          filteredReminders.value = List.from(reminders);
        });
  }

  // --------------------------------------------------
  // ADD REMINDER (UNCHANGED LOGIC)
  // --------------------------------------------------
  void addReminder() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    int remainingDays = calculateRemainingDays(date.value);

    Reminder newReminder = Reminder(
      id: '',
      name: name.value,
      relationship: relationship.value,
      phone: phone.value,
      email: email.value,
      reminderType: reminderType.value,
      date: date.value,
      time: time.value,
      wish: wish.value,
      remainingDays: remainingDays,
      imageUrl: imagePath.value.isEmpty ? null : imagePath.value,
    );

    await firestore.collection('reminders').add({
      ...newReminder.toMap(),
      'userId': user.uid,
    });

    final DateTime notificationTime = _combineDateTime(date.value, time.value);
    await NotificationService.scheduleNotification(
      id: notificationTime.millisecondsSinceEpoch ~/ 1000,
      title: "Reminder: ${name.value}",
      body: wish.value.isEmpty ? "You have an event today" : wish.value,
      dateTime: notificationTime,
      payload: jsonEncode({
        'id': '', // optional
        'name': name.value,
        'relationship': relationship.value,
        'phone': phone.value,
        'email': email.value,
        'reminderType': reminderType.value,
        'date': date.value,
        'time': time.value,
        'wish': wish.value,
        'imageUrl': imagePath.value,
        'remainingDays': calculateRemainingDays(date.value),
      }),
    );
  }

  // --------------------------------------------------
  // UPDATE / DELETE / FILTER (UNCHANGED)
  // --------------------------------------------------

  void updateReminder(Reminder reminder) async {
    final docRef = firestore.collection('reminders').doc(reminder.id);

    try {
      int remainingDays = calculateRemainingDays(date.value);

      await docRef.update({
        'name': name.value,
        'relationship': relationship.value,
        'phone': phone.value,
        'email': email.value,
        'reminderType': reminderType.value,
        'date': date.value,
        'time': time.value,
        'wish': wish.value,
        'remainingDays': remainingDays,
        'imageUrl': imagePath.value.isEmpty ? null : imagePath.value,
      });

      final index = reminders.indexWhere((r) => r.id == reminder.id);
      if (index != -1) {
        reminders[index] = Reminder(
          id: reminder.id,
          name: name.value,
          relationship: relationship.value,
          phone: phone.value,
          email: email.value,
          reminderType: reminderType.value,
          date: date.value,
          time: time.value,
          wish: wish.value,
          remainingDays: remainingDays,
          imageUrl: imagePath.value.isEmpty ? null : imagePath.value,
        );
        reminders.refresh();
      }

      filteredReminders.value = List.from(reminders);

      DateTime scheduledDateTime = _combineDateTime(date.value, time.value);
      if (scheduledDateTime.isAfter(DateTime.now())) {
        await NotificationService.scheduleNotification(
          id: reminder.id.hashCode,
          title: "Reminder: ${name.value}",
          body: wish.value.isEmpty ? "You have an event today" : wish.value,
          dateTime: scheduledDateTime,
          payload: jsonEncode({
            // Must use 'payload', not 'payloadle' or anything else
            'id': reminder.id,
            'name': name.value,
            'relationship': relationship.value,
            'phone': phone.value,
            'email': email.value,
            'reminderType': reminderType.value,
            'date': date.value,
            'time': time.value,
            'wish': wish.value,
            'imageUrl': imagePath.value,
            'remainingDays': calculateRemainingDays(date.value),
          }),
        );
      }

      Get.snackbar(
        "Success",
        "Reminder updated successfully",
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to update reminder");
    }
  }

  Future<void> deleteReminder(Reminder reminder) async {
    await firestore.collection('reminders').doc(reminder.id).delete();
    reminders.removeWhere((r) => r.id == reminder.id);
    filteredReminders.value = List.from(reminders);
    await NotificationService.cancel(reminder.id.hashCode);
  }

  // --------------------------------------------------
  // HELPERS
  // --------------------------------------------------
  /// ✅ Used by HomeScreen filters
  DateTime combineDateTime(String date, String time) {
    return _combineDateTime(date, time);
  }

  int calculateRemainingDays(String dateStr) {
    try {
      DateTime target = DateTime.parse(dateStr);
      return target.difference(DateTime.now()).inDays;
    } catch (e) {
      return 0;
    }
  }

  DateTime _combineDateTime(String date, String time) {
    final dateParts = date.split('/');
    final month = int.parse(dateParts[0]);
    final day = int.parse(dateParts[1]);
    final year = int.parse(dateParts[2]);

    final timeParts = time.split(' ');
    final hm = timeParts[0].split(':');
    int hour = int.parse(hm[0]);
    final minute = int.parse(hm[1]);

    if (timeParts[1] == 'PM' && hour != 12) hour += 12;
    if (timeParts[1] == 'AM' && hour == 12) hour = 0;

    return DateTime(year, month, day, hour, minute);
  }

  // int calculateRemainingDays(String dateStr) {
  //   try {
  //     DateTime target = DateTime.parse(dateStr);
  //     return target.difference(DateTime.now()).inDays;
  //   } catch (e) {
  //     return 0;
  //   }
  // }

  // DateTime _combineDateTime(String date, String time) {
  //   final dateParts = date.split('/');
  //   final month = int.parse(dateParts[0]);
  //   final day = int.parse(dateParts[1]);
  //   final year = int.parse(dateParts[2]);

  //   final timeParts = time.split(' ');
  //   final hm = timeParts[0].split(':');
  //   int hour = int.parse(hm[0]);
  //   final minute = int.parse(hm[1]);

  //   if (timeParts[1] == 'PM' && hour != 12) hour += 12;
  //   if (timeParts[1] == 'AM' && hour == 12) hour = 0;

  //   return DateTime(year, month, day, hour, minute);
  // }
}
