import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/ui/notifications/controller/notification_controller.dart';

class NotificationPage extends GetView<NotificationController> {
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
      body: Center(
        child: Text(Strings().notification),
      ),
    );
  }
}
