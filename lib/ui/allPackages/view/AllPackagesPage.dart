import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/ui/allPackages/widgets/allPackagesSection.dart';

class AllPackagesPge extends StatelessWidget {
  const AllPackagesPge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.black),
          onTap: () {
            Get.back();
          },
        ),
        title: Text(
          Strings().all_packs,
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
      body: Column(
        children: [
          Expanded(child: AllPackagesSection()),
        ],
      ),
    );
  }
}
