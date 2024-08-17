import 'package:flutter/material.dart';
import '../widgets/crop_form.dart';

class AddCropPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Crop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CropForm(), // Using CropForm widget to handle form inputs
      ),
    );
  }
}
