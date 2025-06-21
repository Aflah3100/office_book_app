import 'package:flutter/material.dart';
import 'package:office_book_app/core/app_enums.dart';

class Loginprovider with ChangeNotifier {
  LoginState _loginState = LoginState.signIn;
  bool _mpinChecked = false;
  bool _aggrementChecked=false;

  void setLoginMode({required LoginState loginMode}) {
    _loginState = loginMode;
    notifyListeners();
  }

  void setmPinChecked(bool val) {
    _mpinChecked = val;
    notifyListeners();
  }

  void setAggrementChecked(bool val){
    _aggrementChecked=val;
    notifyListeners();
  }

  LoginState getLoginMode() => _loginState;

  bool getmPinChecked() => _mpinChecked;

  bool getAggrementChecked()=> _aggrementChecked;
}
