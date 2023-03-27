// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

WaveList welcomeFromJson(String str) =>
    WaveList.fromJson(json.decode(str));

class WaveList {
  WaveList({
    this.message,
    this.data,
    this.status,
  });

  String? message;
  List<WaveListDatum>? data;
  String? status;

  factory WaveList.fromJson(Map<String, dynamic> json) => WaveList(
        message: json["message"],
        data: List<WaveListDatum>.from(
            json["data"].map((x) => WaveListDatum.fromJson(x))),
        status: json["status"],
      );
}

class WaveListDatum {
  WaveListDatum({
    this.id,
    this.title,
    this.description,
    this.benefits,
    this.audioUrl,
    this.videoUrl,
    this.days,
    this.price,
    this.cutPrice,
    this.tdate,
    this.ttime,
  });

  String? id;
  String? title;
  String? description;
  String? benefits;
  String? audioUrl;
  String? videoUrl;
  String? days;
  String? price;
  String? cutPrice;
  String? tdate;
  String? ttime;

  factory WaveListDatum.fromJson(Map<String, dynamic> json) =>
      WaveListDatum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        benefits: json["benefits"],
        audioUrl: json["audio_url"],
        videoUrl: json["video_url"],
        days: json["days"],
        price: json["price"],
        cutPrice: json["cut_price"],
        tdate: json["tdate"],
        ttime: json["ttime"],
      );
}

class ImgData {
  ImgData({
    this.data,
  });

  List<ImageDatum>? data;

  factory ImgData.fromJson(Map<String, dynamic> json) => ImgData(
        data: List<ImageDatum>.from(
            json["data"].map((x) => ImageDatum.fromJson(x))),
      );
}

class ImageDatum {
  ImageDatum({
    this.id,
    this.image,
  });

  String? id;
  String? image;

  factory ImageDatum.fromJson(Map<String, dynamic> json) => ImageDatum(
        id: json["id"],
        image: json["image"],
      );
}
