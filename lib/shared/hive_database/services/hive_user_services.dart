//Hive User database Services Class
import 'package:hive/hive.dart';
import 'package:office_book_app/shared/hive_database/models/user_model.dart';

class HiveUserServices {
  //Singelton-Class
  HiveUserServices._internal();
  static HiveUserServices instance = HiveUserServices._internal();
  factory HiveUserServices() => instance;

  static const _boxName = 'users-Box';

  Box<UserModel> get userBox => Hive.box<UserModel>(_boxName);

  Future<bool> addUser({required UserModel userModel}) async {
    try {
      userBox.put(userModel.email, userModel);
      userBox.close();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel?> fetchUser({required String email}) async {
    try {
      return userBox.get(email);
    } catch (e) {
      return null;
    }
  }
}
