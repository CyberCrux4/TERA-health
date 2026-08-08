import 'package:flutter/material.dart';

void main() {
  runApp(const TeraApp());
}

class TeraApp extends StatelessWidget {
  const TeraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TERA Health'),
        ),
        body: const Center(
          child: Text(
            'TERA HEALTH',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}