import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/benifitsSection.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/packageSection.dart';
import '../../../Screens/Video Player/video_player.dart';
import 'myWavePackage.dart';

// GetView<HomeDetailsController>
class MyWaveDetail extends StatefulWidget {
  String id;
  String img;

  String tittle;
  String description;
  String videoLink;
  String audioUrl;
  String benefits;
  String packageName;
  String packageDiscription;
  String days;
  String prize;
  String cutPrize;
  MyWaveDetail(
      {required this.tittle,
      required this.img,
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
  State<MyWaveDetail> createState() => _MyWaveDetailState();
}

AudioPlayer _audioPlayer = AudioPlayer();
Duration _duration = Duration.zero;
Duration _position = Duration.zero;
bool playing = false;
double _currentSliderValue = 20;

class _MyWaveDetailState extends State<MyWaveDetail> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            headerSection(),
            textDescriptionSection(),
            BenifitsSection(benefits: widget.benefits),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return MyWavePackage(
                    packageName: widget.packageName,
                    id: widget.id,
                    img: widget.img,
                    benefits: widget.benefits,
                    audioUrl: widget.audioUrl,
                    packageDiscription: widget.packageDiscription,
                    days: widget.days,
                    prize: widget.prize,
                    cutPrize: widget.cutPrize);
              },
            )
          ],
        ),
      ),
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
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return VideoPlayer(videoUrl: widget.videoLink);
                        }));
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
            widget.tittle,
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
            widget.description,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
