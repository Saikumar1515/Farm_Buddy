import 'package:flutter/material.dart';
import '../models/crop.dart';

class CropTile extends StatelessWidget {
  final Crop crop;

  CropTile({required this.crop});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(crop.name),
      subtitle: Text(
        'Planting Date: ${crop.plantingDate != null ? crop.plantingDate!.toLocal().toString().split(' ')[0] : 'N/A'}\n'
            'Estimated Harvest Date: ${crop.estimatedHarvestDate != null ? crop.estimatedHarvestDate!.toLocal().toString().split(' ')[0] : 'N/A'}',
      ),
      // Optionally, add an onTap to navigate to the EditCropPage
    );
  }
}
