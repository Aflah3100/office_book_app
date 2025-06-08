// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:office_book_app/features/home/widgets/app_bar.dart';
import 'package:office_book_app/shared/router/route_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = RouteConstants.homeScreenLinux;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width * 1;
    final screenHeight = MediaQuery.sizeOf(context).height * 1;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Top-Container
              Container(
                color: Colors.grey,
                width: screenWidth,
                height: screenHeight * 0.3,
                child: Row(
                  children: [
                    //Left-Side-quotes-base-Container
                    Container(
                      width: screenWidth * 0.7,
                      color: Colors.green,

                      //Left-side-animation-container
                      child: Row(
                        children: [
                          Container(
                            width: screenWidth * 0.25,
                            color: Colors.green,
                          ),

                          //Right-side-quotes-container
                          Expanded(child: Container(color: Colors.red)),
                        ],
                      ),
                    ),
                    //Clock-inout-container
                    Expanded(child: Container(color: Colors.yellow)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
