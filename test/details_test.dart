import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:best_flutter_ui_templates/details.dart';

void main() {
  testWidgets('DetailPage displays title and description',
      (WidgetTester tester) async {
    // Construire l'application
    await tester.pumpWidget(MaterialApp(home: DetailPage()));

    // Vérifier si le titre est affiché correctement dans l'AppBar
    expect(find.byKey(Key('appBarTitle')), findsOneWidget);

    // Vérifier si le titre du corps de la page est affiché correctement
    expect(find.byKey(Key('titleText')), findsOneWidget);

    // Vérifier si la description est affichée correctement
    expect(find.byKey(Key('descriptionText')), findsOneWidget);
  });

  testWidgets('DetailPage can accept custom title and description',
      (WidgetTester tester) async {
    // Créer une page avec un titre et une description personnalisés
    await tester.pumpWidget(MaterialApp(
      home: DetailPage(
        title: 'Custom Title',
        description: 'Custom description for this item.',
      ),
    ));

    // Vérifier si le titre personnalisé est affiché
    expect(find.byKey(Key('titleText')), findsOneWidget);

    // Vérifier si la description personnalisée est affichée
    expect(find.byKey(Key('descriptionText')), findsOneWidget);
  });
}
