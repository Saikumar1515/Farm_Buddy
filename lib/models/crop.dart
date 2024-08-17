

class Crop {
  final String id; // Unique identifier for the crop
  final String name;
  final DateTime? plantingDate;
  final DateTime? estimatedHarvestDate;
  final DateTime? actualHarvestDate;

  Crop({
    required this.id,
    required this.name,
    this.plantingDate,
    this.estimatedHarvestDate,
    this.actualHarvestDate,
  });

  // Convert a Crop object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'plantingDate': plantingDate?.toIso8601String(),
      'estimatedHarvestDate': estimatedHarvestDate?.toIso8601String(),
      'actualHarvestDate': actualHarvestDate?.toIso8601String(),
    };
  }

  // Create a Crop object from a Map
  factory Crop.fromMap(Map<String, dynamic> map) {
    return Crop(
      id: map['id'] as String,
      name: map['name'] as String,
      plantingDate: map['plantingDate'] != null
          ? DateTime.parse(map['plantingDate'] as String)
          : null,
      estimatedHarvestDate: map['estimatedHarvestDate'] != null
          ? DateTime.parse(map['estimatedHarvestDate'] as String)
          : null,
      actualHarvestDate: map['actualHarvestDate'] != null
          ? DateTime.parse(map['actualHarvestDate'] as String)
          : null,
    );
  }

  // Method to create a copy of the current instance with some fields modified
  Crop copyWith({
    String? id,
    String? name,
    DateTime? plantingDate,
    DateTime? estimatedHarvestDate,
    DateTime? actualHarvestDate,
  }) {
    return Crop(
      id: id ?? this.id,
      name: name ?? this.name,
      plantingDate: plantingDate ?? this.plantingDate,
      estimatedHarvestDate: estimatedHarvestDate ?? this.estimatedHarvestDate,
      actualHarvestDate: actualHarvestDate ?? this.actualHarvestDate,
    );
  }
}
