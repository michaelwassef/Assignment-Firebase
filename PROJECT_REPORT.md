# Flutter Firebase Course Enrollment App
## Assignment 2 Report

**Student Name:** [Your Name]  
**Student ID:** [Your ID]  
**Course:** Mobile Programming  
**Date:** November 30, 2025

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Features Implemented](#features-implemented)
3. [Firebase Configuration](#firebase-configuration)
4. [Application Screenshots](#application-screenshots)
5. [Firestore Database Structure](#firestore-database-structure)
6. [Technologies Used](#technologies-used)
7. [Conclusion](#conclusion)

---

## 1. Project Overview

This project is a Flutter web application that implements a complete course enrollment system using Firebase Authentication and Firestore Database. The application allows students to register, log in, view available courses, enroll in courses, and add new courses to the system.

### Project Goals
- Implement user authentication using Firebase
- Store user profiles in Firestore
- Enable students to view and enroll in courses
- Allow users to add new courses to the system
- Create a responsive and user-friendly interface

---

## 2. Features Implemented

### 2.1 User Authentication

#### Registration Feature
The application provides a complete registration system where users can create new accounts.

**Registration Fields:**
- **Name**: User's full name
- **Email**: Valid email address for authentication
- **Password**: Secure password (minimum 6 characters)

**Registration Process:**
1. User fills in the registration form
2. Form validation ensures all fields are properly filled
3. Firebase Authentication creates a new user account
4. User profile is automatically stored in Firestore `users` collection
5. User is redirected to the available courses screen

**Security Features:**
- Password visibility toggle for secure input
- Real-time form validation
- Firebase authentication error handling
- Password strength requirement (minimum 6 characters)

**[INSERT SCREENSHOT: Registration Screen]**  
*Screenshot should show: Registration form with Name, Email, and Password fields*

---

#### Login Feature
Existing users can log in using their email and password.

**Login Process:**
1. User enters email and password
2. Form validation checks input
3. Firebase Authentication verifies credentials
4. Upon success, user is redirected to available courses
5. Authentication state is maintained across sessions

**[INSERT SCREENSHOT: Login Screen]**  
*Screenshot should show: Login form with Email and Password fields, and "Don't have an account? Register" link*

---

### 2.2 Course Management

#### Available Courses Screen
This is the main screen after login, displaying all courses available for enrollment.

**Features:**
- View all courses from Firestore database
- Each course shows name and description
- "Enroll" button for courses not yet enrolled
- "Enrolled" badge for courses already enrolled in
- Pull-to-refresh functionality
- Bottom navigation bar for easy navigation
- Logout button in app bar

**Navigation Options:**
- **Available Courses**: Browse all available courses
- **My Courses**: View enrolled courses
- **Add Course**: Create new courses

**[INSERT SCREENSHOT: Available Courses Screen]**  
*Screenshot should show: List of courses with enroll buttons, bottom navigation bar, and logout button*

---

#### Enrolled Courses Screen
Displays all courses that the current user has enrolled in.

**Features:**
- Shows only courses the user is enrolled in
- Displays course name and description
- "Enrolled" badge on each course card
- Pull-to-refresh to update the list
- Empty state message if no enrollments exist
- Back navigation to available courses

**Enrollment Process:**
1. User clicks "Enroll" on a course in Available Courses screen
2. Enrollment is created in Firestore `enrollments` collection
3. Success message is displayed
4. Course list refreshes automatically
5. Course now appears in "My Enrolled Courses"

**[INSERT SCREENSHOT: Enrolled Courses Screen]**  
*Screenshot should show: List of enrolled courses with "Enrolled" badges*

---

#### Add New Course Screen
Allows users to add new courses to the system.

**Course Fields:**
- **Course Name**: Title of the course
- **Description**: Detailed description of the course content

**Add Course Process:**
1. User navigates to "Add Course" via bottom navigation
2. Fills in course name and description
3. Form validation ensures both fields are filled
4. Course is added to Firestore `courses` collection
5. Success message is displayed
6. User is returned to available courses screen
7. New course appears in the courses list

**[INSERT SCREENSHOT: Add New Course Screen]**  
*Screenshot should show: Form with Course Name and Description fields, and "Add Course" button*

---

## 3. Firebase Configuration

### 3.1 Firebase Authentication Setup

**Authentication Method:** Email/Password

**Configuration Steps:**
1. Created Firebase project: `assignment-2-d33cd`
2. Enabled Email/Password authentication in Firebase Console
3. Integrated Firebase Authentication SDK in Flutter app
4. Implemented authentication state management using StreamBuilder

**Authentication Features:**
- User registration with email and password
- User login with credentials
- Secure logout functionality
- Persistent authentication state
- Error handling for authentication failures

---

### 3.2 Firestore Database Setup

**Database Type:** Cloud Firestore (NoSQL)

**Security Rules:**
- Users can only read/write their own profile
- Authenticated users can read all courses
- Authenticated users can create new courses
- Users can only read/create their own enrollments

**Firestore Security Rules:**
```
Configured to allow authenticated users to:
- Read and write their own user profile
- Read all courses and create new ones
- Create and read their own enrollments
```

---

## 4. Application Screenshots

### 4.1 Registration Flow

**Screenshot 1: Registration Screen**  
**[INSERT SCREENSHOT HERE]**

*Description: Shows the registration form with fields for Name, Email, and Password. The form includes validation and a password visibility toggle.*

---

### 4.2 Login Flow

**Screenshot 2: Login Screen**  
**[INSERT SCREENSHOT HERE]**

*Description: Shows the login form with Email and Password fields, along with a link to register for new users.*

---

### 4.3 Course Listing

**Screenshot 3: Available Courses List**  
**[INSERT SCREENSHOT HERE]**

*Description: Displays the main screen with a list of available courses. Each course card shows the course name, description, and an "Enroll" button. The bottom navigation bar and logout button are visible.*

---

### 4.4 Course Enrollment

**Screenshot 4: My Enrolled Courses**  
**[INSERT SCREENSHOT HERE]**

*Description: Shows the enrolled courses screen with courses the user has enrolled in. Each course has an "Enrolled" badge.*

---

### 4.5 Adding New Course

**Screenshot 5: Add New Course Form**  
**[INSERT SCREENSHOT HERE]**

*Description: Displays the form for adding a new course with fields for Course Name and Description.*

---

## 5. Firestore Database Structure

### 5.1 Collections Overview

The application uses three main collections in Firestore:

1. **users** - Stores user profile information
2. **courses** - Stores available courses
3. **enrollments** - Tracks student enrollments

---

### 5.2 Users Collection

**Collection Name:** `users`

**Document Structure:**
```
users/{userId}
  ├─ name: string
  └─ email: string
```

**Fields:**
- `name` (string): User's full name
- `email` (string): User's email address

**Document ID:** Firebase Authentication UID

**Screenshot: Users Collection in Firestore**  
**[INSERT SCREENSHOT HERE]**

*Description: Screenshot from Firebase Console showing the `users` collection with sample user documents displaying name and email fields.*

---

### 5.3 Courses Collection

**Collection Name:** `courses`

**Document Structure:**
```
courses/{courseId}
  ├─ name: string
  └─ description: string
```

**Fields:**
- `name` (string): Course title
- `description` (string): Course description

**Document ID:** Auto-generated by Firestore

**Screenshot: Courses Collection in Firestore**  
**[INSERT SCREENSHOT HERE]**

*Description: Screenshot from Firebase Console showing the `courses` collection with sample course documents displaying name and description fields.*

---

### 5.4 Enrollments Collection

**Collection Name:** `enrollments`

**Document Structure:**
```
enrollments/{enrollmentId}
  ├─ userId: string
  ├─ courseId: string
  └─ enrolledAt: timestamp
```

**Fields:**
- `userId` (string): Reference to user document ID
- `courseId` (string): Reference to course document ID
- `enrolledAt` (timestamp): Enrollment date and time

**Document ID:** Auto-generated by Firestore

**Screenshot: Enrollments Collection in Firestore**  
**[INSERT SCREENSHOT HERE]**

*Description: Screenshot from Firebase Console showing the `enrollments` collection with sample enrollment documents displaying userId, courseId, and enrolledAt fields.*

---

### 5.5 Firestore Database Overview

**Screenshot: Complete Firestore Structure**  
**[INSERT SCREENSHOT HERE]**

*Description: Screenshot from Firebase Console showing all three collections (users, courses, enrollments) in the database overview.*

---

## 6. Technologies Used

### 6.1 Frontend Framework
- **Flutter**: Version 3.x
  - Cross-platform UI framework
  - Material Design 3 components
  - Responsive web support

### 6.2 Backend Services
- **Firebase Authentication**: User authentication and management
- **Cloud Firestore**: NoSQL database for data storage

### 6.3 Flutter Packages

**Core Dependencies:**
```yaml
firebase_core: ^3.6.0
  - Firebase SDK initialization
  
firebase_auth: ^5.3.1
  - User authentication
  - Email/password sign-in
  
cloud_firestore: ^5.4.4
  - Database operations
  - Real-time data synchronization
```

### 6.4 Development Tools
- **FlutterFire CLI**: Firebase configuration
- **Chrome**: Web browser for testing
- **Firebase Console**: Backend management

---

## 7. Conclusion

### 7.1 Project Summary

This Flutter Firebase Course Enrollment App successfully demonstrates:

✅ **User Authentication**: Complete registration and login system using Firebase Authentication with email/password.

✅ **Data Persistence**: User profiles, courses, and enrollments are stored securely in Cloud Firestore.

✅ **Course Management**: Users can view available courses, enroll in courses, and add new courses to the system.

✅ **User Experience**: Clean, intuitive interface with form validation, loading states, and error handling.

✅ **Security**: Firestore security rules ensure users can only access and modify their own data appropriately.

### 7.2 Key Features Delivered

1. **Registration System**
   - Name, email, and password fields
   - Form validation
   - Automatic profile creation in Firestore

2. **Login System**
   - Email and password authentication
   - Error handling
   - Session persistence

3. **Course Viewing**
   - Display all available courses
   - Show enrollment status
   - Pull-to-refresh functionality

4. **Course Enrollment**
   - One-click enrollment
   - Enrollment tracking in database
   - View enrolled courses separately

5. **Add Course Feature**
   - Create new courses
   - Form validation
   - Instant update in course list

### 7.3 Database Implementation

The Firestore database is properly structured with three collections:

- **users**: Stores user profile information (name, email)
- **courses**: Contains all available courses (name, description)
- **enrollments**: Tracks which students enrolled in which courses (userId, courseId, timestamp)

All collections follow proper data normalization and use appropriate data types for efficient querying and storage.

### 7.4 Learning Outcomes

Through this project, the following concepts were successfully implemented:

- Firebase project setup and configuration
- Flutter web application development
- Firebase Authentication integration
- Firestore database operations (CRUD)
- State management with StreamBuilder
- Form validation and error handling
- Material Design UI implementation
- Security rules configuration

---

## Appendix

### Project Files Submitted

1. **Dart Files:**
   - `lib/main.dart`
   - `lib/firebase_options.dart`
   - `lib/models/user_model.dart`
   - `lib/models/course_model.dart`
   - `lib/models/enrollment_model.dart`
   - `lib/services/auth_service.dart`
   - `lib/services/firestore_service.dart`
   - `lib/screens/register_screen.dart`
   - `lib/screens/login_screen.dart`
   - `lib/screens/available_courses_screen.dart`
   - `lib/screens/enrolled_courses_screen.dart`
   - `lib/screens/add_course_screen.dart`
   - `lib/widgets/course_card.dart`

2. **Configuration:**
   - `pubspec.yaml`

### Firebase Project Details

- **Project Name**: assignment-2-d33cd
- **Project ID**: assignment-2-d33cd
- **Region**: (Your selected region)
- **Authentication Method**: Email/Password
- **Database**: Cloud Firestore

---

**End of Report**

