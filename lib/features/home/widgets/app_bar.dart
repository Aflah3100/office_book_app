import 'package:flutter/material.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/core/app_enums.dart';
import 'package:office_book_app/features/home/providers/app_bar_provider.dart';
import 'package:office_book_app/shared/services/shared_prefs.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  final _searchFocusNode = FocusNode();
  final _searchFieldController = TextEditingController();

  @override
  void initState() {
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        context.read<AppBarProvider>().setShowSearch(false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchFieldController.dispose();
    super.dispose();
  }

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
          height: widget.preferredSize.height,

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
                child: SizedBox(
                  height: 40,
                  child: Consumer<AppBarProvider>(
                    builder: (ctx, provider, _) {
                      if (provider.getShowSearch()) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (!_searchFocusNode.hasFocus) {
                            _searchFocusNode.requestFocus();
                          }
                        });
                      }
                      return TextField(
                        focusNode: _searchFocusNode,
                        controller: _searchFieldController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF1F1F1F),
                          hintText: 'Set Status',
                          hintStyle: const TextStyle(color: Color(0xFFB3B3B3)),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
                              color: _getStatusColor(
                                provider.getUserStatus(),
                              ), // Available (change as needed)
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
      // ignore: use_build_context_synchronously
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
            height: 270, // Custom height
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
                            onPressed: () {},
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
                  Column(
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
                          "🟢 Available",
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
                          "🌙 Away",
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
                          "🔴 Busy",
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
                          "⚫ Offline",
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                      ),
                    ],
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
}
