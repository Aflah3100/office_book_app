// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/features/home/widgets/app_bar.dart';
import 'package:office_book_app/shared/hive_database/models/quotes_model.dart';
import 'package:office_book_app/shared/router/route_constants.dart';
import 'package:office_book_app/shared/services/quotes_services.dart';
import 'package:office_book_app/shared/services/shared_prefs.dart';

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
                // color: Colors.grey,
                width: screenWidth,
                height: screenHeight * 0.3,
                child: Row(
                  children: [
                    //Left-Side-quotes-base-Container
                    Container(
                      width: screenWidth * 0.7,
                      color: Colors.transparent,

                      //Left-side-animation-container
                      child: Row(
                        children: [
                          Container(width: screenWidth * 0.25),

                          //Right-side-quotes-container
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Greeting-Message
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: ShaderMask(
                                        shaderCallback:
                                            (bounds) => LinearGradient(
                                              colors: [
                                                AppColors.primaryOrange,
                                                AppColors.primaryOrangeLight,
                                              ],
                                            ).createShader(
                                              Rect.fromLTWH(
                                                0,
                                                0,
                                                bounds.width,
                                                bounds.height,
                                              ),
                                            ),
                                        blendMode: BlendMode.srcIn,
                                        child: Text(
                                          "Good Morning,",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // User-full-name-caps
                                    FutureBuilder<String>(
                                      future: _getUserName(),
                                      builder: (ctx, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasData) {
                                          return FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment.centerLeft,
                                            child: ShaderMask(
                                              shaderCallback:
                                                  (bounds) => LinearGradient(
                                                    colors: [
                                                      AppColors.primaryOrange,
                                                      AppColors
                                                          .primaryOrangeLight,
                                                    ],
                                                  ).createShader(
                                                    Rect.fromLTWH(
                                                      0,
                                                      0,
                                                      bounds.width,
                                                      bounds.height,
                                                    ),
                                                  ),
                                              blendMode: BlendMode.srcIn,
                                              child: Text(
                                                snapshot.data!,
                                                style: GoogleFonts.publicSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      },
                                    ),

                                    const SizedBox(height: 12),

                                    // Quote
                                    Expanded(
                                      child: FutureBuilder<String?>(
                                        future:
                                            QuotesServices.instance
                                                .fetchtodaysQuote(),
                                        builder: (ctx, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator(
                                              color: AppColors.textSecondary,
                                            );
                                          } else if (snapshot.hasData &&
                                              snapshot.data != null) {
                                            return SizedBox(
                                              child: Text(
                                                'Did You Know:\n${snapshot.data!}',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: AppColors.iconColor,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                              ),
                                            );
                                          } else {
                                            return Text(
                                              "Error fetching quote...",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: AppColors.textTertiary,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
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

  Future<String> _getUserName() async {
    final loggedUser = await SharedPrefs.instance.getLoggedUser();

    return "${loggedUser!.firstName.toUpperCase()} ${loggedUser.lastName?.toUpperCase() ?? ""}  ";
  }
}
