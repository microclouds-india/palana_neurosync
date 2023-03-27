import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:palana_neurosync/ui/homeDetail/view/homeDetailsPage.dart';
import 'package:video_360/video_360.dart';

// ignore: must_be_immutable
class VideoPlayerAndAudio extends StatefulWidget {
  String? videoUrl;
  String AudioUrl;
  VideoPlayerAndAudio({required this.videoUrl, required this.AudioUrl});
  @override
  _VideoPlayerAndAudioState createState() => _VideoPlayerAndAudioState();
}

class _VideoPlayerAndAudioState extends State<VideoPlayerAndAudio> {
  Video360Controller? _video360controller;
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _showControls = true;
  bool? _isPlaying;
  void playMusic() {
    _audioPlayer.play(UrlSource(widget.AudioUrl));
    setState(() {
      _isPlaying = true;
    });
  }

  String durationText = '';
  String totalText = '';

  @override
  void initState() {
    super.initState();
    _onVideo360ViewCreated(_video360controller);
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  void pauseMusic() {
    _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<bool> _onWillPop() async {
    if (_isPlaying!) {
      pauseMusic();
      Navigator.of(context).pop();
      return false;
    } else {
      _video360controller!.dispose();
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Center(
                  child: Container(
                    width: width,
                    height: height,
                    child: Video360View(
                      onVideo360ViewCreated: _onVideo360ViewCreated,
                      url: widget.videoUrl,
                      onPlayInfo: (Video360PlayInfo info) {
                        setState(() {
                          durationText = info.duration.toString();
                          totalText = info.total.toString();
                        });
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showControls = !_showControls;
                    });
                  },
                  child: Visibility(
                    visible: _showControls,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                _video360controller?.play();
                                playMusic();
                              },
                              color: Colors.grey[100],
                              child: Text('Play'),
                            ),
                            MaterialButton(
                              onPressed: () {
                                _video360controller?.stop();
                                pauseMusic();
                              },
                              color: Colors.grey[100],
                              child: Text('Stop'),
                            ),
                            //     MaterialButton(
                            //       onPressed: () {
                            //         _video360controller?.reset();
                            //       },
                            //       color: Colors.grey[100],
                            //       child: Text('Reset'),
                            //     ),
                            //     MaterialButton(
                            //       onPressed: () {
                            //         _video360controller?.jumpTo(80000);
                            //       },
                            //       color: Colors.grey[100],
                            //       child: Text('1:20'),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     MaterialButton(
                            //       onPressed: () {
                            //         _video360controller?.seekTo(-2000);
                            //       },
                            //       color: Colors.grey[100],
                            //       child: Text('<<'),
                            //     ),
                            //     MaterialButton(
                            //       onPressed: () {
                            //         _video360controller?.seekTo(2000);
                            //       },
                            //       color: Colors.grey[100],
                            //       child: Text('>>'),
                            //     ),
                            //     Flexible(
                            //       child: MaterialButton(
                            //         onPressed: () {},
                            //         color: Colors.grey[100],
                            //         child: Text(durationText + ' / ' + totalText),
                            //       ),
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: _onWillPop);
  }

  _onVideo360ViewCreated(Video360Controller? _video360controller) {
    this._video360controller = _video360controller;
    playMusic();
  }
}
