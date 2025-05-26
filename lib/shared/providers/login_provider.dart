import 'package:flutter/material.dart';
import 'package:office_book_app/core/app_enums.dart';

class Loginprovider with ChangeNotifier {
  LoginState _loginState = LoginState.signIn;

  void setLoginMode({required LoginState loginMode}) {
    _loginState = loginMode;
    notifyListeners();
  }

  LoginState getLoginMode() => _loginState;
}
