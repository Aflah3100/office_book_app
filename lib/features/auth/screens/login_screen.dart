import 'package:flutter/material.dart';
import 'package:office_book_app/core/app_assets.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/features/auth/widgets/login_widgets.dart';
import 'package:office_book_app/shared/router/route_constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const routeName = RouteConstants.loginScreenLinux;


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width * 1;
    final screenHeight = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      body: SafeArea(
        child:
        //Base-container
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF1F1F1F), Color(0xFF121212), Color(0xFF2C2C2C)],
            ),
          ),
          width: double.maxFinite,
          height: double.maxFinite,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Left-Side-Image-Container
              SizedBox(
                width: screenWidth * 0.5,
                height: screenHeight,
                child: Center(
                  child: SizedBox(
                    width: screenWidth * 0.35,
                    height: screenHeight * 0.65,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Image.asset(
                        AppAssets.officeBookImage2,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              //Right-Side-Login-Container
              Expanded(
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [LoginContainer()],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
