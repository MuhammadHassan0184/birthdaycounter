// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // ✅ ADD THIS
// import '../models/reminder_model.dart';

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

//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   void addReminder() async {

//     // 🔍 STEP-1 DEBUG (DO NOT REMOVE YET)
//     final user = FirebaseAuth.instance.currentUser;
//     print("USER UID: ${user?.uid}");
//     print("IS LOGGED IN: ${user != null}");

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
//     );

//     // Add to local list
//     reminders.add(newReminder);

//     // Add to Firebase (still unchanged)

//     // await firestore.collection('reminders').add(newReminder.toMap());
//     await firestore.collection('reminders').add({
//   ...newReminder.toMap(),
//   'userId': FirebaseAuth.instance.currentUser!.uid,
// });

//   }

//   int calculateRemainingDays(String dateStr) {
//     try {
//       DateTime target = DateTime.parse(dateStr);
//       DateTime now = DateTime.now();
//       return target.difference(now).inDays;
//     } catch (e) {
//       return 0;
//     }
//   }

//   Stream<List<dynamic>>? getReminders() {}
// }

import 'package:birthdaycounter/models/reminder_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReminderController extends GetxController {
  var reminders = <Reminder>[].obs;

  // Controllers
  var nameController = TextEditingController();
  var relationshipController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var reminderTypeController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var wishController = TextEditingController();

  var name = ''.obs;
  var relationship = ''.obs;
  var phone = ''.obs;
  var email = ''.obs;
  var reminderType = ''.obs;
  var date = ''.obs;
  var time = ''.obs;
  var wish = ''.obs;

  var imagePath = ''.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ================================
  // ADD REMINDER ✅
  // ================================
  void addReminder() async {
    final user = FirebaseAuth.instance.currentUser;

    print("USER UID: ${user?.uid}");
    print("IS LOGGED IN: ${user != null}");

    if (user == null) {
      print("❌ User not logged in");
      return;
    }

    int remainingDays = calculateRemainingDays(date.value);

    Reminder newReminder = Reminder(
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

    // Add locally
    reminders.add(newReminder);

    // Add to Firestore (🔥 FIXED)
    await firestore.collection('reminders').add({
      ...newReminder.toMap(),
      'userId': user.uid, // 🔴 VERY IMPORTANT
    });

    print("✅ Reminder added to Firestore");
  }

  // ================================
  // GET REMINDERS (STREAM) ✅
  // ================================
  Stream<List<Reminder>> getReminders() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return firestore
        .collection('reminders')
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Reminder.fromMap(doc.id, doc.data() as Map<String, dynamic>);
          }).toList();
        });
  }

  // ================================
  // DATE CALCULATION
  // ================================
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
