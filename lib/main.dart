import 'package:flutter/material.dart';
import 'screens/home/home.dart';

void main() {
  runApp(const TeraApp());
}

class TeraApp extends StatelessWidget {
  const TeraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TERA Health',
      home: const Home(),
    );
  }
}