import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:video_360/video_360.dart';

// ignore: must_be_immutable
class VideoPlayer extends StatefulWidget {
  String? videoUrl;
  VideoPlayer({required this.videoUrl});
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  Video360Controller? _video360controller;

  String durationText = '';
  String totalText = '';
  
  @override
  void initState() {
    super.initState();
    _onVideo360ViewCreated(_video360controller);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
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
            // Column(
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         MaterialButton(
            //           onPressed: () {
            //             controller?.play();
            //           },
            //           color: Colors.grey[100],
            //           child: Text('Play'),
            //         ),
            //         MaterialButton(
            //           onPressed: () {
            //             controller?.stop();
            //           },
            //           color: Colors.grey[100],
            //           child: Text('Stop'),
            //         ),
            //         MaterialButton(
            //           onPressed: () {
            //             controller?.reset();
            //           },
            //           color: Colors.grey[100],
            //           child: Text('Reset'),
            //         ),
            //         MaterialButton(
            //           onPressed: () {
            //             controller?.jumpTo(80000);
            //           },
            //           color: Colors.grey[100],
            //           child: Text('1:20'),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         MaterialButton(
            //           onPressed: () {
            //             controller?.seekTo(-2000);
            //           },
            //           color: Colors.grey[100],
            //           child: Text('<<'),
            //         ),
            //         MaterialButton(
            //           onPressed: () {
            //             controller?.seekTo(2000);
            //           },
            //           color: Colors.grey[100],
            //           child: Text('>>'),
            //         ),
            //         Flexible(
            //           child: MaterialButton(
            //             onPressed: () {},
            //             color: Colors.grey[100],
            //             child: Text(durationText + ' / ' + totalText),
            //           ),
            //         ),
            //       ],
            //     )
            //   ],
            // )
          ],
        ),
      ),
      onWillPop: () async {
        setState(() {
          _video360controller!.stop();
          Navigator.of(context).pop();
        });
        return true;
      },
    );
  }

  _onVideo360ViewCreated(Video360Controller? _video360controller) {
    this._video360controller = _video360controller;
  }
}
