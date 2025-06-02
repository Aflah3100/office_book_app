import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:office_book_app/core/app_assets.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/features/auth/widgets/lock_screen_widgets.dart';

class LockScreen extends StatelessWidget {
  LockScreen({super.key});
  final List<String> carouselImages = [
    AppAssets.officeBookImage1,
    AppAssets.officeBookImage2,
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width * 1;
    final screenHeight = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      body: SafeArea(
        child:
        //Base Container
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
              //Left-Side-Carousel-Slider
              SizedBox(
                width: screenWidth * 0.5,
                height: screenHeight,
                child: CarouselSlider.builder(
                  itemCount: carouselImages.length,
                  itemBuilder: (context, index, realIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          carouselImages[index],
                          fit: BoxFit.cover,
                          width: screenWidth * 0.35,
                          height: screenHeight * 0.65,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: screenHeight * 0.65,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    scrollDirection: Axis.horizontal,
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
                    children: [LockScreenWidgetsContainer()],
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
