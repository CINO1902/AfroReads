// To parse this JSON data, do
//
//     final parentkidmodel = parentkidmodelFromJson(jsonString);

import 'dart:convert';

Parentkidmodel parentkidmodelFromJson(String str) => Parentkidmodel.fromJson(json.decode(str));

String parentkidmodelToJson(Parentkidmodel data) => json.encode(data.toJson());

class Parentkidmodel {
    String status;
    List<Msg> msg;

    Parentkidmodel({
        required this.status,
        required this.msg,
    });

    factory Parentkidmodel.fromJson(Map<String, dynamic> json) => Parentkidmodel(
        status: json["status"],
        msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    };
}

class Msg {
    String id;
    String name;
    String dateOfBirth;
    String username;
    String parentEmail;
    String password;
    List<Time> time;
    int v;
    String? allowedBookAge;
    bool? restrictionMode;
    String? unsuitableGenres;
    String? readingLevel;
    bool? customTime;
    int? gentime;

    Msg({
        required this.id,
        required this.name,
        required this.dateOfBirth,
        required this.username,
        required this.parentEmail,
        required this.password,
        required this.time,
        required this.v,
        this.allowedBookAge,
        this.restrictionMode,
        this.unsuitableGenres,
        this.readingLevel,
        this.customTime,
        this.gentime,
    });

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        id: json["_id"],
        name: json["Name"],
        dateOfBirth: json["Date_of_birth"],
        username: json["Username"],
        parentEmail: json["parent_email"],
        password: json["password"],
        time: List<Time>.from(json["time"].map((x) => Time.fromJson(x))),
        v: json["__v"],
        allowedBookAge: json["allowed_book_age"],
        restrictionMode: json["Restriction_mode"],
        unsuitableGenres: json["unsuitable_genres"],
        readingLevel: json["reading_level"],
        customTime: json["custom_time"],
        gentime: json["gentime"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "Name": name,
        "Date_of_birth": dateOfBirth,
        "Username": username,
        "parent_email": parentEmail,
        "password": password,
        "time": List<dynamic>.from(time.map((x) => x.toJson())),
        "__v": v,
        "allowed_book_age": allowedBookAge,
        "Restriction_mode": restrictionMode,
        "unsuitable_genres": unsuitableGenres,
        "reading_level": readingLevel,
        "custom_time": customTime,
        "gentime": gentime,
    };
}

class Time {
    int? monday;
    String id;
    int? tuesday;
    int? wednesday;
    int? thursday;
    int? friday;
    int? saturday;
    int? sunday;

    Time({
        this.monday,
        required this.id,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday,
        this.saturday,
        this.sunday,
    });

    factory Time.fromJson(Map<String, dynamic> json) => Time(
        monday: json["Monday"],
        id: json["_id"],
        tuesday: json["Tuesday"],
        wednesday: json["Wednesday"],
        thursday: json["Thursday"],
        friday: json["Friday"],
        saturday: json["Saturday"],
        sunday: json["Sunday"],
    );

    Map<String, dynamic> toJson() => {
        "Monday": monday,
        "_id": id,
        "Tuesday": tuesday,
        "Wednesday": wednesday,
        "Thursday": thursday,
        "Friday": friday,
        "Saturday": saturday,
        "Sunday": sunday,
    };
}
