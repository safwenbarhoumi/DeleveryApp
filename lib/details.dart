import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DetailPage(),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String description;

  const DetailPage({
    Key? key,
    this.title = "Sample Title",
    this.description = "This is a detailed description of the item.",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, key: Key('appBarTitle')), // Ajouter une clé ici
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 24),
              key: Key('titleText'), // Ajouter une clé ici
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 18),
              key: Key('descriptionText'), // Ajouter une clé ici
            ),
          ],
        ),
      ),
    );
  }
}

// comment ajouter des clés pour les widgets dans les tests
//kdsjd
