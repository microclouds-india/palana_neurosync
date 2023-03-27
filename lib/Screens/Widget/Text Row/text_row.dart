import 'package:flutter/material.dart';

Widget textRow({required double sizd,required FontWeight fontWeight,required String txt}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        txt,
        style: TextStyle(
            color: Colors.black, fontSize: sizd, fontWeight: fontWeight),
      ),
    ],
  );
}
