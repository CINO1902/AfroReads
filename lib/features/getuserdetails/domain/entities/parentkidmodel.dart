// To parse this JSON data, do
//
//     final parentkidmodel = parentkidmodelFromJson(jsonString);

import 'dart:convert';

Parentkidmodel parentkidmodelFromJson(String str) =>
    Parentkidmodel.fromJson(json.decode(str));

String parentkidmodelToJson(Parentkidmodel data) => json.encode(data.toJson());

class Parentkidmodel {
  String? status;
  List<Msg> msg;

  Parentkidmodel({
    this.status,
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
  String dateOfBirth;
  String username;
  String parentEmail;
  String password;
  int v;
  String name;

  Msg({
    required this.id,
    required this.dateOfBirth,
    required this.username,
    required this.parentEmail,
    required this.password,
    required this.v,
    required this.name,
  });

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        id: json["_id"],
        dateOfBirth: json["Date_of_birth"],
        username: json["Username"],
        parentEmail: json["parent_email"],
        password: json["password"],
        v: json["__v"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Date_of_birth": dateOfBirth,
        "Username": username,
        "parent_email": parentEmail,
        "password": password,
        "__v": v,
        "Name": name,
      };
}
