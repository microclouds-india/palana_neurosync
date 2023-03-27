import 'package:flutter/material.dart';
import '../../packageDetails/view/packageDetailsPage.dart';

class SubscribePackageSection extends StatelessWidget {
  String tittle;
  String id;
  String description;
  String days;
  String newAmount;
  String oldAmount;
  String packageName;
  String benefites;
  SubscribePackageSection(
      {required this.tittle,
      required this.id,
      required this.description,
      required this.days,
      required this.packageName,
      required this.benefites,
      required this.newAmount,
      required this.oldAmount,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return PackageDetailsPage(
              id: id,
              packageName: packageName,
              description: description,
              benafits: benefites,
              days: days,
              newPrize: newAmount,
              oldPrize: oldAmount);
        }));
      },
      child: Container(
        margin: EdgeInsets.only(left: 15.0, right: 15.0),
        padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Colors.pink.shade600, Colors.deepPurple.shade800],
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
                textData(
                    packageName, 15, TextOverflow.visible, FontWeight.bold),
              ],
            ),
            textData(description, 10, TextOverflow.ellipsis, FontWeight.normal),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textData(
                    '$days Days', 15, TextOverflow.visible, FontWeight.bold),
                textData(newAmount, 15, TextOverflow.visible, FontWeight.bold),
              ],
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  oldAmount,
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
