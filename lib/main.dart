import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adres Checker'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      drawer: Drawer(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 125,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                ),
                child: const Center(
                  child: Text(
                    "Adres Checker",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
                leading: Icon(Icons.share),
                title: const Text('Deel deze app'),
                onTap: () {
                  print("Knopje 1");
                }),
            ListTile(
                leading: Icon(Icons.reviews),
                title: const Text('Beoordeel ons'),
                onTap: () {
                  print("Knopje 1");
                }),
            ListTile(
                leading: Icon(Icons.info),
                title: const Text('Meer info'),
                onTap: () {
                  print("Knopje 1");
                },
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 1.75),
            Divider(
              color: Colors.grey[700],
              height: 0,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                title: Text(
                  'An app by JeromeNL',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
