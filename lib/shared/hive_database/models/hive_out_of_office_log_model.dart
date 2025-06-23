
class HiveOutOfOfficeLogModel {
  String userId;
  DateTime startDate;
  DateTime endDate;
  String month;

  HiveOutOfOfficeLogModel({
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.month
  });
}
