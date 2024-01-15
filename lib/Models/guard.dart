import 'package:a_rosa_je/Models/advice.dart';
import 'package:a_rosa_je/Models/conversation.dart';
import 'package:a_rosa_je/Models/plant.dart';
import 'package:a_rosa_je/Models/user.dart';
import 'package:a_rosa_je/Models/visit.dart';

class Guard {
  String? id;
  User owner;
  DateTime startDate;
  DateTime endDate;
  String address;
  String zipCode;
  String city;
  List<User>? applicants = [];
  User? guardian;
  List<Plant>? plants = [];
  List<Visit>? visits = [];
  List<Advice>? advices = [];
  Conversation? conversation;
  DateTime createdAt;

  Guard({
    this.id,
    required this.owner,
    required this.startDate,
    required this.endDate,
    required this.address,
    required this.zipCode,
    required this.city,
    this.applicants,
    this.guardian,
    this.plants,
    this.visits,
    this.advices,
    this.conversation,
    required this.createdAt,
  });
}
