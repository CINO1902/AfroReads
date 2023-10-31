// To parse this JSON data, do
//
//     final getbookPros = getbookProsFromJson(jsonString);

import 'dart:convert';

GetbookPros getbookProsFromJson(String str) => GetbookPros.fromJson(json.decode(str));

String getbookProsToJson(GetbookPros data) => json.encode(data.toJson());

class GetbookPros {
    String status;
    Notific notific;

    GetbookPros({
        required this.status,
        required this.notific,
    });

    factory GetbookPros.fromJson(Map<String, dynamic> json) => GetbookPros(
        status: json["status"],
        notific: Notific.fromJson(json["notific"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "notific": notific.toJson(),
    };
}

class Notific {
    List<Pagnitedbook> pagnitedbooks;
    Next next;
    Next previous;

    Notific({
        required this.pagnitedbooks,
        required this.next,
        required this.previous,
    });

    factory Notific.fromJson(Map<String, dynamic> json) => Notific(
        pagnitedbooks: List<Pagnitedbook>.from(json["pagnitedbooks"].map((x) => Pagnitedbook.fromJson(x))),
        next: Next.fromJson(json["next"]),
        previous: Next.fromJson(json["previous"]),
    );

    Map<String, dynamic> toJson() => {
        "pagnitedbooks": List<dynamic>.from(pagnitedbooks.map((x) => x.toJson())),
        "next": next.toJson(),
        "previous": previous.toJson(),
    };
}

class Next {
    int page;
    int limit;

    Next({
        required this.page,
        required this.limit,
    });

    factory Next.fromJson(Map<String, dynamic> json) => Next(
        page: json["page"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
    };
}

class Pagnitedbook {
    String id;
    int pagnitedbookId;
    String bookTitle;
    String authorName;
    String review;
    String noRated;
    String preview;
    String link;
    String addedBy;
    String imageUrl;
    String? genre;
    int v;
    String? pagnitedbookGenre;

    Pagnitedbook({
        required this.id,
        required this.pagnitedbookId,
        required this.bookTitle,
        required this.authorName,
        required this.review,
        required this.noRated,
        required this.preview,
        required this.link,
        required this.addedBy,
        required this.imageUrl,
        this.genre,
        required this.v,
        this.pagnitedbookGenre,
    });

    factory Pagnitedbook.fromJson(Map<String, dynamic> json) => Pagnitedbook(
        id: json["_id"],
        pagnitedbookId: json["id"],
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
        pagnitedbookGenre: json["genre"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "id": pagnitedbookId,
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
        "genre": pagnitedbookGenre,
    };
}
