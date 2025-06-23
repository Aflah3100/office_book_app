import 'package:flutter/widgets.dart';
import 'package:office_book_app/core/app_enums.dart';

//Provider to manager nav bar state
class NavBarProvider with ChangeNotifier {
  NavItems _selectedNavItem = NavItems.dashboard;

  void setNavItem(NavItems navItem) {
    _selectedNavItem = navItem;
    notifyListeners();
  }

  NavItems getSelectedNavItem() => _selectedNavItem;
}
