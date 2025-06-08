class QuotesModel {
  String? author;
  String? quote;

  QuotesModel({this.author, this.quote});

  QuotesModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    quote = json['quote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['quote'] = quote;
    return data;
  }
}
