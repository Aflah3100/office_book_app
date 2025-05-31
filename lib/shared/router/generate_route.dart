import 'package:flutter/material.dart';
import 'package:office_book_app/features/auth/screens/login_screen.dart';
import 'package:office_book_app/features/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => LoginScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    default:
      return MaterialPageRoute(
        builder:
            (_) => const Scaffold(
              body: Center(
                child: Text(
                  'Screen Does not exist!',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            ),
      );
  }
}
