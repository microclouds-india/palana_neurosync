import 'package:flutter/material.dart';

Widget loginButton(BuildContext context, Color color, String txt) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    child: Center(
      child: Text(
        txt,
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
