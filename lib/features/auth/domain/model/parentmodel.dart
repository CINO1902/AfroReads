// To parse this JSON data, do
//
//     final parentdetails = parentdetailsFromJson(jsonString);

import 'dart:convert';

Parentdetails parentdetailsFromJson(String str) =>
    Parentdetails.fromJson(json.decode(str));

String parentdetailsToJson(Parentdetails data) => json.encode(data.toJson());

class Parentdetails {
  String? status;
  List<Msg> msg;

  Parentdetails({
    this.status,
    required this.msg,
  });

  factory Parentdetails.fromJson(Map<String, dynamic> json) => Parentdetails(
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
  String fullname;
  String email;
  String password;
  String dateOfBirthDay;
  String dateOfBirthMonth;
  String dateOfBirthYear;
  String securityQuestion;
  String securityAnswer;
  String token;
  DateTime date;
  int v;

  Msg({
    required this.id,
    required this.fullname,
    required this.email,
    required this.password,
    required this.dateOfBirthDay,
    required this.dateOfBirthMonth,
    required this.dateOfBirthYear,
    required this.securityQuestion,
    required this.securityAnswer,
    required this.token,
    required this.date,
    required this.v,
  });

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        id: json["_id"],
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
        dateOfBirthDay: json["date_of_birth_day"],
        dateOfBirthMonth: json["date_of_birth_month"],
        dateOfBirthYear: json["date_of_birth_year"],
        securityQuestion: json["Security_question"],
        securityAnswer: json["Security_answer"],
        token: json["token"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "email": email,
        "password": password,
        "date_of_birth_day": dateOfBirthDay,
        "date_of_birth_month": dateOfBirthMonth,
        "date_of_birth_year": dateOfBirthYear,
        "Security_question": securityQuestion,
        "Security_answer": securityAnswer,
        "token": token,
        "date": date.toIso8601String(),
        "__v": v,
      };
}
