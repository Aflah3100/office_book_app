import 'dart:io';

import 'package:flutter/material.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/features/auth/screens/login_screen.dart';
import 'package:office_book_app/features/home/providers/app_bar_provider.dart';
import 'package:office_book_app/features/home/screens/home_screen.dart';
import 'package:office_book_app/shared/hive_database/services/hive_initializer.dart';
import 'package:office_book_app/shared/models/user_model.dart';
import 'package:office_book_app/shared/providers/login_provider.dart';
import 'package:office_book_app/shared/router/generate_route.dart';
import 'package:office_book_app/shared/services/shared_prefs.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart' as window_size;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveInitializer.instance.initHive();

  //Fixing-Window-Size for linux platforms
  if (Platform.isLinux || Platform.isWindows) {
    const minSize = Size(1280, 720);
    window_size.setWindowMinSize(minSize);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Main App Entry Point
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Loginprovider()),
        ChangeNotifierProvider(create: (_) => AppBarProvider()),
      ],
      child: MaterialApp(
        title: 'Office Book',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryOrange),
        ),
        onGenerateRoute: generateRoute,
        home: FutureBuilder<UserModel?>(
          future: SharedPrefs.instance.getLoggedUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data != null) {
              return const HomeScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
