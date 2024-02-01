import 'package:a_rosa_je/models/advice.dart';
import 'package:a_rosa_je/models/conversation.dart';
import 'package:a_rosa_je/models/plant.dart';
import 'package:a_rosa_je/models/user.dart';
import 'package:a_rosa_je/models/visit.dart';

class Guard {
  String id;
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
    required this.id,
    required this.owner,
    required this.startDate,
    required this.endDate,
    required this.address,
    required this.zipCode,
    required this.city,
    this.guardianId,
    this.applicants,
    this.guardian,
    required this.plants,
    this.visits,
    this.advices,
    this.conversation,
    required this.createdAt,
  });

  factory Guard.fromJson(Map<String, dynamic> json) {
    // print('JSON before parsing: $json');
    return Guard(
      id: json['id'],
      owner: User.fromJson(json['owner']),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      address: json['address'],
      zipCode: json['zipCode'],
      city: json['city'],
      guardianId: json['guardianId'],
      applicants: [],
      guardian:
          json['guardian'] != null ? User.fromJson(json['guardian']) : null,
      plants: json['plants'] != null
          ? json['plants'].map<Plant>((item) => Plant.fromJson(item)).toList()
          : [],
      visits: json['visits'] != null
          ? json['visits'].map<Visit>((item) => Visit.fromJson(item)).toList()
          : [],
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
    return 'Guard{id: $id, owner: $owner, startDate: $startDate, endDate: $endDate, address: $address, zipCode: $zipCode, city: $city, applicants: $applicants, guardian: $guardian, plants: $plants, visits: $visits, advices: $advices, conversation: $conversation, createdAt: $createdAt}';
  }
}
