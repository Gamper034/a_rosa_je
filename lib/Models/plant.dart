class Plant {
  String id;
  String? guardId;
  String? name;
  String image;
  String? plantType;
  String? visitId;
  String? plantId;

  Plant({
    required this.id,
    this.guardId,
    this.name,
    this.plantType,
    required this.image,
    this.visitId,
    this.plantId,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      guardId: json['guardId'] ?? null,
      name: json['name'] ?? null,
      plantType: json['type'] ?? null,
      image: json['image'],
      visitId: json['visitId'] ?? null,
      plantId: json['plantId'] ?? null,
    );
  }

  toList() {
    return [this];
  }

  @override
  String toString() {
    return 'Plant{id: $id, guardId: $guardId, name: $name, plantType: $plantType, image: $image}';
  }
}
