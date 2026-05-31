class StudentModel {
  final int id;
  final String name;

  StudentModel({
    required this.id,
    required this.name,
  });

  factory StudentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return StudentModel(
      id: json['id'],
      name: json['name'],
    );
  }
}