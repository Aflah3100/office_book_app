import 'package:hive/hive.dart';

part 'hive_monthly_log_model.g.dart';
@HiveType(typeId: 4)
class HiveMonthlyLogModel {

  @HiveField(0)
  String userId;

  @HiveField(1)
  String month;

  @HiveField(2)
  String totalHoursWorked;

  @HiveField(3)
  String totalHoursSpent;

  HiveMonthlyLogModel({
    required this.userId,
    required this.month,
    required this.totalHoursWorked,
    required this.totalHoursSpent
  });

}