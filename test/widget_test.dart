import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:farm_buddy/pages/sign_in_page.dart';
import 'package:farm_buddy/pages/home_page.dart';
import 'package:farm_buddy/widgets/crop_form.dart';
import 'package:farm_buddy/widgets/crop_tile.dart';
import 'package:farm_buddy/providers/crop_provider.dart';
import 'package:farm_buddy/models/crop.dart';

void main() {
  testWidgets('SignInPage displays sign-in fields and button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SignInPage(),
      ),
    );

    // Verify that there are two TextFields and one ElevatedButton
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('HomePage displays crop list and form', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CropProvider(),
        child: MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    // Verify that CropForm and ListView are displayed
    expect(find.byType(CropForm), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('CropForm adds new crop', (WidgetTester tester) async {
    final cropProvider = CropProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => cropProvider,
        child: MaterialApp(
          home: Scaffold(
            body: CropForm(),
          ),
        ),
      ),
    );

    // Input text and submit
    await tester.enterText(find.byType(TextFormField), 'Tomato');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Rebuild the widget

    // Verify that the crop was added
    expect(cropProvider.crops, isNotEmpty);
    expect(cropProvider.crops.first.name, 'Tomato');
  });

  testWidgets('CropTile displays crop information', (WidgetTester tester) async {
    final crop = Crop(
      name: 'Carrot',
      plantingDate: DateTime.now(),
      estimatedHarvestDate: DateTime.now().add(Duration(days: 60)),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CropTile(crop: crop),
        ),
      ),
    );

    // Verify that CropTile displays crop name and planting date text
    expect(find.text('Carrot'), findsOneWidget);
    expect(find.text('Planting Date:'), findsOneWidget);
  });
}
