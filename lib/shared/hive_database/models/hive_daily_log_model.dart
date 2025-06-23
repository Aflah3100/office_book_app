import 'package:hive_flutter/hive_flutter.dart';
import 'package:office_book_app/shared/hive_database/models/hive_check_in_entry_model.dart';
import 'package:office_book_app/shared/hive_database/models/hive_status_entry_model.dart';

part 'hive_daily_log_model.g.dart';
@HiveType(typeId: 1)
class HiveDailyLogModel {
  @HiveField(0)
  String userId;

  @HiveField(1)
  List<HiveStatusEntryModel> statusLogs;

  @HiveField(2)
  List<HiveCheckInEntryModel> checkInLogs;

  @HiveField(3)
  String workDaySummary;

  HiveDailyLogModel({
    required this.userId,
    required this.statusLogs,
    required this.checkInLogs,
    required this.workDaySummary,
  });
}



