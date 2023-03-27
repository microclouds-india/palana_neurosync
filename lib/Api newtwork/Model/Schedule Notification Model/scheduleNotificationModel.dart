// To parse this JSON data, do
//
//     final getNotify = getNotifyFromJson(jsonString);

import 'dart:convert';

GetSchedulNotify getNotifyFromJson(String str) => GetSchedulNotify.fromJson(json.decode(str));

class GetSchedulNotify {
  GetSchedulNotify({
    this.message,
    this.data,
    this.status,
  });

  String? message;
  List<Datum>? data;
  String? status;

  factory GetSchedulNotify.fromJson(Map<String, dynamic> json) => GetSchedulNotify(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
      );
}

class Datum {
  Datum({
    this.id,
    this.message,
    this.tdate,
    this.ttime,
  });

  String? id;
  String? message;
  DateTime? tdate;
  String? ttime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        message: json["message"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
      );
}
