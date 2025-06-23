// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:office_book_app/core/app_assets.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/core/app_enums.dart';
import 'package:office_book_app/features/home/providers/nav_bar_provider.dart';
import 'package:office_book_app/features/home/utils/home_screen_utils.dart';
import 'package:office_book_app/features/home/widgets/app_bar.dart';
import 'package:office_book_app/features/home/widgets/collapsible_nav_bar.dart';
import 'package:office_book_app/shared/providers/current_user_provider.dart';
import 'package:office_book_app/shared/router/route_constants.dart';
import 'package:office_book_app/shared/services/quotes_services.dart';
import 'package:office_book_app/shared/services/shared_prefs.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = RouteConstants.homeScreenLinux;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> officeDeskAnimations = [
    AppAssets.officeDeskAnimation1,
    AppAssets.officeDeskAnimation2,
  ];

  @override
  void initState() {
    //Get-current-user-details & Update-Current-User-Provider
    SharedPrefs.instance.getLoggedUser().then((loggedUser) {
      context.read<CurrentUserProvider>().setUser(loggedUser!.toJson());
    });

    super.initState();
  }

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
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.25,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Quotes + Animation Section
                      SizedBox(
                        width: screenWidth * 0.75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Lottie Animation
                            SizedBox(
                              width: screenWidth * 0.30,
                              child: CarouselSlider.builder(
                                itemCount: officeDeskAnimations.length,
                                itemBuilder: (context, index, realIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Lottie.asset(
                                        officeDeskAnimations[index],
                                      ),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  height: screenHeight * 0.25,
                                  autoPlay: false,
                                  enlargeCenterPage: false,
                                  viewportFraction: 1,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ),

                            // Greeting and Quotes
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: SingleChildScrollView(
                                  // Keeps the column scrollable
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Greeting
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
                                              ).createShader(bounds),
                                          blendMode: BlendMode.srcIn,
                                          child: Text(
                                            "${HomeScreenUtilFunctions.fetchGreetingMessage()},",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // User Name
                                      Consumer<CurrentUserProvider>(
                                        builder: (ctx, currentUserProvider, _) {
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
                                                  ).createShader(bounds),
                                              blendMode: BlendMode.srcIn,
                                              child: Text(
                                                '${currentUserProvider.currentUser.firstName.toUpperCase()} ${currentUserProvider.currentUser.lastName?.toUpperCase()}',
                                                style: GoogleFonts.publicSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 12),

                                      // Daily Quote Card
                                      FutureBuilder<String?>(
                                        future:
                                            QuotesServices.instance
                                                .fetchtodaysQuote(),
                                        builder: (ctx, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.textSecondary,
                                              ),
                                            );
                                          } else if (snapshot.hasData &&
                                              snapshot.data != null) {
                                            return Card(
                                              color: AppColors.cardBackground,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              elevation: 4,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                  ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  16.0,
                                                ),
                                                child: Text(
                                                  'Did You Know:\n"${snapshot.data!}"',

                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    color: AppColors.iconColor,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            // Return an empty text if there's no quote
                                            return const Text("");
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Clock-in Container
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Let's Focus to Work",
                                    style: TextStyle(
                                      color: AppColors.workspaceRed,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    runSpacing: 10.0,
                                    children: [
                                      Text(
                                        HomeScreenUtilFunctions.getFormattedDate(
                                          DateType.all,
                                        ),
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "00:00:00",
                                        style: TextStyle(
                                          color: AppColors.workspaceGreen,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 25,
                                    ),
                                    child: const Divider(
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Center(child: ClockInAnimatedButton()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Home-Body-Container
              Expanded(
                child: Row(
                  children: [
                    Consumer<NavBarProvider>(
                      builder: (ctx, navBarProvider, _) {
                        return CollapsibleNavBar(
                          selectedItem: navBarProvider.getSelectedNavItem(),
                          onItemSelected: (navItem) {
                            navBarProvider.setNavItem(navItem);
                          },
                        );
                      },
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.blue,
                        child: Consumer<NavBarProvider>(
                          builder: (ctx, navBarProvider, _) {
                            return Center(
                              child: Text(
                                navBarProvider.getSelectedNavItem().toString(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
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

/*

Dummy enum & states , need to modify later

*/
enum ClockButtonState { clockIn, clockingIn, clockOut }

class ClockInAnimatedButton extends StatefulWidget {
  const ClockInAnimatedButton({super.key});

  @override
  State<ClockInAnimatedButton> createState() => _ClockInAnimatedButtonState();
}

class _ClockInAnimatedButtonState extends State<ClockInAnimatedButton> {
  ClockButtonState _currentState = ClockButtonState.clockIn;

  void handleTap() async {
    if (_currentState == ClockButtonState.clockIn) {
      setState(() {
        _currentState = ClockButtonState.clockingIn;
      });

      // Simulate animation + processing delay
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _currentState = ClockButtonState.clockOut;
      });
    } else if (_currentState == ClockButtonState.clockOut) {
      setState(() {
        _currentState = ClockButtonState.clockIn;
      });
    }
    // Prevent multiple taps while "clocking in" is animating
  }

  @override
  Widget build(BuildContext context) {
    final double width =
        _currentState == ClockButtonState.clockOut ||
                _currentState == ClockButtonState.clockingIn
            ? 200
            : 120;
    final Color buttonColor =
        _currentState == ClockButtonState.clockOut
            ? AppColors.inactiveDateColor
            : AppColors.workspaceGreen;
    String buttonText;
    Key textKey;

    switch (_currentState) {
      case ClockButtonState.clockIn:
        buttonText = "Clock In";
        textKey = const ValueKey<String>("in");
        break;
      case ClockButtonState.clockingIn:
        buttonText = "Clocking In...";
        textKey = const ValueKey<String>("clocking");
        break;
      case ClockButtonState.clockOut:
        buttonText = "Clock Out";
        textKey = const ValueKey<String>("out");
        break;
    }

    return InkWell(
      onTap: handleTap,
      // Disable tap while clocking in to prevent issues
      // You could also show a disabled cursor or visual feedback
      canRequestFocus: _currentState != ClockButtonState.clockingIn,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        width: width,
        height: 50,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder:
              (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
          child: Text(
            buttonText,
            key: textKey,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
