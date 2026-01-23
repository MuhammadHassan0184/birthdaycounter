// import 'package:birthdaycounter/models/reminder_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ReminderController extends GetxController {
//   var reminders = <Reminder>[].obs;

//   // Controllers
//   var nameController = TextEditingController();
//   var relationshipController = TextEditingController();
//   var phoneController = TextEditingController();
//   var emailController = TextEditingController();
//   var reminderTypeController = TextEditingController();
//   var dateController = TextEditingController();
//   var timeController = TextEditingController();
//   var wishController = TextEditingController();

//   var name = ''.obs;
//   var relationship = ''.obs;
//   var phone = ''.obs;
//   var email = ''.obs;
//   var reminderType = ''.obs;
//   var date = ''.obs;
//   var time = ''.obs;
//   var wish = ''.obs;

//   var imagePath = ''.obs;

//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   // ================================
//   // ADD REMINDER ✅
//   // ================================
//   void addReminder() async {
//     final user = FirebaseAuth.instance.currentUser;

//     print("USER UID: ${user?.uid}");
//     print("IS LOGGED IN: ${user != null}");

//     if (user == null) {
//       print("❌ User not logged in");
//       return;
//     }

//     int remainingDays = calculateRemainingDays(date.value);

//     Reminder newReminder = Reminder(
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

//     // Add locally
//     reminders.add(newReminder);

//     // Add to Firestore (🔥 FIXED)
//     await firestore.collection('reminders').add({
//       ...newReminder.toMap(),
//       'userId': user.uid, // 🔴 VERY IMPORTANT
//     });

//     print("✅ Reminder added to Firestore");
//   }

//   // ================================
//   // GET REMINDERS (STREAM) ✅
//   // ================================
//   Stream<List<Reminder>> getReminders() {
//     final uid = FirebaseAuth.instance.currentUser!.uid;

//     return firestore
//         .collection('reminders')
//         .where('userId', isEqualTo: uid)
//         .snapshots()
//         .map((snapshot) {
//           return snapshot.docs.map((doc) {
//             return Reminder.fromMap(doc.id, doc.data() as Map<String, dynamic>);
//           }).toList();
//         });
//   }

//   // ================================
//   // DATE CALCULATION
//   // ================================
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

  // Add reminder
  void addReminder() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    int remainingDays = calculateRemainingDays(date.value);

    Reminder newReminder = Reminder(
      id: '', // Firestore will generate
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

    // Add to Firestore
    final docRef = await firestore.collection('reminders').add({
      ...newReminder.toMap(),
      'userId': user.uid,
    });

    // Add locally with id
    newReminder.id = docRef.id;
    reminders.add(newReminder);
  }

  // Fetch reminders
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

      // Update locally
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

      Get.snackbar(
        "Success",
        "Reminder updated successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update reminder",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Delete reminder
  Future<void> deleteReminder(Reminder reminder) async {
    try {
      await firestore.collection('reminders').doc(reminder.id).delete();
      reminders.removeWhere((r) => r.id == reminder.id);
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

  // Calculate remaining days
  int calculateRemainingDays(String dateStr) {
    try {
      DateTime target = DateTime.parse(dateStr);
      DateTime now = DateTime.now();
      return target.difference(now).inDays;
    } catch (e) {
      return 0;
    }
  }
}
