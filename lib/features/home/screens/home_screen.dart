// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:office_book_app/features/auth/screens/login_screen.dart';
import 'package:office_book_app/shared/router/route_constants.dart';
import 'package:office_book_app/shared/services/authentication_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = RouteConstants.homeScreenLinux;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _signOutUser(context);
          },
          child: Text("Sign out dummy"),
        ),
      ),
    );
  }

  //Sign-out-user
  Future<void> _signOutUser(BuildContext context) async {
    if (await AuthenticationServices.instance.signOutUser()) {
      Navigator.popUntil(context, (route) => false);
      Navigator.pushNamed(context, LoginScreen.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error Logging Out User!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
