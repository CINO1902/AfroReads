// To parse this JSON data, do
//
//     final createkidprofile = createkidprofileFromJson(jsonString);

import 'dart:convert';

TimeModel timeModelFromJson(String str) => TimeModel.fromJson(json.decode(str));

String timeModelToJson(TimeModel data) => json.encode(data.toJson());

class TimeModel {
  bool custom;
  List<Map<String, dynamic>>? time;
  int? gentime;
  String username;

  TimeModel({
    required this.custom,
    this.time,
    this.gentime,
    required this.username,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) => TimeModel(
      custom: json["custom"],
      time: json["time"],
      gentime: json["gentime"],
      username: json["username"]);

  Map<String, dynamic> toJson() => {
        "custom": custom,
        "time": time,
        "gentime": gentime,
        "username": username
      };
}
