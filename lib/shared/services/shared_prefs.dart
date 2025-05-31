import 'package:office_book_app/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._internal();
  static SharedPrefs instance = SharedPrefs._internal();
  factory SharedPrefs() => instance;

  final String _userModelKey = 'logged-in-user';

  //Create shared pref object using user model object
  Future<bool> saveLoggedUser({required UserModel user}) async {
    final sharedPrefObject = await SharedPreferences.getInstance();
    await sharedPrefObject.setString(_userModelKey, user.toJson());
    return true;
  }

  //retrieve user model object from shared pref
  Future<UserModel?> getLoggedUser() async {
    final sharedPrefObject = await SharedPreferences.getInstance();
    String? userModelJson = sharedPrefObject.getString(_userModelKey);
    if (userModelJson != null) {
      return UserModel.fromJson(userModelJson);
    }
    return null;
  }

  // delete user model from shared pref
  Future<void> deleteLoggedUser() async {
    final sharedPrefObject = await SharedPreferences.getInstance();
    sharedPrefObject.remove(_userModelKey);
  }
}
