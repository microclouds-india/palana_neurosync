// To parse this JSON data, do
//
//     final getNotify = getNotifyFromJson(jsonString);

import 'dart:convert';

GetNotify getNotifyFromJson(String str) => GetNotify.fromJson(json.decode(str));


class GetNotify {
    GetNotify({
        this.message,
        this.data,
        this.status,
    });

    String? message;
    List<Datum>? data;
    String? status;

    factory GetNotify.fromJson(Map<String, dynamic> json) => GetNotify(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );
}

class Datum {
    Datum({
        this.id,
        this.medicineName,
        this.price,
        this.tdate,
        this.ttime,
    });

    String? id;
    String? medicineName;
    String? price;
    DateTime? tdate;
    String? ttime;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        medicineName: json["medicine_name"],
        price: json["price"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );
}
