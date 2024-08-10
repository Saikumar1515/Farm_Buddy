import 'package:flutter/material.dart';
import '../models/crop.dart';
import '../services/storage_service.dart';
import 'package:flutter/foundation.dart';

class CropProvider with ChangeNotifier {
  List<Crop> _crops = [];

  List<Crop> get crops => _crops;
  List<Crop> get harvestedCrops => _crops.where((crop) => crop.actualHarvestDate != null).toList();

  void addCrop(Crop crop) {
    _crops.add(crop);
    StorageService.saveCrop(crop); // Save to local storage
    notifyListeners();
  }

  void markAsHarvested(Crop crop, DateTime actualHarvestDate) {
    crop.actualHarvestDate = actualHarvestDate;
    StorageService.saveCrop(crop); // Update in local storage
    notifyListeners();
  }

  void sortByPlantingDate() {
    _crops.sort((a, b) => a.plantingDate.compareTo(b.plantingDate));
    notifyListeners();
  }

  void sortByHarvestDate() {
    _crops.sort((a, b) => a.estimatedHarvestDate.compareTo(b.estimatedHarvestDate));
    notifyListeners();
  }

  List<Crop> searchCrops(String query) {
    return _crops.where((crop) => crop.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

// Additional methods to manage crops can go here
}
