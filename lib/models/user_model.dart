import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final DateTime? createdAt;
  final DateTime? lastLogin;
  final String role;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.createdAt,
    this.lastLogin,
    this.role = 'student',
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      uid: documentId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      lastLogin: (map['lastLogin'] as Timestamp?)?.toDate(),
      role: map['role'] ?? 'student',
    );
  }

  Map<String, dynamic> toCreateMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'lastLogin': FieldValue.serverTimestamp(),
      'role': role,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'name': name,
      'photoUrl': photoUrl,
      'lastLogin': FieldValue.serverTimestamp(),
    };
  }
}
