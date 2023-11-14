// To parse this JSON data, do
//
//     final createkidprofile = createkidprofileFromJson(jsonString);

import 'dart:convert';

Createkidprofile createkidprofileFromJson(String str) =>
    Createkidprofile.fromJson(json.decode(str));

String createkidprofileToJson(Createkidprofile data) =>
    json.encode(data.toJson());

class Createkidprofile {
  String fullname;
  String dateOfBirth;
  String username;

  Createkidprofile({
    required this.fullname,
    required this.dateOfBirth,
    required this.username,
  });

  factory Createkidprofile.fromJson(Map<String, dynamic> json) =>
      Createkidprofile(
        fullname: json["fullname"],
        dateOfBirth: json["Date_of_birth"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "Date_of_birth": dateOfBirth,
        "username": username,
      };
}
