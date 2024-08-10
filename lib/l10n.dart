import 'package:flutter/material.dart';

class AppLocalizations {
  // Fetch the instance of AppLocalizations
  static AppLocalizations? of(BuildContext context) {
    final AppLocalizations? localizations = Localizations.of<AppLocalizations>(context, AppLocalizations);
    assert(localizations != null, 'No AppLocalizations found in context');
    return localizations;
  }

  // Define your localized strings here
  String get appTitle => 'Farm Buddy';
  String get signIn => 'Sign In';
  String get username => 'Username';
  String get password => 'Password';
  String get searchCrops => 'Search crops...';
  String get addCrop => 'Add Crop';
  String get plantingDate => 'Planting Date';
  String get estimatedHarvestDate => 'Estimated Harvest Date';

  // Add a load method to initialize the localization
  static Future<AppLocalizations> load(Locale locale) {
    // Replace with your locale-specific loading logic if necessary
    return Future.value(AppLocalizations());
  }
}

// Create a delegate for AppLocalizations
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
