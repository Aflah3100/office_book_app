
import 'package:hive/hive.dart';

part 'hive_yearly_log_model.g.dart';
@HiveType(typeId: 6)
class HiveYearlyLogModel {

  @HiveField(0)
  String userId;

  @HiveField(1)
  String year;

  @HiveField(2)
  String totalHoursWorked;

  @HiveField(3)
  String totalHoursSpent;

  HiveYearlyLogModel({
    required this.userId,
    required this.year,
    required this.totalHoursWorked,
    required this.totalHoursSpent
  });

}