import 'package:flutter/material.dart';
import 'package:apimarvel/apiMarvel/mainApiMarvel.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: mainApiMarvel(),
    );
  }
}

