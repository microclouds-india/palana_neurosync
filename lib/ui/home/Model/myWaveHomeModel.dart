// To parse this JSON data, do
//
//     final myCourseHomeModel = myCourseHomeModelFromJson(jsonString);

import 'dart:convert';

MyCourseHomeModel myCourseHomeModelFromJson(String str) => MyCourseHomeModel.fromJson(json.decode(str));

String myCourseHomeModelToJson(MyCourseHomeModel data) => json.encode(data.toJson());

class MyCourseHomeModel {
    MyCourseHomeModel({
        this.message,
        this.data,
        this.status,
    });

    String? message;
    List<Datum>? data;
    String? status;

    factory MyCourseHomeModel.fromJson(Map<String, dynamic> json) => MyCourseHomeModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
    };
}

class Datum {
    Datum({
        this.id,
        this.price,
        this.days,
        this.courseName,
        this.tdate,
        this.ttime,
    });

    String? id;
    String? price;
    String? days;
    String? courseName;
    String? tdate;
    String? ttime;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        price: json["price"],
        days: json["days"],
        courseName: json["course_name"],
        tdate: json["tdate"],
        ttime: json["ttime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "days": days,
        "course_name": courseName,
        "tdate": tdate,
        "ttime": ttime,
    };
}
