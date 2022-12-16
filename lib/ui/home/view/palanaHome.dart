import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/ui/home/controller/palana_home_controller.dart';
import 'package:palana_neurosync/ui/home/widgets/giftWaveImageWidget.dart';

class PalanaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PalanaHomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Image.asset(AssetImages().logo,
                fit: BoxFit.contain, width: 120, height: 50),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.pink.shade600,
                      Colors.deepPurple.shade800,
                    ]),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                headingSection(Strings().giftWavesHeading),
                GiftWaveImageWidget(count: 1),
                headingSection(Strings().moreWavesHeading),
                GiftWaveImageWidget(count: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  headingSection(String headingText) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 10.0),
        child: Text(
          headingText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
