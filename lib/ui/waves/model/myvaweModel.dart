// To parse this JSON data, do
//
//     final mywaveModel = mywaveModelFromJson(jsonString);

import 'dart:convert';

MywaveModel mywaveModelFromJson(String str) => MywaveModel.fromJson(json.decode(str));

class MywaveModel {
    MywaveModel({
        this.message,
        this.data,
        this.status,
    });

    String? message;
    List<Datum>? data;
    String? status;

    factory MywaveModel.fromJson(Map<String, dynamic> json) => MywaveModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );
}

class Datum {
    Datum({
        this.id,
        this.courseId,
        this.price,
        this.days,
        this.courseName,
        this.tdate,
        this.ttime,
    });

    String? id;
    String? courseId;
    String? price;
    String? days;
    String? courseName;
    String? tdate;
    String? ttime;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        courseId: json["course_id"],
        price: json["price"],
        days: json["days"],
        courseName: json["course_name"],
        tdate: json["tdate"],
        ttime: json["ttime"],
    );

}
