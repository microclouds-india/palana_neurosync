import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/routes/app_routes.dart';
import 'package:palana_neurosync/ui/homeDetail/controller/home_details_controller.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/benifitsSection.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/packageSection.dart';
import 'package:palana_neurosync/ui/profile/controller/profileController.dart';

class HomeDetailsPage extends GetView<HomeDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            headerSection(),
            textDescriptionSection(),
            const BenifitsSection(),
            const PackageSection(),
          ],
        ),
      ),
    );
  }

  Widget headerSection() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.pink.shade600,
              Colors.deepPurple.shade800,
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
                        Get.back();
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
                    getBottomSheetMusic();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Icon(Icons.play_circle,size: 45,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget textDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Text(
            "Title",
            style: TextStyle(
              fontSize: 17,
              color: Colors.deepPurple.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 15, right: 20),
          child: const Text(
            "Description",
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Future getBottomSheetMusic(){
    return Get.bottomSheet(
      barrierColor: Colors.transparent,
      isDismissible: true,
      StatefulBuilder(
        builder: (context, setState) {
          return Wrap(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.PLAYAUDIOPAGE);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          margin: EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.deepPurple.shade800,
                            child: IconButton(
                              onPressed: () async {
                                if (controller.isPlaying.value) {
                                  await controller.audioPlayer.value.pause();
                                } else {
                                  await controller.audioPlayer.value.resume();
                                }
                              },
                              icon: Obx(
                                    () => Icon(
                                    size: 20,
                                    controller.isPlaying.value
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white),
                              ),
                              iconSize: 20,
                            ),
                          ),
                        ),
                        Obx(() => Text(
                            controller.position.toString(),
                            style: TextStyle(color: Colors.deepPurple.shade800),
                          ),
                        ),
                        Obx(() => Slider(
                          min: 0,
                          max: controller.duration.value.inSeconds.toDouble(),
                          value: controller.position.value.inSeconds.toDouble(),
                          inactiveColor: Colors.grey.withOpacity(0.5),
                          activeColor: Colors.deepPurple.shade800,
                          thumbColor: Colors.red,
                          onChanged: (value) async {
                            final position = Duration(seconds: value.toInt());
                            await controller.audioPlayer.value.seek(position);
                            await controller.audioPlayer.value.resume();
                          },
                        ),
                        ),
                        Obx(() => Text(
                            (controller.duration.value - controller.position.value).toString(),
                            style: TextStyle(color: Colors.deepPurple.shade800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
