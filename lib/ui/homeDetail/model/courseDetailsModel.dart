// To parse this JSON data, do
//
//     final myCourse = myCourseFromJson(jsonString);

import 'dart:convert';

MyCourse myCourseFromJson(String str) => MyCourse.fromJson(json.decode(str));


class MyCourse {
    MyCourse({
        this.message,
        this.data,
        this.status,
    });

    String? message;
    List<Datum>? data;
    String? status;

    factory MyCourse.fromJson(Map<String, dynamic> json) => MyCourse(
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
