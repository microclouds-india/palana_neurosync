import 'package:flutter/material.dart';
import 'package:palana_neurosync/ui/downloads/view/audioPlayerOffline.dart';
import 'package:palana_neurosync/ui/waves/view/alamyPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget waveCard({
  required String imgurl,
  required BuildContext context,
  required String tittle,
  required String description,
}) {
  return Card(
    margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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
                child: Image(
                  image: NetworkImage(imgurl),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tittle,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                description,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 13),
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
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AlarmSetScreen();
                      }));
                    },
                    icon: Icon(
                      Icons.alarm,
                      color: Colors.deepPurple.shade800,
                    ),
                  )),
              const SizedBox(width: 10),
              // Align(
              //     alignment: Alignment.centerRight,
              //     child: IconButton(
              //       onPressed: () async {
              //         // final prif = await SharedPreferences.getInstance();
              //         // print(prif.get('Token'));

              //       },
              //       icon: Icon(
              //         Icons.play_arrow,
              //         color: Colors.deepPurple.shade800,
              //       ),
              //     )),
              SizedBox(
                width: 5,
              )
            ],
          ),
        ),
      ],
    ),
  );
}
