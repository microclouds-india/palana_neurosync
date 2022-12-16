import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/routes/app_routes.dart';

class SubscribePackageSection extends StatelessWidget {
  SubscribePackageSection(
      {required String title,
      required String description,
      required String days,
      required String newAmount,
      required String oldAmount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PACKAGEDETAILSPAGE);
      },
      child: Container(
        margin: EdgeInsets.only(left: 15.0, right: 15.0),
        padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.pink.shade600,
              Colors.deepPurple.shade800,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: 1,
                  activeColor: Colors.yellow.shade800,
                  onChanged: (value) {},
                ),
                textData("Vikas", 15, TextOverflow.visible, FontWeight.bold),
              ],
            ),
            textData("Title description", 10, TextOverflow.ellipsis,
                FontWeight.normal),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textData("180 Days", 15, TextOverflow.visible, FontWeight.bold),
                textData("2999.00", 15, TextOverflow.visible, FontWeight.bold),
              ],
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "1999.00",
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textData(String titleText, double size, TextOverflow textOverflow,
      FontWeight fontweight) {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          titleText,
          overflow: textOverflow,
          softWrap: true,
          style: TextStyle(
            color: Colors.white,
            fontSize: size,
            fontWeight: fontweight,
          ),
        ),
      ),
    );
  }
}
