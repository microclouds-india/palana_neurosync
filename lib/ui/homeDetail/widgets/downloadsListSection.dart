import 'package:flutter/material.dart';
import 'package:palana_neurosync/common/assetImages.dart';

class DownloadsListSection extends StatelessWidget {
  const DownloadsListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(bottom: 10),
      itemCount: 13,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {

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
                        child: Icon(Icons.delete, color: Colors.deepPurple.shade800,),
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
      },
    );
  }
}
