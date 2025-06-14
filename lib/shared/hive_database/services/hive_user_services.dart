import 'package:office_book_app/shared/hive_database/models/user_model.dart';
import 'package:office_book_app/shared/hive_database/services/hive_initializer.dart';

//Hive User database Services Class
class HiveUserServices {
  //Singleton-Class
  HiveUserServices._internal();
  static HiveUserServices instance = HiveUserServices._internal();
  factory HiveUserServices() => instance;

  final userBox = HiveInitializer.instance.userBox;

  Future<bool> addUser({required HiveUserModel userModel}) async {
    try {
      userBox.put(userModel.email, userModel);
      userBox.close();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<HiveUserModel?> fetchUser({required String email}) async {
    try {
      return userBox.get(email);
    } catch (e) {
      return null;
    }
  }

  bool checkUserExists({required String email}) {
    try {
      return userBox.containsKey(email);
    } catch (e) {
      return false;
    }
  }

  //Dev-Enviroment-function
  Future<void> clearAllUsers() async {
    userBox.clear();
  }
}
