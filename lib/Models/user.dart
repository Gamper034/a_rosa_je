import 'package:a_rosa_je/Models/advice.dart';
import 'package:a_rosa_je/Models/message.dart';
import 'package:a_rosa_je/models/guard.dart';

class User {
  String id;
  String email;
  String firstName;
  String lastName;
  String password;
  String role;
  String? siret;
  String avatar;
  List<Guard>? guardsRequested = [];
  List<Guard>? guardsMade = [];
  List<Guard>? applications = [];
  List<Message>? messages = [];
  List<Advice>? advices = [];
  DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.role,
    this.siret,
    required this.avatar,
    this.guardsRequested,
    this.guardsMade,
    this.applications,
    this.messages,
    this.advices,
    required this.createdAt,
  });
}
