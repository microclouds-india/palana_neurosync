import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/ui/notifications/controller/notification_controller.dart';
import 'package:palana_neurosync/ui/waves/controller/waves_controller.dart';

class WavesPage extends GetView<WavesController> {
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
      body: Center(
        child: Text(Strings().waves),
      ),
    );
  }
}
