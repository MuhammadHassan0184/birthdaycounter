// ignore_for_file: unused_local_variable

import 'package:birthdaycounter/config/Colors/colors.dart';
import 'package:birthdaycounter/services/notification_service.dart';
import 'package:birthdaycounter/models/reminder_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReminderController extends GetxController {
  var reminders = <Reminder>[].obs;
  var filteredReminders = <Reminder>[].obs; // filtered list for UI

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

  // Public helper to fix _combineDateTime access
  DateTime combineDateTime(String date, String time) {
    return _combineDateTime(date, time);
  }

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

    final docRef = await firestore.collection('reminders').add({
      ...newReminder.toMap(),
      'userId': user.uid,
    });

    // Remove this line to prevent duplicate cards
    // newReminder.id = docRef.id;
    // reminders.add(newReminder);

    // Firestore snapshot listener will automatically update reminders and filteredReminders

    final DateTime notificationTime = _combineDateTime(date.value, time.value);
    await NotificationService.scheduleNotification(
      id: notificationTime.millisecondsSinceEpoch ~/ 1000,
      title: "Reminder: ${name.value}",
      body: wish.value.isEmpty ? "You have an event today" : wish.value,
      dateTime: notificationTime,
    );
  }

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

          // sync filteredReminders
          filteredReminders.value = List.from(reminders);
        });
  }

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

      // 🔐 Notification should NEVER break update
      try {
        DateTime scheduledDateTime = _combineDateTime(date.value, time.value);

        if (scheduledDateTime.isAfter(DateTime.now())) {
          await NotificationService.scheduleNotification(
            id: reminder.id.hashCode, // stable id (important)
            title: "Reminder",
            body: wishController.text,
            dateTime: scheduledDateTime,
          );
        }
      } catch (e) {
        debugPrint("Notification error: $e");
      }

      // ✅ Show success ONLY after update
      Get.snackbar(
        "Success",
        "Reminder updated successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primary,
        colorText: AppColors.white,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        borderRadius: 12,
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update reminder",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
    }
  }

  Future<void> deleteReminder(Reminder reminder) async {
    try {
      await firestore.collection('reminders').doc(reminder.id).delete();
      reminders.removeWhere((r) => r.id == reminder.id);

      filteredReminders.value = List.from(reminders);

      await NotificationService.cancel(reminder.id.hashCode);

      Get.snackbar(
        "Deleted",
        "${reminder.name} deleted successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primary,
        colorText: AppColors.white,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        borderRadius: 12,
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete reminder",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primary,
        colorText: AppColors.white,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        borderRadius: 12,
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void filterToday() {
    final now = DateTime.now();
    filteredReminders.value = reminders.where((r) {
      final reminderDate = _combineDateTime(r.date, r.time);
      return reminderDate.year == now.year &&
          reminderDate.month == now.month &&
          reminderDate.day == now.day;
    }).toList();
  }

  void filterUpcomingWeek() {
    final now = DateTime.now();
    final startOfWeek = now.add(Duration(days: 1));
    final endOfWeek = now.add(Duration(days: 7));
    filteredReminders.value = reminders.where((r) {
      final reminderDate = _combineDateTime(r.date, r.time);
      return reminderDate.isAfter(
            startOfWeek.subtract(const Duration(seconds: 1)),
          ) &&
          reminderDate.isBefore(endOfWeek.add(const Duration(days: 1)));
    }).toList();
  }

  void filterUpcomingMonth() {
    final now = DateTime.now();
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    filteredReminders.value = reminders.where((r) {
      final reminderDate = _combineDateTime(r.date, r.time);
      return reminderDate.isAfter(now.subtract(const Duration(seconds: 1))) &&
          reminderDate.isBefore(endOfMonth.add(const Duration(days: 1)));
    }).toList();
  }

  void resetFilter() {
    filteredReminders.value = List.from(reminders);
  }

  int calculateRemainingDays(String dateStr) {
    try {
      DateTime target = DateTime.parse(dateStr);
      DateTime now = DateTime.now();
      return target.difference(now).inDays;
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
}