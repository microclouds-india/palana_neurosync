import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/ui/homeDetail/controller/home_details_controller.dart';

class PlayAudioPage extends StatelessWidget {
  // String? songUrl;
  // PlayAudioPage({required this.songUrl});
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
                  min: 0,
                  max: 00,
                  value: 00,
                  inactiveColor: Colors.grey.withOpacity(0.5),
                  activeColor: Colors.white,
                  thumbColor: Colors.red,
                  onChanged: (value) async {
                    // final position = Duration(seconds: value.toInt());
                    // await controller.audioPlayer.value.seek(position);
                    // await controller.audioPlayer.value.resume();
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
                        '0',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        ('0').toString(),
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
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () async {
                      // if (controller.isPlaying.value) {
                      //   await controller.audioPlayer.value.pause();
                      // } else {
                      //   await controller.audioPlayer.value.resume();
                      // }
                    },
                    icon: Icon(
                        size: 30,
                        Icons.play_arrow,
                        color: Colors.transparent.withOpacity(0.5)),
                    iconSize: 50,
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
