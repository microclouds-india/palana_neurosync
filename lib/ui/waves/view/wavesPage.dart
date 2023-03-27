import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:palana_neurosync/common/strings.dart';

import 'package:palana_neurosync/ui/waves/model/myvaweModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../homeDetail/view/courseDetailsPage.dart';
import '../model/wavelistmodel.dart';
import '../widgets/waveCard.dart';

class WavesPage extends StatefulWidget {
  @override
  State<WavesPage> createState() => _WavesPageState();
}

class _WavesPageState extends State<WavesPage> {
  bool myWaveLoad = false;
  MywaveModel _mywave = MywaveModel();
  // WaveList _waveList = WaveList();
  Map<String, dynamic>? _imgThumbnail;

// getMyWaves(String cid) async {
//   var cUrl = Uri.parse('https://cashbes.com/palana/apis/course_view');
//   var cresponse = await http.post(cUrl, body: {'id': cid});
//   if (cresponse.statusCode == 200) {
//     var cjson = jsonDecode(cresponse.body);
//     print(cresponse.body);
//     _waveList = WaveList.fromJson(cjson);
//     _imgThumbnail = cjson;
   
//   }
// }

getMyWaveData() async {
  final prif = await SharedPreferences.getInstance();
  print(prif.get('Token'));
  var url = Uri.parse('https://cashbes.com/palana/apis/my_course_packges');
  var response = await http.post(url, body: {'token': prif.get('Token')});
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    _mywave = MywaveModel.fromJson(json);
     setState(() {
      myWaveLoad = true;
    });
  }
}

  @override
  void initState() {
    super.initState();
    getMyWaveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            Strings().waves,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        body: myWaveLoad
           ? ListView.builder(
                    itemCount: _mywave.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return CourseDetailsScreen(
                            
                                  img:
                                     'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg',
                                
                                  id: _mywave.data![index].id!,
                                     );
                            }));
                          },
                          child: waveCard(
                              context: context,
                              imgurl: 'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg',
                              description: _mywave.data![index].courseName??'',
                              tittle:_mywave.data![index].courseName ?? ""));
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )
           
              );
  }
}
