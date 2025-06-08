import 'dart:convert';

import 'package:office_book_app/shared/constants/app_urls.dart';
import 'package:http/http.dart' as http;

class QuotesServices {
  QuotesServices._internal();
  static QuotesServices instance = QuotesServices._internal();
  factory QuotesServices() => instance;

  Future<String?> fetchtodaysQuote() async {
    final url = Uri.parse(AppUrls.todaysQuoteUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //Fetch-success
      final quote = response.body;

      return quote;
    }

    return null;
  }
}
