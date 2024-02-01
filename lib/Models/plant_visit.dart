import 'package:a_rosa_je/models/plant.dart';
import 'package:a_rosa_je/models/visit.dart';

class PlantVisit {
  String id;
  String visitId;
  String plantId;
  String image;
  Plant plantInfo;

  PlantVisit({
    required this.id,
    required this.visitId,
    required this.plantId,
    required this.image,
    required this.plantInfo,
  });

  factory PlantVisit.fromJson(Map<String, dynamic> json) {
    return PlantVisit(
      id: json['id'],
      visitId: json['visitId'],
      plantId: json['plantId'],
      image: json['image'],
      plantInfo: Plant.fromJson(json['plant']),
    );
  }
}
