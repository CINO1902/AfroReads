// To parse this JSON data, do
//
//     final createkidprofile = createkidprofileFromJson(jsonString);

import 'dart:convert';

RestrictMode restrictModeFromJson(String str) =>
    RestrictMode.fromJson(json.decode(str));

String restrictModeToJson(RestrictMode data) => json.encode(data.toJson());

class RestrictMode {
  bool restrict;
  String age;
  String username;

  RestrictMode({
    required this.restrict,
    required this.age,
    required this.username,
  });

  factory RestrictMode.fromJson(Map<String, dynamic> json) => RestrictMode(
        restrict: json["restrict"],
        age: json["age"],
        username:json["username"]
      );

  Map<String, dynamic> toJson() => {
        "restrict": restrict,
        "age": age,
        "username":username
      };
}
