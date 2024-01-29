import 'package:a_rosa_je/Models/advice.dart';
import 'package:a_rosa_je/Models/conversation.dart';
import 'package:a_rosa_je/Models/plant.dart';
import 'package:a_rosa_je/Models/user.dart';
import 'package:a_rosa_je/Models/visit.dart';
import 'package:a_rosa_je/theme/color.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Guard {
  String? id;
  User owner;
  DateTime startDate;
  DateTime endDate;
  String address;
  String zipCode;
  String city;
  String? guardianId;
  User? guardian;
  List<User>? applicants;
  List<Plant> plants;
  List<Visit>? visits;
  List<Advice>? advices;
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
    required this.guardianId,
    this.applications,
    this.guardian,
    required this.plants,
    this.visits,
    this.advices,
    this.conversation,
    required this.createdAt,
  });

  factory Guard.fromJson(Map<String, dynamic> json) {
    return Guard(
      id: json['id'],
      owner: User.fromJson(json['owner']),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      address: json['address'],
      zipCode: json['zipCode'],
      city: json['city'],
      applicants: [],
      guardian:
          json['guardian'] != null ? User.fromJson(json['guardian']) : null,
      plants:
          json['plants'].map<Plant>((plant) => Plant.fromJson(plant)).toList(),
      visits: [],
      advices: [],
      conversation: null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  fromJsonDetails(Map<String, dynamic> json) {
    return null;
  }

  @override
  String toString() {
    return 'Guard{id: $id, owner: $owner, startDate: $startDate, endDate: $endDate, address: $address, zipCode: $zipCode, city: $city, guardianId: $guardianId,  applicants: $applications, guardian: $guardian, plants: $plants, visits: $visits, advices: $advices, conversation: $conversation, createdAt: $createdAt}';
  }
}
