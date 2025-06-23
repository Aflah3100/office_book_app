
import 'package:hive/hive.dart';

part 'hive_out_of_office_log_model.g.dart';
@HiveType(typeId: 5)
class HiveOutOfOfficeLogModel {

  @HiveField(0)
  String userId;

  @HiveField(1)
  DateTime startDate;

  @HiveField(2)
  DateTime endDate;

  @HiveField(3)
  String month;

  HiveOutOfOfficeLogModel({
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.month
  });
}
