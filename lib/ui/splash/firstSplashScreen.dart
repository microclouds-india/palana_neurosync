import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/routes/app_routes.dart';

class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 3), () => Get.toNamed(Routes.SPLASHSCREEN));

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(AssetImages().bg_image, fit: BoxFit.cover),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 50, right: 50),
                    child: Image.asset(AssetImages().logo),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 50, right: 50),
                    child: Text(Strings().caring_quote,
                      style: TextStyle(
                        color: Colors.deepPurple.shade100,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
