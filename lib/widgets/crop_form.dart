import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart'; // Import uuid package
import '../models/crop.dart';
import '../providers/crop_provider.dart';

class CropForm extends StatefulWidget {
  final Crop? crop;

  CropForm({this.crop});

  @override
  _CropFormState createState() => _CropFormState();
}

class _CropFormState extends State<CropForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime? _plantingDate;
  DateTime? _estimatedHarvestDate;

  @override
  void initState() {
    super.initState();
    if (widget.crop != null) {
      _nameController.text = widget.crop!.name;
      _plantingDate = widget.crop!.plantingDate;
      _estimatedHarvestDate = widget.crop!.estimatedHarvestDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Crop Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a crop name';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text(_plantingDate == null
                ? 'Select Planting Date'
                : DateFormat('yyyy-MM-dd').format(_plantingDate!)),
            trailing: Icon(Icons.calendar_today),
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: _plantingDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selectedDate != null) {
                setState(() {
                  _plantingDate = selectedDate;
                });
              }
            },
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text(_estimatedHarvestDate == null
                ? 'Select Estimated Harvest Date'
                : DateFormat('yyyy-MM-dd').format(_estimatedHarvestDate!)),
            trailing: Icon(Icons.calendar_today),
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: _estimatedHarvestDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selectedDate != null) {
                setState(() {
                  _estimatedHarvestDate = selectedDate;
                });
              }
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newCrop = Crop(
                  id: Uuid().v4(), // Generate a unique ID
                  name: _nameController.text,
                  plantingDate: _plantingDate ?? DateTime.now(), // Provide a default if null
                  estimatedHarvestDate: _estimatedHarvestDate ?? DateTime.now(), // Provide a default if null
                );

                // Handle the crop addition logic here
                final cropProvider = Provider.of<CropProvider>(context, listen: false);
                cropProvider.addCrop(newCrop);

                Navigator.pop(context); // Navigate back to the previous page
              }
            },
            child: Text('Save Crop'),
          ),
        ],
      ),
    );
  }
}
