import 'dart:convert';

GetReadingBooks getReadingBooksFromJson(String str) =>
    GetReadingBooks.fromJson(json.decode(str));

String getReadingBooksToJson(GetReadingBooks data) =>
    json.encode(data.toJson());

class GetReadingBooks {
  List<String> keyword;

  GetReadingBooks({
    required this.keyword,
  });

  factory GetReadingBooks.fromJson(Map<String, dynamic> json) =>
      GetReadingBooks(
        keyword: List<String>.from(json["keyword"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "keyword": List<dynamic>.from(keyword.map((x) => x)),
      };
}
