import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/ui/downloads/controller/downlodsController.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/downloadsListSection.dart';

class DownloadsPage extends GetView<DownloadsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          Strings().downloads,
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
      body: DownloadsListSection(),
    );
  }
}
