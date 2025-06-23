//Hive user model for storing user details

import 'package:hive/hive.dart';

part 'hive_user_model.g.dart';

@HiveType(typeId: 0)
class HiveUserModel extends HiveObject {
  @HiveField(0)
  String userId;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String? lastName;

  @HiveField(3)
  String email;

  @HiveField(4)
  String password;

  @HiveField(5)
  String? pin;

  @HiveField(6)
  String joinDate;

  HiveUserModel({
    required this.userId,
    required this.firstName,
    this.lastName,
    required this.email,
    required this.password,
    required this.joinDate,
    this.pin,
  });
}
