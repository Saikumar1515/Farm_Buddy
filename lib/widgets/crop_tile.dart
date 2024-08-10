import 'package:flutter/material.dart';
import '../models/crop.dart';
import '../providers/crop_provider.dart';
import 'package:provider/provider.dart';

class CropTile extends StatelessWidget {
  final Crop crop;

  CropTile({required this.crop});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(crop.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Planting Date: ${crop.plantingDate.toLocal()}"),
          Text("Estimated Harvest Date: ${crop.estimatedHarvestDate.toLocal()}"),
          if (crop.actualHarvestDate != null)
            Text("Actual Harvest Date: ${crop.actualHarvestDate!.toLocal()}"),
        ],
      ),
      trailing: crop.actualHarvestDate == null
          ? IconButton(
        icon: Icon(Icons.check),
        onPressed: () {
          Provider.of<CropProvider>(context, listen: false)
              .markAsHarvested(crop, DateTime.now());
        },
      )
          : null,
    );
  }
}
