// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/core/app_enums.dart';
import 'package:office_book_app/features/auth/screens/lock_screen.dart';
import 'package:office_book_app/features/auth/screens/login_screen.dart';
import 'package:office_book_app/features/home/providers/app_bar_provider.dart';
import 'package:office_book_app/features/home/widgets/dynamic_search_field.dart';
import 'package:office_book_app/shared/providers/current_user_provider.dart';
import 'package:office_book_app/shared/services/authentication_services.dart';
import 'package:office_book_app/shared/services/shared_prefs.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF2C2C2C),
      elevation: 0,
      titleSpacing: 0,

      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          width: double.maxFinite,
          height: preferredSize.height,

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Office Book title
              const Text(
                'Office Book',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),

              // Middle: Search bar
              Expanded(
                flex: 3,
                child: SizedBox(height: 40, child: DynamicSearchField()),
              ),
              const Spacer(),

              // Right: Profile + status indicator
              GestureDetector(
                onTapDown: (TapDownDetails details) {
                  _showUserPopupMenu(context, details.globalPosition);
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(radius: 20),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      //User-Status
                      child: Consumer<AppBarProvider>(
                        builder: (ctx, provider, _) {
                          return Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: _getStatusColor(provider.getUserStatus()),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                          );
                        },
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

  //User-Pop-Up-Menu
  void _showUserPopupMenu(BuildContext context, Offset position) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final loggedUser = await SharedPrefs.instance.getLoggedUser();

    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(position.dx, position.dy, 100, 100),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: SizedBox(
            width: 300,
            height: 340, // Custom height
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Top-Row (Heading & Signout-button)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Office Desk Systems',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 13,
                            ),
                          ),
                          TextButton(
                            onPressed: () => _signOutUser(context),
                            child: Text(
                              'Signout',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      //User-Details
                      Text(
                        "👤 ${loggedUser!.firstName} ${loggedUser.lastName}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        loggedUser.email,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  Divider(),
                  //User-Status
                  Consumer<AppBarProvider>(
                    builder: (ctx, provider, _) {
                      final currentUserState = provider.getUserStatus();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Set Availability Status: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<AppBarProvider>().setUserStatus(
                                UserStatus.available,
                              );
                            },
                            child: Text(
                              currentUserState == UserStatus.available
                                  ? "🟢 Available ✔"
                                  : "🟢 Available",
                              style: TextStyle(color: AppColors.textPrimary),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<AppBarProvider>().setUserStatus(
                                UserStatus.away,
                              );
                            },
                            child: Text(
                              currentUserState == UserStatus.away
                                  ? "🌙 Away ✔"
                                  : "🌙 Away",
                              style: TextStyle(color: AppColors.textPrimary),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<AppBarProvider>().setUserStatus(
                                UserStatus.busy,
                              );
                            },
                            child: Text(
                              currentUserState == UserStatus.busy
                                  ? "🔴 Busy ✔ "
                                  : "🔴 Busy",
                              style: TextStyle(color: AppColors.textPrimary),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<AppBarProvider>().setUserStatus(
                                UserStatus.offline,
                              );
                            },
                            child: Text(
                              currentUserState == UserStatus.offline
                                  ? "⚫ Offline ✔"
                                  : "⚫ Offline",
                              style: TextStyle(color: AppColors.textPrimary),
                            ),
                          ),
                          Divider(),
                          //App-Settings
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "⚙️ Settings",
                              style: TextStyle(color: AppColors.textPrimary),
                            ),
                          ),
                          //Lock-screen-button
                          Consumer<CurrentUserProvider>(
                            builder: (ctx,currentUserProvider,_) {
                              return (currentUserProvider.currentUser.isPinchecked)?Center(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3A3A3A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.lock_clock_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      LockScreen.routeName,
                                    );
                                  },
                                  label: Text(
                                    "Lock Screen",
                                    style: TextStyle(color: AppColors.textPrimary),
                                  ),
                                ),
                              ):SizedBox();
                            }
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      elevation: 8,
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  //Get-user-availability-status-color
  Color _getStatusColor(UserStatus status) {
    switch (status) {
      case UserStatus.available:
        return Colors.green;
      case UserStatus.away:
        return Colors.yellow;
      case UserStatus.busy:
        return Colors.red;
      case UserStatus.offline:
        return Colors.grey;
    }
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
