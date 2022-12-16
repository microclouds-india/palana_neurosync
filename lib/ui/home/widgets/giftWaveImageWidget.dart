import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/routes/app_routes.dart';

class GiftWaveImageWidget extends StatelessWidget {

  int count;
  GiftWaveImageWidget({required this.count});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(Routes.HOMEDETAILSPAGE);
          },
          child: Container(
            width: double.infinity,
            height: 150,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.grey, Colors.grey.withOpacity(0.1)],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                  stops: [0.1, 0.9],
                  tileMode: TileMode.clamp),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                itemDetailsSection("Title",13.0),
                itemDetailsSection("Description",11.0),
              ],
            ),
          ),
        );
      },
    );
  }

  itemDetailsSection(String itemDetailsText, double fontSize) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 10.0, bottom: 5.0),
        child: Text(
          itemDetailsText,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
