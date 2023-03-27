import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:palana_neurosync/Database/Init%20Database/initDatabase.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/ui/downloads/view/audioPlayerOffline.dart';

import '../../../Screens/Widget/Snackbar/snack_bar.dart';

class DownloadsListSection extends StatefulWidget {
  const DownloadsListSection({Key? key}) : super(key: key);

  @override
  State<DownloadsListSection> createState() => DownloadsListSectionState();
}

List<Map<String, Object?>>? dbget;

class DownloadsListSectionState extends State<DownloadsListSection> {
  List<Map<String, dynamic>>? data;
  bool load = false;
  bool offlinePlay = false;
  AudioPlayer _player = AudioPlayer();
  getLocalData() async {
    dbget = await ldb.rawQuery('SELECT * FROM Offline');
    setState(() {
      data = dbget;
      load = true;
    });
  }

  offPlay(String path) {
    _player.play(UrlSource(path));
    setState(() {
      offlinePlay = true;
    });
  }

  offPause() {
    _player.pause();
    setState(() {
      offlinePlay = false;
    });
  }

  deleteData(int id) async {
    setState(() {
      ldb.rawDelete('DELETE FROM Offline WHERE id = ?', [id]);
    });
    setState(() {
      getLocalData();
    });
  }

  Future<void> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      await file.delete();
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(bottom: 10),
            itemCount: data!.length,
            itemBuilder: (_, index) {
              print(data![index]);
              return GestureDetector(
                onTap: () {},
                child: Card(
                  margin:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.file(
                              File(
                                data![index]['image'],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data![index]['tittle'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              data![index]['description'],
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    deleteFile(data![index]['audiopath']);
                                    deleteData(data![index]['id']);
                                    deleteFile(data![index]['image']);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.deepPurple.shade800,
                                  ),
                                )),
                            const SizedBox(width: 10),
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return OfflineMusicPlayer(
                                          img: data![index]['image'],
                                          audioPlayer: _player,
                                          musicUrl: data![index]['audiopath']);
                                    }));
                                  },
                                  icon: Icon(
                                    offlinePlay
                                        ? Icons.pause
                                        : Icons.play_circle_outline,
                                    color: Colors.deepPurple.shade800,
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
