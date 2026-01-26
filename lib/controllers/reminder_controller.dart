// import 'package:birthdaycounter/models/reminder_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ReminderController extends GetxController {
//   var reminders = <Reminder>[].obs;

//   FirebaseFirestore firestore = FirebaseFirestore.instance;

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
//     fetchReminders();
//   }

//   // Add reminder
//   void addReminder() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;

//     int remainingDays = calculateRemainingDays(date.value);

//     Reminder newReminder = Reminder(
//       id: '', // Firestore will generate
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

//     // Add to Firestore
//     final docRef = await firestore.collection('reminders').add({
//       ...newReminder.toMap(),
//       'userId': user.uid,
//     });

//     // Add locally with id
//     newReminder.id = docRef.id;
//     reminders.add(newReminder);
//   }

//   // Fetch reminders
//   void fetchReminders() {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     if (uid == null) return;

//     firestore
//         .collection('reminders')
//         .where('userId', isEqualTo: uid)
//         .snapshots()
//         .listen((snapshot) {
//           reminders.value = snapshot.docs
//               .map((doc) => Reminder.fromMap(doc.id, doc.data()))
//               .toList();
//         });
//   }

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

//       // Update locally
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

//       Get.snackbar(
//         "Success",
//         "Reminder updated successfully",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Failed to update reminder",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   // Delete reminder
//   Future<void> deleteReminder(Reminder reminder) async {
//     try {
//       await firestore.collection('reminders').doc(reminder.id).delete();
//       reminders.removeWhere((r) => r.id == reminder.id);
//       Get.snackbar(
//         "Deleted",
//         "${reminder.name} deleted successfully",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Failed to delete reminder",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

// ignore_for_file: avoid_print

//   // Calculate remaining days
//   int calculateRemainingDays(String dateStr) {
//     try {
//       DateTime target = DateTime.parse(dateStr);
//       DateTime now = DateTime.now();
//       return target.difference(now).inDays;
//     } catch (e) {
//       return 0;
//     }
//   }
// }
import 'package:birthdaycounter/models/reminder_model.dart';
import 'package:birthdaycounter/services/notification_service.dart'; // ✅ ADD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReminderController extends GetxController {
  var reminders = <Reminder>[].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
    fetchReminders();
  }

  // =========================
  // ADD REMINDER
  // =========================
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

    // ✅ SAVE TO FIRESTORE
    final docRef = await firestore.collection('reminders').add({
      ...newReminder.toMap(),
      'userId': user.uid,
    });

    newReminder.id = docRef.id;
    reminders.add(newReminder);

    // ===============================
    // 🔔 LOCAL NOTIFICATION (ADD HERE)
    // ===============================
    final DateTime notificationTime = _combineDateTime(date.value, time.value);

    // DEBUG LOG
    print("🔔 Notification scheduled at: $notificationTime");

    await NotificationService.scheduleNotification(
      id: notificationTime.millisecondsSinceEpoch ~/ 1000,
      title: "Reminder: ${name.value}",
      body: wish.value.isEmpty ? "You have an event today" : wish.value,
      dateTime: notificationTime,
    );
  }

  // =========================
  // FETCH REMINDERS
  // =========================
  void fetchReminders() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    firestore
        .collection('reminders')
        .where('userId', isEqualTo: uid)
        .snapshots()
        .listen((snapshot) {
          reminders.value = snapshot.docs
              .map((doc) => Reminder.fromMap(doc.id, doc.data()))
              .toList();
        });
  }

  // =========================
  // UPDATE REMINDER
  // =========================
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

      // 🔁 UPDATE NOTIFICATION
      DateTime scheduledDateTime = _combineDateTime(date.value, time.value);

      await NotificationService.scheduleNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000, // unique id
        title: "Reminder",
        body: wishController.text, // or any message
        dateTime: scheduledDateTime,
      );

      Get.snackbar(
        "Error",
        "Failed to update reminder",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Success",
        "Reminder updated successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // =========================
  // DELETE REMINDER
  // =========================
  Future<void> deleteReminder(Reminder reminder) async {
    try {
      await firestore.collection('reminders').doc(reminder.id).delete();
      reminders.removeWhere((r) => r.id == reminder.id);

      // ❌ CANCEL NOTIFICATION
      await NotificationService.cancel(reminder.id.hashCode);

      Get.snackbar(
        "Deleted",
        "${reminder.name} deleted successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete reminder",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // =========================
  // HELPERS
  // =========================
  int calculateRemainingDays(String dateStr) {
    try {
      DateTime target = DateTime.parse(dateStr);
      DateTime now = DateTime.now();
      return target.difference(now).inDays;
    } catch (e) {
      return 0;
    }
  }

  /// 🔹 Combine date + time strings to DateTime
  DateTime _combineDateTime(String date, String time) {
    // date format: MM/DD/YYYY
    final dateParts = date.split('/');
    final month = int.parse(dateParts[0]);
    final day = int.parse(dateParts[1]);
    final year = int.parse(dateParts[2]);

    // time format: HH:MM AM/PM
    final timeParts = time.split(' ');
    final hm = timeParts[0].split(':');
    int hour = int.parse(hm[0]);
    final minute = int.parse(hm[1]);

    if (timeParts[1] == 'PM' && hour != 12) hour += 12;
    if (timeParts[1] == 'AM' && hour == 12) hour = 0;

    return DateTime(year, month, day, hour, minute);
  }
}
