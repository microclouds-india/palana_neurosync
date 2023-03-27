// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MoreWavesModel welcomeFromJson(String str) => MoreWavesModel.fromJson(json.decode(str));

class MoreWavesModel {
  MoreWavesModel({
    this.message,
    this.data,
    this.status,
  });

  String? message;
  List<MoreWavesModelDatum>? data;
  String? status;

  factory MoreWavesModel.fromJson(Map<String, dynamic> json) => MoreWavesModel(
        message: json["message"],
        data: List<MoreWavesModelDatum>.from(
            json["data"].map((x) => MoreWavesModelDatum.fromJson(x))),
        status: json["status"],
      );
}

class MoreWavesModelDatum {
  MoreWavesModelDatum({
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

  factory MoreWavesModelDatum.fromJson(Map<String, dynamic> json) => MoreWavesModelDatum(
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

class Videos {
    Videos({
        this.data,
    });

    List<VideosDatum>? data;

    factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        data: List<VideosDatum>.from(json["data"].map((x) => VideosDatum.fromJson(x))),
    );
}

class VideosDatum {
    VideosDatum({
        this.id,
        this.videoUrl,
    });

    String? id;
    String? videoUrl;

    factory VideosDatum.fromJson(Map<String, dynamic> json) => VideosDatum(
        id: json["id"],
        videoUrl: json["video_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "video_url": videoUrl,
    };
}

class Audios {
    Audios({
        this.data,
    });

    List<AudiosDatum>? data;

    factory Audios.fromJson(Map<String, dynamic> json) => Audios(
        data: List<AudiosDatum>.from(json["data"].map((x) => AudiosDatum.fromJson(x))),
    );

}

class AudiosDatum {
    AudiosDatum({
        this.id,
        this.audioUrl,
    });

    String? id;
    String? audioUrl;

    factory AudiosDatum.fromJson(Map<String, dynamic> json) => AudiosDatum(
        id: json["id"],
        audioUrl: json["audio_url"],
    );
}