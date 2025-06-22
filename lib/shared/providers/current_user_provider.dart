//Current user session details

import 'package:flutter/widgets.dart';
import 'package:office_book_app/shared/hive_database/models/hive_user_model.dart';
import 'package:office_book_app/shared/models/user_model.dart';

class CurrentUserProvider with ChangeNotifier {
  UserModel _currentUser = UserModel(
    userId: '',
    firstName: '',
    lastName: '',
    email: '',
    dateOfJoin: '',
    isPinchecked: false,
  );

  bool _isInfoLoaded = false;

  bool get isInfoLoaded => _isInfoLoaded;

  UserModel get currentUser => _currentUser;

  void setUser(String user) {
    _currentUser = UserModel.fromJson(user);
    notifyListeners();
  }

  void setLoadStatus(bool status) {
    _isInfoLoaded = status;
    notifyListeners();
  }
}
