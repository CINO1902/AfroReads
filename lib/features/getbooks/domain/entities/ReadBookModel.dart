// To parse this JSON data, do
//
//     final getReadingBooksModel = getReadingBooksModelFromJson(jsonString);

import 'dart:convert';

GetReadingBooksModel getReadingBooksModelFromJson(String str) => GetReadingBooksModel.fromJson(json.decode(str));

String getReadingBooksModelToJson(GetReadingBooksModel data) => json.encode(data.toJson());

class GetReadingBooksModel {
    String status;
    List<ReadBook> readBook;

    GetReadingBooksModel({
        required this.status,
        required this.readBook,
    });

    factory GetReadingBooksModel.fromJson(Map<String, dynamic> json) => GetReadingBooksModel(
        status: json["status"],
        readBook: List<ReadBook>.from(json["ReadBook"].map((x) => ReadBook.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "ReadBook": List<dynamic>.from(readBook.map((x) => x.toJson())),
    };
}

class ReadBook {
    String id;
    int readBookId;
    String bookTitle;
    String authorName;
    String review;
    String noRated;
    String preview;
    String link;
    String addedBy;
    String imageUrl;
    String genre;
    int v;
    String suitableAge;

    ReadBook({
        required this.id,
        required this.readBookId,
        required this.bookTitle,
        required this.authorName,
        required this.review,
        required this.noRated,
        required this.preview,
        required this.link,
        required this.addedBy,
        required this.imageUrl,
        required this.genre,
        required this.v,
        required this.suitableAge,
    });

    factory ReadBook.fromJson(Map<String, dynamic> json) => ReadBook(
        id: json["_id"],
        readBookId: json["id"],
        bookTitle: json["book_title"],
        authorName: json["author_name"],
        review: json["Review"],
        noRated: json["No_rated"],
        preview: json["Preview"],
        link: json["link"],
        addedBy: json["added_by"],
        imageUrl: json["image_url"],
        genre: json["Genre"],
        v: json["__v"],
        suitableAge: json["suitable_age"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "id": readBookId,
        "book_title": bookTitle,
        "author_name": authorName,
        "Review": review,
        "No_rated": noRated,
        "Preview": preview,
        "link": link,
        "added_by": addedBy,
        "image_url": imageUrl,
        "Genre": genre,
        "__v": v,
        "suitable_age": suitableAge,
    };
}
