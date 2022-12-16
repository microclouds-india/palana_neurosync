import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/common/blockButtonWidget.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/common/ui.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/subscribePackageSection.dart';
import 'package:palana_neurosync/ui/packageDetails/controller/packageDetailsController.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PackageDetailsPage extends GetView<PackageDetailsController> {

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
          Strings().package_details,
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
          SizedBox(height: 20),
          SubscribePackageSection(
              title: "Zayana",
              description: "Ease into sleep",
              days: "180 Days",
              newAmount: "3500.00",
              oldAmount: "2100.00"),
          headingWidget(),
          headingDetailsWidget(context),
          blockButtonWidget(),
        ],
      ),
    );
  }

  Widget headingWidget() {
    return Container(
      margin: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          "Benefits",
          style: TextStyle(
            fontSize: 17,
            color: Colors.deepPurple.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget headingDetailsWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      padding: const EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          textData("Vikas", 15, TextOverflow.visible, FontWeight.normal,
              Colors.black),
          textData("1 Vikas", 13, TextOverflow.visible, FontWeight.normal,
              Colors.grey),
          textData(
              "For empovering students.",
              15,
              TextOverflow.visible,
              FontWeight.normal,
              Colors.black),
        ],
      ),
    );
  }

  Widget textData(String titleText, double size, TextOverflow textOverflow,
      FontWeight fontweight, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15),
      padding: EdgeInsets.only(bottom: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          titleText,
          overflow: textOverflow,
          softWrap: true,
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: fontweight,
          ),
        ),
      ),
    );
  }

  Widget blockButtonWidget() {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade800,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: BlockButtonWidget(
            text: Text(Strings().subscribe.tr,
                textAlign: TextAlign.center,
                style: Get.textTheme.headline6?.merge(
                  TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            color: Colors.deepPurple.shade800,
            onPressed: () {
              controller.generate_ODID("username");
            },
          ).paddingOnly(right: 20, left: 20),
        ),
      ),
    );
  }
}
