class Crop {
  String name;
  DateTime plantingDate;
  DateTime estimatedHarvestDate;
  DateTime? actualHarvestDate;

  Crop({
    required this.name,
    required this.plantingDate,
    required this.estimatedHarvestDate,
    this.actualHarvestDate,
  });

  // Convert Crop object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'plantingDate': plantingDate.toIso8601String(),
      'estimatedHarvestDate': estimatedHarvestDate.toIso8601String(),
      'actualHarvestDate': actualHarvestDate?.toIso8601String(),
    };
  }

  // Create a Crop object from a Map
  factory Crop.fromMap(Map<String, dynamic> map) {
    return Crop(
      name: map['name'],
      plantingDate: DateTime.parse(map['plantingDate']),
      estimatedHarvestDate: DateTime.parse(map['estimatedHarvestDate']),
      actualHarvestDate: map['actualHarvestDate'] != null
          ? DateTime.parse(map['actualHarvestDate'])
          : null,
    );
  }
}
