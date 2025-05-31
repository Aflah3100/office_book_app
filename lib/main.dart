import 'package:flutter/material.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/features/auth/screens/login_screen.dart';
import 'package:office_book_app/features/home/screens/home_screen.dart';
import 'package:office_book_app/shared/providers/login_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Main App Entry Point
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Loginprovider())],
      child: MaterialApp(
        title: 'Office Book',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryOrange),
        ),
        home: LoginScreen(),
      ),
    );
  }
}
