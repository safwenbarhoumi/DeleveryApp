import 'package:best_flutter_ui_templates/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DetailPage displays correct content',
      (WidgetTester tester) async {
    // Create the widget by pumping the DetailPage widget
    await tester.pumpWidget(MyApp());

    // Verify the app bar title
    expect(find.text('Sample Title'), findsOneWidget);

    // Verify the title and description content
    expect(find.text('Title:'), findsOneWidget);
    expect(find.text('Sample Title'), findsOneWidget);
    expect(find.text('Description:'), findsOneWidget);
    expect(find.text('This is a detailed description of the item.'),
        findsOneWidget);
  });

  testWidgets('DetailPage can accept custom title and description',
      (WidgetTester tester) async {
    // Create the widget with custom title and description
    await tester.pumpWidget(
      MaterialApp(
        home: DetailPage(
          title: 'Custom Title',
          description: 'This is a custom description.',
        ),
      ),
    );

    // Verify custom title and description
    expect(find.text('Custom Title'), findsOneWidget);
    expect(find.text('This is a custom description.'), findsOneWidget);
  });
}
