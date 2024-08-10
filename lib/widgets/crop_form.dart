import 'package:flutter/material.dart';
import '../models/crop.dart';
import '../providers/crop_provider.dart';
import 'package:provider/provider.dart';

class CropForm extends StatefulWidget {
  @override
  _CropFormState createState() => _CropFormState();
}

class _CropFormState extends State<CropForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  DateTime _plantingDate = DateTime.now();
  DateTime _estimatedHarvestDate = DateTime.now().add(Duration(days: 90));

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Crop Name'),
            onSaved: (value) {
              _name = value ?? '';
            },
          ),
          ListTile(
            title: Text("Planting Date: ${_plantingDate.toLocal()}"),
            trailing: Icon(Icons.calendar_today),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _plantingDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (picked != null) {
                setState(() {
                  _plantingDate = picked;
                });
              }
            },
          ),
          ListTile(
            title: Text("Estimated Harvest Date: ${_estimatedHarvestDate.toLocal()}"),
            trailing: Icon(Icons.calendar_today),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _estimatedHarvestDate,
                firstDate: _plantingDate,
                lastDate: DateTime(2101),
              );
              if (picked != null) {
                setState(() {
                  _estimatedHarvestDate = picked;
                });
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Provider.of<CropProvider>(context, listen: false).addCrop(
                  Crop(
                    name: _name,
                    plantingDate: _plantingDate,
                    estimatedHarvestDate: _estimatedHarvestDate,
                  ),
                );
              }
            },
            child: Text('Add Crop'),
          ),
        ],
      ),
    );
  }
}
