// To parse this JSON data, do
//
//     final uploadbook = uploadbookFromJson(jsonString);

import 'dart:convert';

Uploadbook uploadbookFromJson(String str) => Uploadbook.fromJson(json.decode(str));

String uploadbookToJson(Uploadbook data) => json.encode(data.toJson());

class Uploadbook {
    String bookTitle;
    String authorName;
    String? review;
    String? noRated;
    String preview;
    String link;
    String addedBy;
    String imageUrl;
    String genre;

    Uploadbook({
        required this.bookTitle,
        required this.authorName,
         this.review,
         this.noRated,
        required this.preview,
        required this.link,
        required this.addedBy,
        required this.imageUrl,
        required this.genre,
    });

    factory Uploadbook.fromJson(Map<String, dynamic> json) => Uploadbook(
        bookTitle: json["book_title"],
        authorName: json["author_name"],
        review: json["Review"],
        noRated: json["No_rated"],
        preview: json["Preview"],
        link: json["link"],
        addedBy: json["added_by"],
        imageUrl: json["image_url"],
        genre: json["genre"],
    );

    Map<String, dynamic> toJson() => {
        "book_title": bookTitle,
        "author_name": authorName,
        "Review": review,
        "No_rated": noRated,
        "Preview": preview,
        "link": link,
        "added_by": addedBy,
        "image_url": imageUrl,
        "genre": genre,
    };
}
