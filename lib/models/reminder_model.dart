class Reminder {
  String id; // Firestore document ID
  String name;
  String relationship;
  String phone;
  String email;
  String reminderType;
  String date;
  String time;
  String wish;
  int remainingDays;
  String? imageUrl;

  bool repeatEnabled;
  int repeatCount; // how many times (3 or 4)
  int repeatIntervalHours; // interval in hours

  int notificationId;

  Reminder({
    required this.id,
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
    this.repeatEnabled = false,
    this.repeatCount = 0,
    this.repeatIntervalHours = 1,

    required this.notificationId,
  });

  // Reminder({
  //   required this.id,
  //   required this.name,
  //   required this.relationship,
  //   required this.phone,
  //   required this.email,
  //   required this.reminderType,
  //   required this.date,
  //   required this.time,
  //   required this.wish,
  //   required this.remainingDays,
  //   this.imageUrl,
  // });

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

      'repeatEnabled': repeatEnabled,
      'repeatCount': repeatCount,
      'repeatIntervalHours': repeatIntervalHours,

      'notificationId': notificationId,
    };
  }

  Map<String, dynamic> toJson() => toMap();

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

      repeatEnabled: map['repeatEnabled'] ?? false,
      repeatCount: map['repeatCount'] ?? 0,
      repeatIntervalHours: map['repeatIntervalHours'] ?? 1,

      notificationId: map['notificationId'] ?? 0,
    );
  }
}
