import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crop_provider.dart';
import '../widgets/crop_tile.dart';

class HarvestTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Harvest Tracking')),
      body: Consumer<CropProvider>(
        builder: (context, cropProvider, child) {
          final harvestedCrops = cropProvider.harvestedCrops;

          return ListView.builder(
            itemCount: harvestedCrops.length,
            itemBuilder: (context, index) {
              final crop = harvestedCrops[index];
              return CropTile(crop: crop);
            },
          );
        },
      ),
    );
  }
}
