import 'package:flutter/material.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:office_book_app/core/app_enums.dart';
import 'package:office_book_app/features/auth/screens/lock_screen.dart';
import 'package:office_book_app/shared/providers/current_user_provider.dart';
import 'package:provider/provider.dart';

class CollapsibleNavBar extends StatefulWidget {
  final NavItems selectedItem;
  final Function(NavItems) onItemSelected;

  const CollapsibleNavBar({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  State<CollapsibleNavBar> createState() => _CollapsibleNavBarState();
}

class _CollapsibleNavBarState extends State<CollapsibleNavBar> {
  bool isExpanded = false;

  void toggleNav() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isExpanded ? 200 : 70,
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.dividerColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          // Toggle Button
          IconButton(
            icon: Icon(
              isExpanded
                  ? Iconsax.arrow_square_left_outline
                  : Iconsax.menu_outline,
            ),
            color: Colors.white,
            onPressed: toggleNav,
          ),
          const SizedBox(height: 10),

          // Nav Items
          _buildNavItem(
            (BoxIcons.bxs_dashboard),
            "Dashboard",
            NavItems.dashboard,
          ),
          _buildNavItem(BoxIcons.bx_calendar, "Daily Fill", NavItems.dailyFill),

          Spacer(),

          //Lock-Screen-button
          Consumer<CurrentUserProvider>(
            builder: (ctx, currentUserProvider, _) {
              return (currentUserProvider.currentUser.isPinchecked)
                  ? CollapsibleLockButton(isExpanded: isExpanded)
                  : SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, NavItems item) {
    final isSelected = widget.selectedItem == item;
    return InkWell(
      onTap: () => widget.onItemSelected(item),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Color.fromRGBO(255, 94, 0, 0.15)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              color:
                  (isSelected)
                      ? AppColors.primaryOrange
                      : AppColors.primaryOrangeLight,
            ),
            if (isExpanded) const SizedBox(width: 10),
            if (isExpanded)
              Expanded(
                child: Text(label, style: TextStyle(color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }
}

class CollapsibleLockButton extends StatelessWidget {
  const CollapsibleLockButton({super.key, required this.isExpanded});

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            (isExpanded) ? const Color(0xFF3A3A3A) : AppColors.dividerColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: Center(
        child: Icon(
          Iconsax.lock_1_bold,
          color: AppColors.primaryOrange,
          size: (isExpanded) ? 18 : 25,
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, LockScreen.routeName);
      },

      label:
          ((isExpanded))
              ? Text(
                "Lock Screen",
                style: TextStyle(color: AppColors.textPrimary),
              )
              : SizedBox(),
    );
  }
}
