class TeacherModel {
  final String name;
  final String surname;
  final String uniqueId;
  final bool isBanned;
  final String monthlyFee;

  // final List groups;

  TeacherModel({
    required this.name,
    required this.surname,
    required this.uniqueId,
    required this.isBanned,
    required this.monthlyFee,

  });

// Convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'uniqueId': uniqueId,
      'isBanned': isBanned,
      'monthlyFee': monthlyFee,

    };
  }
}
