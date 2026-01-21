// import 'package:birthdaycounter/models/reminder_model.dart';
// import 'package:birthdaycounter/services/reminder_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ReminderController extends GetxController {
//   var nameController = TextEditingController();
//   var relationshipController = TextEditingController();
//   var reminderTypeController = TextEditingController();
//   var dateController = TextEditingController();
//   var timeController = TextEditingController();
//   var wishController = TextEditingController();
//   var phoneController = TextEditingController();
//   var emailController = TextEditingController();

//   // Rx variables for binding (optional)
//   var name = ''.obs;
//   var relationship = ''.obs;
//   var reminderType = ''.obs;
//   var date = ''.obs;
//   var time = ''.obs;
//   var wish = ''.obs;

//   ReminderService reminderService = ReminderService();

//   // Add Reminder
//   void addReminder() async {
//     final reminder = Reminder(
//       name: nameController.text,
//       relationship: relationshipController.text,
//       reminderType: reminderTypeController.text,
//       date: dateController.text,
//       time: timeController.text,
//       wish: wishController.text,
//       phone: phoneController.text,
//       email: emailController.text,
//       remainingDays: calculateRemainingDays(dateController.text),
//     );

//     await reminderService.addReminder(reminder);

//     // Optional: reset controllers
//     nameController.clear();
//     relationshipController.clear();
//     reminderTypeController.clear();
//     dateController.clear();
//     timeController.clear();
//     wishController.clear();
//     phoneController.clear();
//     emailController.clear();
//   }

//   Stream<List<Reminder>> getReminders() {
//     return reminderService.getReminders();
//   }

//   int calculateRemainingDays(String dateStr) {
//     try {
//       final parts = dateStr.split('/');
//       final now = DateTime.now();
//       final date = DateTime(
//         now.year,
//         int.parse(parts[0]),
//         int.parse(parts[1]),
//       );

//       final diff = date.difference(now);
//       return diff.inDays;
//     } catch (e) {
//       return 0;
//     }
//   }
// }
// import 'package:birthdaycounter/models/reminder_model.dart';
// import 'package:birthdaycounter/services/reminder_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ReminderController extends GetxController {
//   // TextEditingControllers
//   var nameController = TextEditingController();
//   var relationshipController = TextEditingController();
//   var reminderTypeController = TextEditingController();
//   var dateController = TextEditingController();
//   var timeController = TextEditingController();
//   var wishController = TextEditingController();
//   var phoneController = TextEditingController();
//   var emailController = TextEditingController();

//   // Rx variables for binding with UI / validation
//   var name = ''.obs;
//   var relationship = ''.obs;
//   var reminderType = ''.obs;
//   var date = ''.obs;
//   var time = ''.obs;
//   var wish = ''.obs;

//   ReminderService reminderService = ReminderService();

//   @override
//   void onInit() {
//     super.onInit();

//     // Sync text controllers to Rx variables automatically
//     nameController.addListener(() => name.value = nameController.text);
//     relationshipController.addListener(
//       () => relationship.value = relationshipController.text,
//     );
//     reminderTypeController.addListener(
//       () => reminderType.value = reminderTypeController.text,
//     );
//     dateController.addListener(() => date.value = dateController.text);
//     timeController.addListener(() => time.value = timeController.text);
//     wishController.addListener(() => wish.value = wishController.text);
//   }

//   // Add Reminder
//  void addReminder() async {
//   final reminder = Reminder(
//     name: nameController.text,
//     relationship: relationshipController.text,
//     reminderType: reminderTypeController.text,
//     date: dateController.text,
//     time: timeController.text,
//     wish: wishController.text,
//     phone: phoneController.text,
//     email: emailController.text,
//     remainingDays: calculateRemainingDays(dateController.text),
//   );

//   await reminderService.addReminder(reminder);

//   // Clear fields
//   nameController.clear();
//   relationshipController.clear();
//   reminderTypeController.clear();
//   dateController.clear();
//   timeController.clear();
//   wishController.clear();
//   phoneController.clear();
//   emailController.clear();

//   // Clear Rx values as well
//   name.value = '';
//   relationship.value = '';
//   reminderType.value = '';
//   date.value = '';
//   time.value = '';
//   wish.value = '';
// }


//   // Stream of reminders for StreamBuilder
//   Stream<List<Reminder>> getReminders() {
//     return reminderService.getReminders();
//   }

//   // Calculate remaining days
//   int calculateRemainingDays(String dateStr) {
//     try {
//       final parts = dateStr.split('/');
//       if (parts.length < 2) return 0;

//       final now = DateTime.now();
//       final date = DateTime(now.year, int.parse(parts[0]), int.parse(parts[1]));

//       final diff = date.difference(now);
//       return diff.inDays >= 0 ? diff.inDays : 0;
//     } catch (e) {
//       return 0;
//     }
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/reminder_model.dart';

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

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addReminder() async {
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
    );

    // Add to local list
    reminders.add(newReminder);

    // Add to Firebase
    await firestore.collection('reminders').add(newReminder.toMap());
  }

  int calculateRemainingDays(String dateStr) {
    try {
      DateTime target = DateTime.parse(dateStr); // yyyy-mm-dd
      DateTime now = DateTime.now();
      return target.difference(now).inDays;
    } catch (e) {
      return 0;
    }
  }

  Stream<List<dynamic>>? getReminders() {}
}
