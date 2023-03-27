import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/Vars/Vars.dart';
import 'package:palana_neurosync/common/assetImages.dart';

// ignore: must_be_immutable
class MusicPlayerScreen extends StatefulWidget {
  Duration duration;
  Duration position;
  AudioPlayer audioPlayer;
  bool isPlaying;

  String musicUrl;
  MusicPlayerScreen({
    required this.duration,
    required this.position,
    required this.audioPlayer,
    required this.isPlaying,
    required this.musicUrl,
  });
  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  pauseMusic() {
    widget.audioPlayer.pause();
    setState(() {
      widget.isPlaying = false;
    });
  }

  playMusic() {
    widget.audioPlayer.play(UrlSource(widget.musicUrl));
    setState(() {
      widget.isPlaying = true;
    });
  }

  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer = widget.audioPlayer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              child: Image.asset(AssetImages().bg_image, fit: BoxFit.cover),
            ),
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
                  max: widget.duration.inSeconds.toDouble(),
                  value: widget.position.inSeconds.toDouble(),
                  inactiveColor: Colors.grey.withOpacity(0.5),
                  activeColor: Colors.white,
                  thumbColor: Colors.red,
                  onChanged: (value) async {
                    setState(() {
                      _audioPlayer.seek(Duration(seconds: value.toInt()));
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
                        '${widget.position.inMinutes}:${widget.position.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        ('${widget.duration.inMinutes}:${widget.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}')
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
                      widget.isPlaying ? pauseMusic() : playMusic();
                    },
                    icon: Icon(
                      widget.isPlaying ? Icons.pause : Icons.play_arrow,
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
