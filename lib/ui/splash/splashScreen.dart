import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(AssetImages().splashBackground,
                  fit: BoxFit.cover),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 150.0, left: 20.0, right: 20.0),
              child: Text(
                Strings().goodMorning,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: Text(
                  Strings().quote,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Center(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50.0, right: 30.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.deepPurple.shade800,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.HOME);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
