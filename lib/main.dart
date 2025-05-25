import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Main App Entry Point
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Office Book',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      
    );
  }
}
