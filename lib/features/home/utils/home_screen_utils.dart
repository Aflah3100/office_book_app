import 'package:office_book_app/core/app_enums.dart';

class HomeScreenUtilFunctions {
  static String fetchGreetingMessage() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  static String getFormattedDate(DateType type) {
    final now = DateTime.now();

    switch (type) {
      case DateType.day:
        return now.day.toString();
      case DateType.month:
        return now.month.toString();
      case DateType.monthString:
        return _getMonthName(now.month);
      case DateType.year:
        return now.year.toString();
      case DateType.all:
        return "${now.day} ${_getMonthName(now.month)}, ${_getTodayDayName()}";
    }
  }

  static String _getMonthName(int month) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return monthNames[month - 1];
  }

  static String _getTodayDayName() {
  final now = DateTime.now();
  const weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  return weekDays[now.weekday - 1];
}
}
