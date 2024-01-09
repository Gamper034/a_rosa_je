import 'package:a_rosa_je/Models/plant.dart';
import 'package:a_rosa_je/Models/visit.dart';

class PlantVisit {
  String id;
  Visit visit;
  Plant plant;
  String photo;

  PlantVisit({
    required this.id,
    required this.visit,
    required this.plant,
    required this.photo,
  });
}
