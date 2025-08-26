class StudentModel {
  final String name;
  final String surname;
  final String phone;
  final String group;
  final List payments;
  final List exams;
  final List studyDays;
  final String uniqueId;
  final String startedDay;
  final String yearlyFee;
  final bool isDeleted;
  final String groupId;
  final bool isFreeOfcharge;




  StudentModel( {
    required this.name,
    required this.surname,
    required this.phone,
    required this.group,
    required this.payments,
    required this.exams,
    required this.studyDays,
    required this.uniqueId,
    required this.startedDay,
    required this.isDeleted,
    required this.groupId,
    required this.isFreeOfcharge,
    required this.yearlyFee,

  });

// Convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name.toLowerCase(),
      'surname': surname.toLowerCase(),
      'phone': phone,
      'group': group,
      'payments': payments,
      'exams': exams,
      'studyDays': studyDays,
      'uniqueId': uniqueId,
      'startedDay': startedDay,
      'isDeleted': isDeleted,
      'groupId': groupId,
      'yearlyFee': yearlyFee,
      'isFreeOfcharge': isFreeOfcharge,

    };
  }
}
