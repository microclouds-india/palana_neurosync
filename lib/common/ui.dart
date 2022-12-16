import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ui {

  static GetSnackBar SuccessSnackBar({String title = 'Success', required String message, required IconData iconData}) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.headline6?.merge(TextStyle(color: Colors.white))),
      messageText: Text(message, style: Get.textTheme.caption?.merge(TextStyle(color: Colors.white))),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.deepPurple.shade800,
      icon: Icon(iconData, size: 32, color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

}