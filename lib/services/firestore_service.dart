import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/course_model.dart';
import '../models/enrollment_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create user profile in users collection
  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
      });
    } catch (e) {
      throw 'Error creating user profile: $e';
    }
  }

  // Get user profile from users collection
  Future<UserModel?> getUserProfile(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, uid);
      }
      return null;
    } catch (e) {
      throw 'Error fetching user profile: $e';
    }
  }

  // Get all courses from courses collection
  Future<List<CourseModel>> getAllCourses() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('courses').get();
      return snapshot.docs.map((doc) {
        return CourseModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    } catch (e) {
      throw 'Error fetching courses: $e';
    }
  }

  // Stream of all courses
  Stream<List<CourseModel>> getAllCoursesStream() {
    return _firestore.collection('courses').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CourseModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  // Add new course to courses collection
  Future<void> addCourse({
    required String name,
    required String description,
  }) async {
    try {
      await _firestore.collection('courses').add({
        'name': name,
        'description': description,
      });
    } catch (e) {
      throw 'Error adding course: $e';
    }
  }

  // Get course by ID
  Future<CourseModel?> getCourseById(String courseId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('courses').doc(courseId).get();
      if (doc.exists) {
        return CourseModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }
      return null;
    } catch (e) {
      throw 'Error fetching course: $e';
    }
  }

  // Enroll in a course - create enrollment in enrollments collection
  Future<void> enrollInCourse({
    required String userId,
    required String courseId,
  }) async {
    try {
      // Check if already enrolled
      QuerySnapshot existing = await _firestore
          .collection('enrollments')
          .where('userId', isEqualTo: userId)
          .where('courseId', isEqualTo: courseId)
          .get();

      if (existing.docs.isNotEmpty) {
        throw 'You are already enrolled in this course.';
      }

      await _firestore.collection('enrollments').add({
        'userId': userId,
        'courseId': courseId,
        'enrolledAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Error enrolling in course: $e';
    }
  }

  // Get user's enrolled courses
  Future<List<EnrollmentModel>> getUserEnrollments(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('enrollments')
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) {
        return EnrollmentModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    } catch (e) {
      throw 'Error fetching enrollments: $e';
    }
  }

  // Stream of user's enrollments
  Stream<List<EnrollmentModel>> getUserEnrollmentsStream(String userId) {
    return _firestore
        .collection('enrollments')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return EnrollmentModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  // Get enrolled courses with course details
  Future<List<CourseModel>> getEnrolledCoursesWithDetails(String userId) async {
    try {
      List<EnrollmentModel> enrollments = await getUserEnrollments(userId);
      List<CourseModel> courses = [];

      for (var enrollment in enrollments) {
        CourseModel? course = await getCourseById(enrollment.courseId);
        if (course != null) {
          courses.add(course);
        }
      }

      return courses;
    } catch (e) {
      throw 'Error fetching enrolled courses: $e';
    }
  }
}

