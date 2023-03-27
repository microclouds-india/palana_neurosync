import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Api newtwork/Model/Notifications Model/notificationsModel.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

GetNotify _getNotify = GetNotify();
bool notifyBool = false;

class _NotificationPageState extends State<NotificationPage> {
  // getNotifications() async {
  //   var url = Uri.parse('https://cashbes.com/palana/apis/medicines');
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       var json = jsonDecode(response.body);
  //       _getNotify = GetNotify.fromJson(json);
  //       notifyBool = true;
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getNotifications();
  }

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
