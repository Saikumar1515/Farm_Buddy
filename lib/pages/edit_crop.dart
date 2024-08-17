import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crop_provider.dart';
import '../models/crop.dart';

class EditCropPage extends StatefulWidget {
  final Crop crop;

  EditCropPage({required this.crop});

  @override
  _EditCropPageState createState() => _EditCropPageState();
}

class _EditCropPageState extends State<EditCropPage> {
  late TextEditingController _nameController;
  late DateTime _plantingDate;
  late DateTime _estimatedHarvestDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.crop.name);
    _plantingDate = widget.crop.plantingDate ?? DateTime.now();
    _estimatedHarvestDate = widget.crop.estimatedHarvestDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _updateCrop() {
    final cropProvider = Provider.of<CropProvider>(context, listen: false);

    cropProvider.updateCrop(
      widget.crop.copyWith(
        name: _nameController.text,
        plantingDate: _plantingDate,
        estimatedHarvestDate: _estimatedHarvestDate,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Crop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Crop Name'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _plantingDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (selectedDate != null && selectedDate != _plantingDate) {
                  setState(() {
                    _plantingDate = selectedDate;
                  });
                }
              },
              child: Text('Select Planting Date: ${_plantingDate.toLocal().toString().split(' ')[0]}'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _estimatedHarvestDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (selectedDate != null && selectedDate != _estimatedHarvestDate) {
                  setState(() {
                    _estimatedHarvestDate = selectedDate;
                  });
                }
              },
              child: Text('Select Estimated Harvest Date: ${_estimatedHarvestDate.toLocal().toString().split(' ')[0]}'),
            ),
            Spacer(), // Pushes the button to the bottom
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _updateCrop,
                child: Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
