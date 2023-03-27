import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/Screens/Reminder/reminderScreenUi.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/ui/home/controller/palana_home_controller.dart';
import 'package:palana_neurosync/ui/home/widgets/giftWaveImageWidget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Api newtwork/Model/Courses View Model/coursers_view_model.dart';
import '../../../Api newtwork/Model/More waves model/more_waves_model.dart';
import '../../../Api newtwork/Url.dart';
import '../Model/myWaveHomeModel.dart';
import '../widgets/giftWaveFree.dart';

class PalanaHome extends StatefulWidget {
  @override
  State<PalanaHome> createState() => _PalanaHomeState();
}

class _PalanaHomeState extends State<PalanaHome> {
  MoreWavesModel _moreWavesModel = MoreWavesModel();
  //new
  // FilesData filesData = FilesData();
  //new
  bool vaWesScreenLoading = false;
  Map<String, dynamic>? imgThumbnail;
  getWavesData() async {
    var url = Uri.parse(moreWavesApi);
    var rsponse = await http.get(url);
    if (rsponse.statusCode == 200) {
      var json = jsonDecode(rsponse.body);
      print(rsponse.body);
      _moreWavesModel = MoreWavesModel.fromJson(json);
      // filesData = FilesData.fromJson(json);
      imgThumbnail = json;
      setState(() {
        vaWesScreenLoading = true;
      });
    }
  }

  // getCourseData() async {
  //   final prif = await SharedPreferences.getInstance();
  //   var url = Uri.parse('https://cashbes.com/palana/apis/courses');
  //   var responde = await http.get(url);
  //   if (responde.statusCode == 200) {
  //     var json = jsonDecode(responde.body);
  //     _cousersViewModel = CousersViewModel.fromJson(json);
  //     _cousersViewModel.data!.forEach((element) {
  //       print(element.id);
  //     });

  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWavesData();
    // getCourseData();
  }

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
            body: vaWesScreenLoading
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        headingSection(Strings().giftWavesHeading),
                        CourseWaveFreeWidget(
                          // filesData: filesData,
                          count: 1,
                        ),
                        headingSection(Strings().moreWavesHeading),
                        GiftWaveImageWidget(
                            filesData: imgThumbnail,
                            count: 10,
                            moreWavesModel: _moreWavesModel,
                            imgThumbnail: imgThumbnail!),
                        // headingSection(Strings().Cource),
                        // CourseWaveImageWidget(
                        //     count: 10, cousersViewModel: _cousersViewModel)
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ));
      },
    );
  }

  headingSection(String headingText) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
            left: 30.0, right: 30.0, top: 20.0, bottom: 10.0),
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
