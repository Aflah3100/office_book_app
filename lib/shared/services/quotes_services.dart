import 'dart:convert';

import 'package:office_book_app/shared/constants/app_urls.dart';
import 'package:office_book_app/shared/hive_database/models/quotes_model.dart';
import 'package:http/http.dart' as http;

class QuotesServices {
  QuotesServices._internal();
  static QuotesServices instance = QuotesServices._internal();
  factory QuotesServices() => instance;

  Future<QuotesModel?> fetchQuote() async {
    final url = Uri.parse(AppUrls.programQuotesUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //Fetch-success
      final quoteModel = QuotesModel.fromJson(jsonDecode(response.body));
      return quoteModel;
    }

    return null;
  }
}
