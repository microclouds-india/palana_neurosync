import 'package:flutter/material.dart';

Widget signInBtn(BuildContext context,String logo,String txt) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: 20,
            width: 20,
            image: AssetImage('assets/img/$logo'),
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            txt,
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    ),
  );
}
