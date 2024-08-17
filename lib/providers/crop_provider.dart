import 'package:flutter/material.dart';
import '../models/crop.dart';

class CropProvider with ChangeNotifier {
  List<Crop> _crops = [];

  List<Crop> get crops => _crops;

  void addCrop(Crop crop) {
    _crops.add(crop);
    notifyListeners();
  }

  void updateCrop(Crop updatedCrop) {
    final index = _crops.indexWhere((crop) => crop.id == updatedCrop.id);
    if (index >= 0) {
      _crops[index] = updatedCrop;
      notifyListeners();
    }
  }

  void deleteCrop(String id) {
    _crops.removeWhere((crop) => crop.id == id);
    notifyListeners();
  }

  List<Crop> searchCrops(String query) {
    return _crops
        .where((crop) => crop.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Add the harvestedCrops getter
  List<Crop> get harvestedCrops {
    return _crops.where((crop) => crop.actualHarvestDate != null).toList();
  }
}
