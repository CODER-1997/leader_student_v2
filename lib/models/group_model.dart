class GroupModel {
  final String name;
  final String uniqueId;
  final String teacherId;
  final String perStudentYearlyFee;
  final int order;





  GroupModel({
    required this.name,
    required this.uniqueId,
    required this.teacherId,
    required this.order,
    required this.perStudentYearlyFee,


  });

// Convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uniqueId': uniqueId,
      'teacherId': teacherId,
      'order': order,
      'perStudentYearlyFee': perStudentYearlyFee,


    };
  }
}
