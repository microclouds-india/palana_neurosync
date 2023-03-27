class CourseViewModel {
  String? message;
  List<CourseData>? data;
  String? status;

  CourseViewModel({this.message, this.data, this.status});

  CourseViewModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <CourseData>[];
      json['data'].forEach((v) {
        data!.add(new CourseData.fromJson(v));
      });
    }
    status = json['status'];
  }
}

class CourseData {
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
  List<CourseImageData>? image;
  List<CourseFileData>? files;

  CourseData(
      {this.id,
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
      this.files});

  CourseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    benefits = json['benefits'];
    audioUrl = json['audio_url'];
    videoUrl = json['video_url'];
    days = json['days'];
    price = json['price'];
    cutPrice = json['cut_price'];
    tdate = json['tdate'];
    ttime = json['ttime'];
    if (json['image'] != null) {
      image = <CourseImageData>[];
      if (json['image']['data'] != null) {
        json['image']['data'].forEach((v) {
          image!.add(new CourseImageData.fromJson(v));
        });
      } else {
        image!.add(new CourseImageData.fromJson(json['image']));
      }
    }
    if (json['files'] != null) {
      files = <CourseFileData>[];
      json['files']['data'].forEach((v) {
        files!.add(new CourseFileData.fromJson(v));
      });
    }
  }
}

class CourseImageData {
  String? id;
  String? image;

  CourseImageData({this.id, this.image});

  CourseImageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class CourseFileData {
  String? id;
  String? fileUrl;

  CourseFileData({this.id, this.fileUrl});

  CourseFileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileUrl = json['file_url'];
  }
}
