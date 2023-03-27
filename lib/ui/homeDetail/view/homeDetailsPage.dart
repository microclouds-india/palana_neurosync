import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:palana_neurosync/Api%20newtwork/Model/More%20waves%20model/more_waves_model.dart';
import 'package:palana_neurosync/Screens/Reminder/reminderScreenUi.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/benifitsSection.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/packageSection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Screens/Video Player/video_player.dart';
import 'package:http/http.dart' as http;

import '../../../common/strings.dart';
import '../../allPackages/view/AllPackagesPage.dart';
import '../../home/Model/myWaveHomeModel.dart';
import '../../packageDetails/view/packageDetailsPage.dart';
import '../model/courseviewModel.dart';
import '../widgets/subscribePackageSection.dart';

// GetView<HomeDetailsController>
class HomeDetailsPage extends StatefulWidget {
  String id;
  String img;
  bool free;
  String? tittle;
  String? description;
  String? videoLink;
  String? audioUrl;
  String? benefits;
  String packageName;
  String packageDiscription;
  String days;
  String prize;
  String cutPrize;
  HomeDetailsPage(
      {required this.tittle,
      required this.img,
      required this.free,
      required this.description,
      required this.videoLink,
      required this.benefits,
      required this.audioUrl,
      required this.packageName,
      required this.packageDiscription,
      required this.days,
      required this.prize,
      required this.id,
      required this.cutPrize});

  @override
  State<HomeDetailsPage> createState() => _HomeDetailsPageState();
}

AudioPlayer _audioPlayer = AudioPlayer();
Duration _duration = Duration.zero;
Duration _position = Duration.zero;
bool playing = false;
bool _loading = false;
bool? premiumUser = false;
List myCourseids = [];
double _currentSliderValue = 20;


class _HomeDetailsPageState extends State<HomeDetailsPage> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // GestureDetector(
          //   onTap: () {
          //     // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          //     //   return MusicPlayerScreen();
          //     // }));
          //   },
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: 80,
          //     decoration: BoxDecoration(
          //         border: Border.all(color: Colors.grey),
          //         borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(10),
          //             topRight: Radius.circular(10))),
          //     child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             IconButton(
          //                 onPressed: () {},
          //                 icon: Icon(
          //                   Icons.skip_previous,
          //                   color: bColor,
          //                 )),
          //             Container(
          //               decoration: BoxDecoration(
          //                   shape: BoxShape.circle, color: bColor),
          //               child: IconButton(
          //                   onPressed: () async {
          //                     String musicUrl = widget.audioUrl!;
          //                     if (playing) {
          //                       await audioPlayer.pause();
          //                       setState(() {
          //                         playing = false;
          //                       });
          //                     } else {
          //                       String musicUrl = widget.audioUrl!;
          //                       await audioPlayer.play(UrlSource(musicUrl));
          //                       setState(() {
          //                         playing = true;
          //                       });
          //                     }
          //                   },
          //                   icon: Icon(
          //                     playing == false ? Icons.play_arrow : Icons.pause,
          //                     color: Colors.white,
          //                   )),
          //             ),
          //             IconButton(
          //                 onPressed: () {},
          //                 icon: Icon(
          //                   Icons.skip_next,
          //                   color: bColor,
          //                 )),
          //             // SingleChildScrollView(
          //             //   child: Column(
          //             //     mainAxisAlignment: MainAxisAlignment.start,
          //             //     children: [

          //             Slider.adaptive(
          //                 thumbColor: bColor,
          //                 secondaryActiveColor: Colors.pink,
          //                 min: 0.0,
          //                 max: _duration.inSeconds.toDouble(),
          //                 value: _position.inSeconds.toDouble(),
          //                 onChanged: (value) {}),
          //             //     ],
          //             //   ),
          //             // ),
          //             Text('')
          //           ],
          //         )),
          //   ),
          // ),
        ],
      ),
      backgroundColor: Colors.white,
      body:  SingleChildScrollView(
              child: Column(
                children: [
                  headerSection(),
                  textDescriptionSection(),
                  BenifitsSection(benefits: widget.benefits!),
                  !widget.free
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return PackageSection(
                                videourl: 'audioData.data[index].files[index].fileUrl',
                                premiumUser: premiumUser!,
                                img: 'audioData.data[index].images[index].image',
                                id: widget.id,
                               
                                benefits: widget.benefits!,
                                audioUrl: "audioData.data[index].files[index+1].fileUrl",
                                packageName: widget.tittle!,
                                cutPrize: widget.cutPrize,
                                days: widget.days,
                                packageDiscription: widget.description!,
                                prize: widget.prize);
                          },
                        )
                      : PackageSection(
                          videourl: widget.videoLink!,
                          img: widget.img,
                          premiumUser: premiumUser!,
                          id: widget.id,
                         
                          benefits: widget.benefits!,
                          audioUrl: widget.audioUrl!,
                          packageName: widget.tittle!,
                          cutPrize: widget.cutPrize,
                          days: widget.days,
                          packageDiscription: widget.description!,
                          prize: widget.prize),
                ],
              ),
            )
         
    );
  }

  Widget headerSection() {
    return Stack(
      children: [
        Image(
          width: double.infinity,
          height: 280,
          image: NetworkImage(widget.img),
          fit: BoxFit.cover,
        ),
        Container(
          height: 280,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.pink.shade600.withOpacity(0.4),
                  Colors.deepPurple.shade800.withOpacity(0.4),
                ]),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SafeArea(
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                      SafeArea(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.lock, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // getBottomSheetMusic();
                        if (premiumUser == true) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return VideoPlayer(videoUrl: widget.videoLink);
                          }));
                        } else {
                          getFreeBottomSheetPackage();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: Icon(Icons.play_circle,
                            size: 45, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget textDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Text(
            widget.tittle!,
            style: TextStyle(
              fontSize: 17,
              color: Colors.deepPurple.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 15, right: 20),
          child: Text(
            widget.description!,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Future getFreeBottomSheetPackage() {
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
                              benafits: widget.benefits!,
                              days: widget.days,
                              newPrize: widget.prize,
                              oldPrize: widget.cutPrize);
                        }));
                      },
                      child: SubscribePackageSection(
                          id: widget.id,
                          benefites: widget.benefits!,
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
