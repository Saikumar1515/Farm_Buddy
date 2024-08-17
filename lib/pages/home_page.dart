import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crop_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/locale_provider.dart';
import '../models/crop.dart'; // Import the Crop class

import 'add_crop.dart';
import 'edit_crop.dart';
import 'sign_in_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';
  bool _isAscending = true; // For toggling between ascending and descending

  @override
  Widget build(BuildContext context) {
    return Consumer<CropProvider>(
      builder: (context, cropProvider, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        final localeProvider = Provider.of<LocaleProvider>(context);

        var crops = _searchQuery.isEmpty
            ? cropProvider.crops
            : cropProvider.searchCrops(_searchQuery);

        // Sort crops by name based on the current sort order
        crops.sort((Crop a, Crop b) {
          return _isAscending
              ? a.name.compareTo(b.name)
              : b.name.compareTo(a.name);
        });

        return Scaffold(
          appBar: AppBar(
            title: Text('My Crops'),
            actions: [
              IconButton(
                icon: Icon(Icons.brightness_6),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              ),
              IconButton(
                icon: Icon(_isAscending ? Icons.sort_by_alpha : Icons.sort),
                onPressed: () {
                  setState(() {
                    _isAscending = !_isAscending;
                  });
                },
              ),
              PopupMenuButton<Locale>(
                icon: Icon(Icons.language),
                onSelected: (Locale locale) {
                  localeProvider.setLocale(locale);
                },
                itemBuilder: (BuildContext context) {
                  return <Locale>[
                    Locale('en', ''),
                    Locale('es', ''),
                  ].map((Locale locale) {
                    return PopupMenuItem<Locale>(
                      value: locale,
                      child: Text(locale.languageCode == 'en' ? 'English' : 'Español'),
                    );
                  }).toList();
                },
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search crops...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: crops.length,
                  itemBuilder: (context, index) {
                    final crop = crops[index];
                    return ListTile(
                      title: Text(crop.name),
                      subtitle: Text(
                        'Planting Date: ${crop.plantingDate != null ? crop.plantingDate!.toLocal().toString().split(' ')[0] : 'N/A'}\n'
                            'Estimated Harvest Date: ${crop.estimatedHarvestDate != null ? crop.estimatedHarvestDate!.toLocal().toString().split(' ')[0] : 'N/A'}',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditCropPage(crop: crop),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddCropPage()),
                        );
                      },
                      child: Text('Add Crop'),
                    ),
                    SizedBox(height: 8),
                    // Remove the example Edit Crop button or add proper logic if needed
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditCropPage(crop: crops[0])), // Example
                        );
                      },
                      child: Text('Edit Crop'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
