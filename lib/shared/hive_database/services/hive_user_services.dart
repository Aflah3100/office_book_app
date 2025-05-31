//Hive User database Services Class
import 'package:hive/hive.dart';
import 'package:office_book_app/shared/hive_database/models/user_model.dart';
import 'package:office_book_app/shared/hive_database/services/hive_initializer.dart';

class HiveUserServices {
  //Singleton-Class
  HiveUserServices._internal();
  static HiveUserServices instance = HiveUserServices._internal();
  factory HiveUserServices() => instance;

  final userBox = HiveInitializer.instance.userBox;

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

  bool checkUserExists({required String email}) {
    try {
      return userBox.containsKey(email);
    } catch (e) {
      return false;
    }
  }
}
