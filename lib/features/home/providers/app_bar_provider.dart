import 'package:flutter/widgets.dart';
import 'package:office_book_app/core/app_enums.dart';


//Provider for managing app bar state.
class AppBarProvider with ChangeNotifier {
  bool _showSearch = false;
  UserStatus _userStatus = UserStatus.available;

  bool getShowSearch() => _showSearch;
  void setShowSearch(bool value) {
    _showSearch = value;
    notifyListeners();
  }

  UserStatus getUserStatus() => _userStatus;
  void setUserStatus(UserStatus userStatus) {
    _userStatus = userStatus;
    notifyListeners();
  }
}
