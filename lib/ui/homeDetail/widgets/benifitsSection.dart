import 'package:flutter/material.dart';

class BenifitsSection extends StatelessWidget {
  const BenifitsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          headingWidget(),
          benefitsItemsWidget(),
        ],
      ),
    );
  }

  Widget headingWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 10.0),
      child: const Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          "Benefits",
          style: TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget benefitsItemsWidget() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(top: 0),
      itemCount: 3,
      itemBuilder: (_, index) {
        return Row(
          children: [
            Radio(
              value: 2,
              groupValue: 2,
              activeColor: Colors.deepPurple.shade800,
              onChanged: (value) {

              },
            ),
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Text("Improves concentration",
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
