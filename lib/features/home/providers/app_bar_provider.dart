import 'package:flutter/widgets.dart';
import 'package:office_book_app/core/app_enums.dart';

//Provider for managing app bar state.
class AppBarProvider with ChangeNotifier {
  UserStatus _userStatus = UserStatus.available;

  UserStatus getUserStatus() => _userStatus;
  void setUserStatus(UserStatus userStatus) {
    _userStatus = userStatus;
    notifyListeners();
  }
}
