// To parse this JSON data, do
//
//     final profileViewModel = profileViewModelFromJson(jsonString);

import 'dart:convert';

ProfileViewModel profileViewModelFromJson(String str) => ProfileViewModel.fromJson(json.decode(str));


class ProfileViewModel {
    ProfileViewModel({
        this.message,
        this.data,
        this.status,
    });

    String? message;
    List<Datum>? data;
    String? status;

    factory ProfileViewModel.fromJson(Map<String, dynamic> json) => ProfileViewModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );
}

class Datum {
    Datum({
        this.id,
        this.name,
        this.phone,
        this.email,
    });

    String? id;
    String? name;
    String? phone;
    String? email;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
    );
}
