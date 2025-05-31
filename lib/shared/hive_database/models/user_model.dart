//Hive user model for storing user details

import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class HiveUserModel extends HiveObject {
  @HiveField(1)
  String firstName;

  @HiveField(2)
  String? lastName;

  @HiveField(3)
  String email;

  @HiveField(4)
  String password;

  @HiveField(5)
  String joinDate;

  HiveUserModel({
    required this.firstName,
    this.lastName,
    required this.email,
    required this.password,
    required this.joinDate,
  });
}
