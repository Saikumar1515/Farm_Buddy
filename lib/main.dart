import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'providers/crop_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'pages/home_page.dart';
import 'pages/sign_in_page.dart';
import 'utils/theme.dart';
import 'generated/app_localizations.dart';  // Adjust this import path as needed

Future<void> clearStoredData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // Clears all keys in SharedPreferences
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await clearStoredData(); // Call this line to clear data
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CropProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  Future<bool> _checkSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    bool isSignedIn = prefs.getBool('isSignedIn') ?? false;
    print('isSignedIn value: $isSignedIn'); // Debug print
    return isSignedIn;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkSignIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            title: 'Farm Buddy',
            theme: lightTheme,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''),
              const Locale('es', ''),
            ],
          );
        } else if (snapshot.hasData) {
          return Consumer2<ThemeProvider, LocaleProvider>(
            builder: (context, themeProvider, localeProvider, child) {
              return MaterialApp(
                title: 'Farm Buddy',
                theme: themeProvider.isDarkMode ? darkTheme : lightTheme,
                locale: localeProvider.locale,
                home: snapshot.data! ? HomePage() : SignInPage(),
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('en', ''),
                  const Locale('es', ''),
                ],
              );
            },
          );
        } else {
          return MaterialApp(
            title: 'Farm Buddy',
            theme: lightTheme,
            home: SignInPage(),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''),
              const Locale('es', ''),
            ],
          );
        }
      },
    );
  }
}
