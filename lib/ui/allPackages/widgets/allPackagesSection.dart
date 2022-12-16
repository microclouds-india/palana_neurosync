import 'package:flutter/material.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/subscribePackageSection.dart';

class AllPackagesSection extends StatelessWidget {
  const AllPackagesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (_, index) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: SubscribePackageSection(
                  title: "vikas",
                  description: "good",
                  days: "210 Days",
                  newAmount: "2999.00",
                  oldAmount: "1999.00"),
            ),
            onTap: () {},
          );
        });
  }
}
