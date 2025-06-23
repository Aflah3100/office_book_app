import 'package:hive_flutter/hive_flutter.dart';
import 'package:office_book_app/core/app_enums.dart';

part 'hive_check_in_entry_model.g.dart';
@HiveType(typeId: 3)
class HiveCheckInEntryModel {

  @HiveField(0)
  CheckInStatus userCheckInEntry;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  DateTime endTime;

  HiveCheckInEntryModel({
    required this.userCheckInEntry,
    required this.startTime,
    required this.endTime,
  });
}
