import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/ui/homeDetail/model/courseDetailsModel.dart';
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
class CourseDetailsScreen extends StatefulWidget {
  String id;
  String img;
  CourseDetailsScreen({required this.id, required this.img});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

AudioPlayer _audioPlayer = AudioPlayer();
Duration _duration = Duration.zero;
Duration _position = Duration.zero;
bool playing = false;
bool? premiumUser = false;
List myCourseids = [];
double _currentSliderValue = 20;
MyCourse _myCourse = MyCourse();
bool _loading = false;
CourseViewModel _courseViewModel = CourseViewModel();

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  getMyCourse() async {
    final prif = await SharedPreferences.getInstance();
    var url = Uri.parse('https://cashbes.com/palana/apis/my_course_packges');
    var response = await http.post(url, body: {
      'token': prif.getString('Token'),
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      _myCourse = MyCourse.fromJson(json);
      print(response.body);
      if (_myCourse == null ||
          _myCourse.data == null ||
          _myCourse.data!.isEmpty) {
        premiumUser = false;
      } else {
        premiumUser =
            widget.id.contains(_myCourse.data![0].courseId as Pattern);
      }
      print('***************************************$premiumUser');
      getViewCourse();
    }
  }

  getViewCourse() async {
    var url = Uri.parse('https://cashbes.com/palana/apis/course_view');
    var response = await http.post(url, body: {'id': widget.id});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      _courseViewModel = CourseViewModel.fromJson(json);
      print(
          '%%%%%%%%%%%%%%%%%%%${_courseViewModel.data![0].files![0].fileUrl}');
      setState(() {
        _loading = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyCourse();
  }

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
        body: _loading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    headerSection(),
                    textDescriptionSection(),
                    BenifitsSection(
                        benefits: _courseViewModel.data![0].benefits ??
                            'No Benefits'),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _courseViewModel.data!.length,
                      itemBuilder: (context, index) {
                        return PackageSection(
                            videourl: _courseViewModel
                                .data![index].files![index].fileUrl
                                .toString(),
                            premiumUser: premiumUser!,
                            img: widget.img,
                            id: widget.id,
                            benefits: _courseViewModel.data![index].benefits ??
                                'No benefits',
                            audioUrl: _courseViewModel
                                .data![index].files![index + 1].fileUrl
                                .toString(),
                            packageName: _courseViewModel.data![index].title ??
                                'No TiTTle',
                            cutPrize:
                                _courseViewModel.data![index].cutPrice ?? '00',
                            days: _courseViewModel.data![index].days ?? '2',
                            packageDiscription:
                                _courseViewModel.data![index].description ??
                                    'No Description',
                            prize: _courseViewModel.data![index].price ?? '00');
                      },
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
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
                            return VideoPlayer(
                                videoUrl: _courseViewModel.data![0].videoUrl);
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
            _courseViewModel.data![0].title ?? 'No Tittle',
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
            _courseViewModel.data![0].description ?? 'No Description',
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
                    textData("Start listening ", 13.0, FontWeight.normal),
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
                              packageName: _courseViewModel.data![0].title ??
                                  'No Package Name',
                              description:
                                  _courseViewModel.data![0].description ??
                                      'No description',
                              benafits: _courseViewModel.data![0].benefits ??
                                  'No Benefits',
                              days: _courseViewModel.data![0].days ?? '2',
                              newPrize: _courseViewModel.data![0].price ?? '00',
                              oldPrize:
                                  _courseViewModel.data![0].cutPrice ?? '00');
                        }));
                      },
                      child: SubscribePackageSection(
                          tittle:
                              _courseViewModel.data![0].title ?? 'No Tittle',
                          id: widget.id,
                          packageName: _courseViewModel.data![0].title ??
                              'No Package Name',
                          description: _courseViewModel.data![0].description ??
                              'No description',
                          benefites: _courseViewModel.data![0].benefits ??
                              'No Benefits',
                          days: _courseViewModel.data![0].days ?? '2',
                          newAmount: _courseViewModel.data![0].price ?? '00',
                          oldAmount:
                              _courseViewModel.data![0].cutPrice ?? '00'),
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
