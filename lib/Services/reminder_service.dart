import 'package:birthdaycounter/models/reminder_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderService {
  final CollectionReference remindersCollection =
      FirebaseFirestore.instance.collection('reminders');

  Future<void> addReminder(Reminder reminder) async {
    await remindersCollection.add(reminder.toMap());
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
    return remindersCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Reminder.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
