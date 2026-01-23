// import 'package:birthdaycounter/models/reminder_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ReminderService {
//   final CollectionReference remindersCollection = FirebaseFirestore.instance
//       .collection('reminders');

//   Future<void> addReminder(Reminder reminder) async {
//     await remindersCollection.add(reminder.toMap());
//   }

//   Future<void> updateReminder(Reminder reminder) async {
//     if (reminder.id != null) {
//       await remindersCollection.doc(reminder.id).update(reminder.toMap());
//     }
//   }

//   Future<void> deleteReminder(String id) async {
//     await remindersCollection.doc(id).delete();
//   }

//   Stream<List<Reminder>> getReminders() {
//     return remindersCollection.snapshots().map((snapshot) {
//       return snapshot.docs
//           .map(
//             (doc) =>
//                 Reminder.fromMap(doc.id, doc.data() as Map<String, dynamic>),
//           )
//           .toList();
//     });
//   }
// }
// import 'package:birthdaycounter/models/reminder_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ReminderService {
//   final CollectionReference remindersCollection =
//       FirebaseFirestore.instance.collection('reminders');

//   Future<void> addReminder(Reminder reminder) async {
//     final user = FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       throw Exception("User not logged in");
//     }

//     await remindersCollection.add({
//       ...reminder.toMap(),
//       'userId': user.uid, // ✅ REQUIRED BY FIRESTORE RULES
//     });
//   }

//   Future<void> updateReminder(Reminder reminder) async {
//     if (reminder.id != null) {
//       await remindersCollection.doc(reminder.id).update(reminder.toMap());
//     }
//   }

//   Future<void> deleteReminder(String id) async {
//     await remindersCollection.doc(id).delete();
//   }

// ignore_for_file: unnecessary_cast

//   Stream<List<Reminder>> getReminders() {
//     return remindersCollection.snapshots().map((snapshot) {
//       return snapshot.docs
//           .map((doc) =>
//               Reminder.fromMap(doc.id, doc.data() as Map<String, dynamic>))
//           .toList();
//     });
//   }
// }
import 'package:birthdaycounter/models/reminder_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReminderService {
  final CollectionReference remindersCollection = FirebaseFirestore.instance
      .collection('reminders');

  Future<void> addReminder(Reminder reminder) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await remindersCollection.add({
      ...reminder.toMap(),
      'userId': user.uid, // ✅ REQUIRED BY FIRESTORE RULES
    });
  }

  Future<void> updateReminder(Reminder reminder) async {
    if (reminder.id != null) {
      await remindersCollection.doc(reminder.id).update(reminder.toMap());
    }
  }

  Future<void> deleteReminder(String id) async {
    await remindersCollection.doc(id).delete();
  }

  Stream<List<Reminder>> getReminders() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('reminders')
        .where('userId', isEqualTo: uid) // 🔴 REQUIRED
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Reminder.fromMap(doc.id, doc.data() as Map<String, dynamic>);
          }).toList();
        });
  }
}