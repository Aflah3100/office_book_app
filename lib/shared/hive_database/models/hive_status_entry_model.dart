
import 'package:hive_flutter/hive_flutter.dart';
import 'package:office_book_app/core/app_enums.dart';

part 'hive_status_entry_model.g.dart';

@HiveType(typeId: 2)
class HiveStatusEntryModel {
  @HiveField(0)
  UserStatus userStatus;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  DateTime endTime;

  HiveStatusEntryModel({
    required this.userStatus,
    required this.startTime,
    required this.endTime,
  });
}