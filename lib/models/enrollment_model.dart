import 'package:cloud_firestore/cloud_firestore.dart';

class EnrollmentModel {
  final String id;
  final String userId;
  final String courseId;
  final DateTime enrolledAt;

  EnrollmentModel({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.enrolledAt,
  });

  // Convert from Firestore document
  factory EnrollmentModel.fromMap(Map<String, dynamic> map, String id) {
    return EnrollmentModel(
      id: id,
      userId: map['userId'] ?? '',
      courseId: map['courseId'] ?? '',
      enrolledAt: (map['enrolledAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'courseId': courseId,
      'enrolledAt': Timestamp.fromDate(enrolledAt),
    };
  }
}

