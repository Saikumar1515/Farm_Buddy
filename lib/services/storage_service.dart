import 'package:shared_preferences/shared_preferences.dart';
import '../models/crop.dart';
import 'dart:convert';

class StorageService {
  static Future<void> saveCrop(Crop crop) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cropsJson = prefs.getStringList('crops');
    if (cropsJson == null) {
      cropsJson = [];
    }
    cropsJson.add(jsonEncode(crop.toMap()));
    await prefs.setStringList('crops', cropsJson);
  }

  static Future<List<Crop>> loadCrops() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cropsJson = prefs.getStringList('crops');
    List<Crop> crops = [];
    if (cropsJson != null) {
      for (var cropJson in cropsJson) {
        crops.add(Crop.fromMap(jsonDecode(cropJson)));
      }
    }
    return crops;
  }
}
