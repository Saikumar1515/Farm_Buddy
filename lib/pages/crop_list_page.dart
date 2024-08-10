import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crop_provider.dart';
import '../widgets/crop_tile.dart';

class CropListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Crops'),
      ),
      body: Consumer<CropProvider>(
        builder: (context, cropProvider, child) {
          if (cropProvider.crops.isEmpty) {
            return Center(
              child: Text('No crops added yet!'),
            );
          }

          return ListView.builder(
            itemCount: cropProvider.crops.length,
            itemBuilder: (context, index) {
              final crop = cropProvider.crops[index];
              return CropTile(crop: crop);
            },
          );
        },
      ),
    );
  }
}
