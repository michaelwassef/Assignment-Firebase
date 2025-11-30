class CourseModel {
  final String id;
  final String name;
  final String description;

  CourseModel({
    required this.id,
    required this.name,
    required this.description,
  });

  // Convert from Firestore document
  factory CourseModel.fromMap(Map<String, dynamic> map, String id) {
    return CourseModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }
}

