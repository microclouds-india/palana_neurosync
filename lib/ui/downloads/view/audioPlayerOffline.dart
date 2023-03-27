import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/Vars/Vars.dart';
import 'package:palana_neurosync/common/assetImages.dart';

// ignore: must_be_immutable
class OfflineMusicPlayer extends StatefulWidget {
  AudioPlayer audioPlayer;
  String img;

  String musicUrl;
  OfflineMusicPlayer({
    required this.audioPlayer,
    required this.img,
    required this.musicUrl,
  });
  @override
  State<OfflineMusicPlayer> createState() => _OfflineMusicPlayerState();
}

class _OfflineMusicPlayerState extends State<OfflineMusicPlayer> {
  late AudioPlayer _audioPlayer;
  bool? isPlayingOffline;
  Duration position = Duration();
  Duration duration = Duration();
  Duration pDuration = Duration();
  Duration pPosition = Duration();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        this.duration = duration;
        pDuration = duration;
      });
    });
    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        this.position = position;
        pPosition = position;
      });
    });
    _audioPlayer.setSourceUrl(widget.musicUrl);
    playMusic();
  }

  void playMusic() {
    _audioPlayer.play(UrlSource(widget.musicUrl));
    setState(() {
      isPlayingOffline = true;
    });
  }

  void pauseMusic() {
    _audioPlayer.pause();
    setState(() {
      isPlayingOffline = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.file(
                  File(widget.img),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.pink.shade600.withOpacity(0.4),
                    Colors.deepPurple.shade800.withOpacity(0.4),
                  ],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                )),
              ),
            ],
          ),
          SafeArea(
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Slider(
                  min: 0.0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  inactiveColor: Colors.grey.withOpacity(0.5),
                  activeColor: Colors.white,
                  thumbColor: Colors.red,
                  onChanged: (value) async {
                    setState(() {
                      widget.audioPlayer.seek(Duration(seconds: value.toInt()));
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${position.inMinutes}:${position.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        ('${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}')
                            .toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () async {
                      isPlayingOffline! ? pauseMusic() : playMusic();
                    },
                    icon: Icon(
                      isPlayingOffline! ? Icons.pause : Icons.play_arrow,
                      color: bColor,
                    ),
                    iconSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
