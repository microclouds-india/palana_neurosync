// To parse this JSON data, do
//
//     final OTPtokenModel = OTPtokenModelFromJson(jsonString);

import 'dart:convert';

OTPtokenModel OTPtokenModelFromJson(String str) => OTPtokenModel.fromJson(json.decode(str));

String OTPtokenModelToJson(OTPtokenModel data) => json.encode(data.toJson());

class OTPtokenModel {
    OTPtokenModel({
        this.status,
        this.response,
        this.token,
        this.OTPtokenModelignup,
    });

    String? status;
    String? response;
    String? token;
    String? OTPtokenModelignup;

    factory OTPtokenModel.fromJson(Map<String, dynamic> json) => OTPtokenModel(
        status: json["status"],
        response: json["response"],
        token: json["token"],
        OTPtokenModelignup: json["user_signup"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "response": response,
        "token": token,
        "user_signup": OTPtokenModelignup,
    };
}
