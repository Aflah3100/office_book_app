import 'package:flutter/material.dart';
import 'package:office_book_app/features/auth/Linux/login_screen.dart';


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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen(),
      
    );
  }
}
