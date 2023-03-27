import 'dart:async';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/ui/downloads/view/downloadsPage.dart';
import 'package:palana_neurosync/ui/splash/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ConnectionNotifierToggler(
          onConnectionStatusChanged: (connected) {
            /// that means it is still in the initialization phase.
            print(connected);
            if (connected == false || connected == null) {
            } else {
              Timer(Duration(seconds: 3), () async {
                final prif = await SharedPreferences.getInstance();
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return SplashScreen(name: prif.getString('UName')??' ',);
                }));
              });
            }
          },
          connected: Stack(
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
                      child: Text(
                        Strings().caring_quote,
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
          disconnected: Stack(
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
                      child: Text(
                        Strings().caring_quote,
                        style: TextStyle(
                          color: Colors.deepPurple.shade100,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Retry",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return DownloadsPage();
                          }));
                        },
                        child: Text(
                          "Go Offline",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
