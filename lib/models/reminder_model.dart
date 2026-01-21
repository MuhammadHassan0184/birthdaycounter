class Reminder {
  String? id; // For Firestore doc id
  String name;
  String relationship;
  String phone;
  String email;
  String reminderType;
  String date;
  String time;
  String wish;
  int remainingDays;

  Reminder({
    this.id,
    required this.name,
    required this.relationship,
    this.phone = '',
    this.email = '',
    required this.reminderType,
    required this.date,
    required this.time,
    required this.wish,
    required this.remainingDays,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'relationship': relationship,
      'phone': phone,
      'email': email,
      'reminderType': reminderType,
      'date': date,
      'time': time,
      'wish': wish,
      'remainingDays': remainingDays,
    };
  }

  factory Reminder.fromMap(String id, Map<String, dynamic> map) {
    return Reminder(
      id: id,
      name: map['name'] ?? '',
      relationship: map['relationship'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      reminderType: map['reminderType'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      wish: map['wish'] ?? '',
      remainingDays: map['remainingDays'] ?? 0,
    );
  }
}
