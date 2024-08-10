import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crop_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/locale_provider.dart';  // Import LocaleProvider
import '../widgets/crop_form.dart';
import '../widgets/crop_tile.dart';
import 'sign_in_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final cropProvider = Provider.of<CropProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);  // Access LocaleProvider

    final crops = _searchQuery.isEmpty
        ? cropProvider.crops
        : cropProvider.searchCrops(_searchQuery);

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
          // IconButton(
          //   icon: Icon(Icons.sort_by_alpha),
          //   onPressed: () {
          //     cropProvider.sortByPlantingDate();
          //   },
          // ),
          // IconButton(
          //   icon: Icon(Icons.calendar_today),
          //   onPressed: () {
          //     cropProvider.sortByHarvestDate();
          //   },
          // ),
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
              // Navigate back to SignInPage
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
                return CropTile(crop: crops[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CropForm(),
          ),
        ],
      ),
    );
  }
}
