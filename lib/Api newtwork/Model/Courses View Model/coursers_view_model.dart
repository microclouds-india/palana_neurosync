// To parse this JSON data, do
//
//     final cousersViewModel = cousersViewModelFromJson(jsonString);

import 'dart:convert';

CousersViewModel cousersViewModelFromJson(String str) => CousersViewModel.fromJson(json.decode(str));


class CousersViewModel {
    CousersViewModel({
        this.message,
        this.data,
        this.status,
    });

    String? message;
    List<CousersViewModelDatum>? data;
    String? status;

    factory CousersViewModel.fromJson(Map<String, dynamic> json) => CousersViewModel(
        message: json["message"],
        data: List<CousersViewModelDatum>.from(json["data"].map((x) => CousersViewModelDatum.fromJson(x))),
        status: json["status"],
    );
}

class CousersViewModelDatum {
    CousersViewModelDatum({
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
        this.image,
        this.audios,
        this.videos,
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
    String? image;
    String? audios;
    String? videos;

    factory CousersViewModelDatum.fromJson(Map<String, dynamic> json) => CousersViewModelDatum(
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
        image: json["image"],
        audios:json["audios"],
        videos: json["videos"],
    );
}

class AudioDta {
    AudioDta({
        this.data,
    });

    List<AudiosDatum>? data;

    factory AudioDta.fromJson(Map<String, dynamic> json) => AudioDta(
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

class VideoDta {
    VideoDta({
        this.data,
    });

    List<VideosDatum>? data;

    factory VideoDta.fromJson(Map<String, dynamic> json) => VideoDta(
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
}
