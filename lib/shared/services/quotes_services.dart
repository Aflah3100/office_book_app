
import 'package:office_book_app/core/app_enums.dart';
import 'package:office_book_app/features/home/utils/home_screen_utils.dart';
import 'package:office_book_app/shared/constants/app_urls.dart';
import 'package:http/http.dart' as http;

class QuotesServices {
  QuotesServices._internal();
  static QuotesServices instance = QuotesServices._internal();
  factory QuotesServices() => instance;

  Future<String?> fetchtodaysQuote() async {
    final month = HomeScreenUtilFunctions.getFormattedDate(DateType.month);
    final day = HomeScreenUtilFunctions.getFormattedDate(DateType.day);
    final url = Uri.parse("${AppUrls.todaysQuoteUrl}/$month/$day/date");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //Fetch-success
      final quote = response.body;

      return quote;
    }

    return null;
  }
}
