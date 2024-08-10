import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';

class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      onSelected: (locale) {
        Provider.of<LocaleProvider>(context, listen: false).setLocale(locale);
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: Locale('en'),
            child: Text('English'),
          ),
          PopupMenuItem(
            value: Locale('es'),
            child: Text('Español'),
          ),
        ];
      },
      icon: Icon(Icons.language),
    );
  }
}
