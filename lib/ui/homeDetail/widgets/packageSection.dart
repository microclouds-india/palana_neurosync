import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/routes/app_routes.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/subscribePackageSection.dart';

class PackageSection extends StatelessWidget {
  const PackageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getBottomSheetPackage();
      },
      child: Card(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child:
                      Image.asset(AssetImages().quote_bg, fit: BoxFit.cover),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Title",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Description",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.download_for_offline_outlined, color: Colors.deepPurple.shade800,),
                  ),
                  const SizedBox(width: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.play_circle_outline, color: Colors.deepPurple.shade800,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getBottomSheetPackage(){
    return Get.bottomSheet(
      barrierColor: Colors.black.withOpacity(0.5),
      isDismissible: true,
      StatefulBuilder(
        builder: (context, setState) {
          return Wrap(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 40.0, left: 15.0, right: 15.0),
                padding: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    getIconData(Icons.close, Colors.red),
                    SizedBox(height: 20),
                    textData("Start listening vikas", 13.0, FontWeight.normal),
                    SizedBox(height: 20),
                    textData(Strings().subscribe_package, 17.0, FontWeight.bold),
                    SizedBox(height: 20),
                    SubscribePackageSection(
                        title: "Amrith",
                        description: "The womb melodies",
                        days: "270 Days",
                        newAmount: "5500.00",
                        oldAmount: "4500.00"),
                    SizedBox(height: 20),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          textData("View More", 10, FontWeight.bold),
                          SizedBox(width: 2),
                          getIconData(Icons.arrow_forward, Colors.black),
                        ],
                      ),
                      onTap: () {
                        Get.toNamed(Routes.ALLPACKAGESPAGE);
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget getIconData(IconData iconData, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Icon(iconData,
          color: color,
          size: 20,
        ),
      ),
    );
  }

  Widget textData(String text, double size, FontWeight fontWeight){
    return Text(text,
      style: TextStyle(
        fontSize: size,
        color: Colors.black,
        fontWeight: fontWeight,
      ),
    );
  }
}
