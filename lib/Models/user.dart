import 'package:a_rosa_je/models/advice.dart';
import 'package:a_rosa_je/models/message.dart';
import 'package:a_rosa_je/models/guard.dart';

class User {
  String id;
  String email;
  String firstname;
  String lastname;
  // String password;
  String role;
  String? siret;
  String avatar;
  // List<Guard>? guardsRequested = [];
  // List<Guard>? guardsMade = [];
  // List<Guard>? applications = [];
  // List<Message>? messages = [];
  // List<Advice>? advices = [];
  DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    // required this.password,
    required this.role,
    this.siret,
    required this.avatar,
    // this.guardsRequested,
    // this.guardsMade,
    // this.applications,
    // this.messages,
    // this.advices,
    required this.createdAt,
  });

  // Méthode fromJson
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      role: json['role'],
      avatar: json['avatar'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Méthode toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'role': role,
      'avatar': avatar,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
