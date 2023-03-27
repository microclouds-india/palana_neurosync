import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/Database/Init%20Database/initDatabase.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/subscribePackageSection.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/videoplayerAndAudio.dart';
import 'package:palana_neurosync/ui/packageDetails/view/packageDetailsPage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../allPackages/view/AllPackagesPage.dart';
import '../view/audiobottom.dart';

class PackageSection extends StatefulWidget {
  String id;
  String videourl;

  String packageName;
  String packageDiscription;
  String days;
  String prize;
  String cutPrize;
  String audioUrl;
  String benefits;
  String img;
  bool premiumUser;
  PackageSection(
      {required this.packageName,
      required this.premiumUser,
      required this.videourl,
      required this.id,
      required this.img,
      required this.benefits,
      required this.audioUrl,
      required this.packageDiscription,
      required this.days,
      required this.prize,
      required this.cutPrize});

  @override
  State<PackageSection> createState() => _PackageSectionState();
}

double _progress = 0;
bool downloading = false;

class _PackageSectionState extends State<PackageSection> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getBottomSheetPackage();
      },
      child: Card(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(widget.img, fit: BoxFit.cover),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.packageName}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${widget.packageDiscription}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: downloading
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  _progress = 0;
                                  downloading = false;
                                });
                              },
                              child: CircularPercentIndicator(
                                radius: 20.0,
                                lineWidth: 5.0,
                                percent: 1.0,
                                center: Text(
                                  _progress.toString(),
                                  style: TextStyle(fontSize: 10),
                                ),
                                progressColor: Colors.deepPurple.shade50,
                              ),
                            )
                          : IconButton(
                              onPressed: () async {
                                if (widget.premiumUser == true) {
                                  String? imagePath;
                                  await FileDownloader.downloadFile(
                                    url: widget.img,
                                    onDownloadCompleted: (path) {
                                      imagePath = path;
                                      print(imagePath);
                                    },
                                  );
                                  await FileDownloader.downloadFile(
                                    url: widget.audioUrl,
                                    name: widget.packageName,
                                    onProgress:
                                        (String? fileName, double progress) {
                                      setState(() {
                                        downloading = true;
                                      });
                                      setState(() {
                                        _progress = progress;
                                      });
                                    },
                                    onDownloadCompleted: (path) {
                                      setState(() async {
                                        addLocalDataBase(
                                            path,
                                            widget.packageName,
                                            widget.packageDiscription,
                                            imagePath!);
                                      });
                                    },
                                  );

                                  setState(() {
                                    downloading = false;
                                  });
                                } else {
                                  getBottomSheetPackage();
                                }
                              },
                              icon: Icon(
                                Icons.download_for_offline_outlined,
                                color: Colors.deepPurple.shade800,
                              ),
                            )),
                  const SizedBox(width: 10),
                  Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          // if (widget.premiumUser == true) {
                          // showModalBottomSheet(
                          //   context: context,
                          //   builder: (context) => MusicPlayerBottomSheet(
                          //     musicUrl: widget.free
                          //         ? 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'
                          //         : widget.audioUrl,
                          //   ),
                          // );
                          print(widget.audioUrl);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return VideoPlayerAndAudio(
                              videoUrl: widget.videourl,
                              AudioUrl: widget.audioUrl,
                            );
                          }));
                          // } else {
                          //   getBottomSheetPackage();
                          // }
                        },
                        icon: Icon(
                          Icons.play_circle_outline,
                          color: Colors.deepPurple.shade800,
                        ),
                        iconSize: 20,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getBottomSheetPackage() {
    return Get.bottomSheet(
      barrierColor: Colors.black.withOpacity(0.5),
      isDismissible: true,
      StatefulBuilder(
        builder: (context, setState) {
          return Wrap(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 40.0, left: 15.0, right: 15.0),
                padding: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: getIconData(Icons.close, Colors.red)),
                    SizedBox(height: 20),
                    textData("Start listening ${widget.packageName}", 13.0,
                        FontWeight.normal),
                    SizedBox(height: 20),
                    textData(
                        Strings().subscribe_package, 17.0, FontWeight.bold),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PackageDetailsPage(
                              id: widget.id,
                              packageName: widget.packageName,
                              description: widget.packageDiscription,
                              benafits: widget.benefits,
                              days: widget.days,
                              newPrize: widget.prize,
                              oldPrize: widget.cutPrize);
                        }));
                      },
                      child: SubscribePackageSection(
                          id: widget.id,
                          benefites: widget.benefits,
                          packageName: widget.packageName,
                          tittle: widget.packageName,
                          description: widget.packageDiscription,
                          days: widget.days,
                          newAmount: widget.prize,
                          oldAmount: widget.cutPrize),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          textData('View More', 10, FontWeight.bold),
                          SizedBox(width: 2),
                          getIconData(Icons.arrow_forward, Colors.black),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return AllPackagesPge();
                        }));
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget getIconData(IconData iconData, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Icon(
          iconData,
          color: color,
          size: 20,
        ),
      ),
    );
  }

  Widget textData(String text, double size, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: Colors.black,
        fontWeight: fontWeight,
      ),
    );
  }
}
