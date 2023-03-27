import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:palana_neurosync/Screens/AudioPlayer/audioPlayerScreen.dart';
import 'package:palana_neurosync/Vars/Vars.dart';

class MusicPlayerBottomSheet extends StatefulWidget {
  final String musicUrl;

  MusicPlayerBottomSheet({required this.musicUrl});

  @override
  _MusicPlayerBottomSheetState createState() => _MusicPlayerBottomSheetState();
}

class _MusicPlayerBottomSheetState extends State<MusicPlayerBottomSheet> {
  late AudioPlayer bottomAudioPlayer;
  bool isPlaying = false;
  Duration position = Duration();
  Duration duration = Duration();
  Duration pDuration = Duration();
  Duration pPosition = Duration();

  @override
  void initState() {
    super.initState();
    bottomAudioPlayer = AudioPlayer();
    bottomAudioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        this.duration = duration;
        pDuration = duration;
        playMusic();
      });
    });
    bottomAudioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        this.position = position;
        pPosition = position;
      });
    });
    bottomAudioPlayer.setSourceUrl(widget.musicUrl);
  }

  void playMusic() {
    bottomAudioPlayer.play(UrlSource(widget.musicUrl));
    setState(() {
      isPlaying = true;
    });
  }

  void pauseMusic() {
    bottomAudioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    bottomAudioPlayer.release();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MusicPlayerScreen(
            audioPlayer: bottomAudioPlayer,
            duration: pDuration,
            isPlaying: isPlaying,
            musicUrl: widget.musicUrl,
            position: pPosition,
          );
        }));
      },
      child: Container(
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              color: bColor,
              onPressed: isPlaying ? pauseMusic : playMusic,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Slider(
                thumbColor: Colors.pink,
                value: position.inSeconds.toDouble(),
                min: 0.0,
                max: duration.inSeconds.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    bottomAudioPlayer.seek(Duration(seconds: value.toInt()));
                  });
                },
              ),
            ),
            Text(
              "${position.inMinutes}:${position.inSeconds.remainder(60).toString().padLeft(2, '0')}/${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
              style: TextStyle(color: bColor),
            ),
          ],
        ),
      ),
    );
  }
}
