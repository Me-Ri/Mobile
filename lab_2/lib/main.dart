import 'package:flutter/material.dart';

import 'Convert_page/converter.dart';
import 'Convert_page/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Converter',
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/square': (context) => Converter(),
        '/weight': (context) => Converter(),
        '/volume': (context) => Converter(),
        '/distance': (context) => Converter(),
        '/currency': (context) => Converter(),
      },
    );
  }
}