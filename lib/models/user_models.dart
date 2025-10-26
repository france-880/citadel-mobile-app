// lib/models/user_model.dart

class UserModel {
  final int id;
  final String fullname;
  final String? email;
  final String? username;
  final String role;
  final String origin;
  final String? contact;
  final String? address;
  final String? gender;
  final String? dob;
  final String? photoUrl; // optional profile photo field

  UserModel({
    required this.id,
    required this.fullname,
    this.email,
    this.username,
    required this.role,
    required this.origin,
    this.contact,
    this.address,
    this.gender,
    this.dob,
    this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      fullname: json['fullname'] ?? '',
      email: json['email'],
      username: json['username'],
      role: json['role'] ?? '',
      origin: json['origin'] ?? '',
      contact: json['contact'],
      address: json['address'],
      gender: json['gender'],
      dob: json['dob'],
      photoUrl: json['photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'username': username,
      'role': role,
      'origin': origin,
      'contact': contact,
      'address': address,
      'gender': gender,
      'dob': dob,
      'photo_url': photoUrl,
    };
  }

  // 🧭 Helper methods
  bool get isStudent => origin == 'students';

  /// Detect professor accounts. Backend may return professors from the
  /// `users` or `accounts` tables and use role slug 'prof'. Accept common
  /// variants to avoid mismatch between backend and frontend.
  bool get isProfessor {
    final o = origin.toLowerCase();
    final r = role.toLowerCase();
    final originOk = o == 'users' || o == 'accounts' || o == 'professor';
    final roleOk = r == 'prof' || r == 'professor' || r == 'faculty';
    return originOk && roleOk;
  }

  bool get isProgramHead {
    final r = role.toLowerCase();
    return r == 'program_head' || r == 'program-head' || r == 'program head';
  }
}
