import 'package:hive_flutter/hive_flutter.dart';
import 'package:office_book_app/shared/hive_database/models/hive_user_model.dart';

class HiveInitializer {
  HiveInitializer._internal();
  static HiveInitializer instance = HiveInitializer._internal();
  factory HiveInitializer() => instance;

  static const _userBox = 'users-Box';

  Future<void> initHive() async {
    //Initialize-Hive
    await Hive.initFlutter();

    //Register-Adapters
    Hive.registerAdapter(HiveUserModelAdapter());

    //Open-hive-boxes
    await Hive.openBox<HiveUserModel>(_userBox);
  }

  Box<HiveUserModel> get userBox => Hive.box<HiveUserModel>(_userBox);
}
