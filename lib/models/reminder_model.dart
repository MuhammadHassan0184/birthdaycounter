class Reminder {
  String? id; // Firestore document ID
  String name;
  String relationship;
  String phone;
  String email;
  String reminderType;
  String date;
  String time;
  String wish;
  int remainingDays;
  String? imageUrl; // optional

  Reminder({
    this.id,
    required this.name,
    required this.relationship,
    required this.phone,
    required this.email,
    required this.reminderType,
    required this.date,
    required this.time,
    required this.wish,
    required this.remainingDays,
    this.imageUrl,
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
      'imageUrl': imageUrl,
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
      imageUrl: map['imageUrl'],
    );
  }
}
