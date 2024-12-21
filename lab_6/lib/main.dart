import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox('mybox');
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://yktrqvjiknmhahqfcrrp.supabase.co/',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlrdHJxdmppa25taGFocWZjcnJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQwMTIwMTYsImV4cCI6MjA0OTU4ODAxNn0.BZXnbUMS4PgdQaE3q6r1QFrgaBHaFG2-cyK_j0Tch4I',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food',
      home: HomeScreen(),
    );
  }
}
