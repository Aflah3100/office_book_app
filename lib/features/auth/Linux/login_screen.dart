import 'package:flutter/material.dart';
import 'package:office_book_app/core/app_assets.dart';
import 'package:office_book_app/core/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width * 1;
    final screenHeight = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child:
        //Base-container
        SizedBox(
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
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.7,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Image.asset(
                        AppAssets.officeBookImage1,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              //Right-Side-Login-Container
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [],
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
