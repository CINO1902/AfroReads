// To parse this JSON data, do
//
//     final publisherdetail = publisherdetailFromJson(jsonString);

import 'dart:convert';

Publisherdetail publisherdetailFromJson(String str) => Publisherdetail.fromJson(json.decode(str));

String publisherdetailToJson(Publisherdetail data) => json.encode(data.toJson());

class Publisherdetail {
    String status;
    List<Pub> pub;

    Publisherdetail({
        required this.status,
        required this.pub,
    });

    factory Publisherdetail.fromJson(Map<String, dynamic> json) => Publisherdetail(
        status: json["status"],
        pub: List<Pub>.from(json["pub"].map((x) => Pub.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "pub": List<dynamic>.from(pub.map((x) => x.toJson())),
    };
}

class Pub {
    String id;
    String name;
    String dateOfBirth;
    String email;
    String password;
    int v;

    Pub({
        required this.id,
        required this.name,
        required this.dateOfBirth,
        required this.email,
        required this.password,
        required this.v,
    });

    factory Pub.fromJson(Map<String, dynamic> json) => Pub(
        id: json["_id"],
        name: json["Name"],
        dateOfBirth: json["Date_of_birth"],
        email: json["email"],
        password: json["password"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "Name": name,
        "Date_of_birth": dateOfBirth,
        "email": email,
        "password": password,
        "__v": v,
    };
}
