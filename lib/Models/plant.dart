class Plant {
  String id;
  String guardId;
  String name;
  String image;
  String plantType;

  Plant({
    required this.id,
    required this.guardId,
    required this.name,
    required this.plantType,
    required this.image,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      guardId: json['guardId'],
      name: json['name'],
      plantType: json['type'],
      image: json['image'],
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
