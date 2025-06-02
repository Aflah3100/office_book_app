// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:office_book_app/features/home/providers/app_bar_provider.dart';
import 'package:office_book_app/features/home/widgets/app_bar.dart';
import 'package:office_book_app/shared/router/route_constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = RouteConstants.homeScreenLinux;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),

      body: SafeArea(
        child:
        //Base-Container
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1E1E1E), Color(0xFF2C2C2C), Color(0xFF3A3A3A)],
            ),
          ),
        ),
      ),
    );
  }
}
