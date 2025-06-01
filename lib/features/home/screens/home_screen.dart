// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:office_book_app/features/auth/screens/login_screen.dart';
import 'package:office_book_app/features/home/providers/app_bar_provider.dart';
import 'package:office_book_app/features/home/widgets/app_bar.dart';
import 'package:office_book_app/shared/router/route_constants.dart';
import 'package:office_book_app/shared/services/authentication_services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = RouteConstants.homeScreenLinux;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Searchbar-focus-node
  final FocusNode _searchBarFocusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchBarFocusNode.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _searchBarFocusNode,
      onKeyEvent: (event) {
        if (event.logicalKey == LogicalKeyboardKey.slash) {
          context.read<AppBarProvider>().setShowSearch(true);
        }
      },
      child: Scaffold(
        appBar: HomeAppBar(),

        body: SafeArea(
          child:
          //Base-Container
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1E1E1E),
                  Color(0xFF2C2C2C),
                  Color(0xFF3A3A3A),
                ],
              ),
            ),
          ),
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
