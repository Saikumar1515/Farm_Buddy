import 'package:flutter/material.dart';
import '../providers/crop_provider.dart';
import '../widgets/crop_tile.dart';

class HarvestTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cropProvider = CropProvider();

    return Scaffold(
      appBar: AppBar(title: Text('Harvest Tracking')),
      body: ListView.builder(
        itemCount: cropProvider.harvestedCrops.length,
        itemBuilder: (context, index) {
          final crop = cropProvider.harvestedCrops[index];
          return CropTile(crop: crop);
        },
      ),
    );
  }
}
