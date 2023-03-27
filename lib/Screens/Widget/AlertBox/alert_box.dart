import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:palana_neurosync/Screens/LoginScreen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Api newtwork/Url.dart';

Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Are you sure to logout?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Color(0xff23015b)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'CONTINUE',
              style: TextStyle(color: Color(0xff23015b)),
            ),
            onPressed: () async {
              final prif = await SharedPreferences.getInstance();
              var response = await http.post(Uri.parse(logOutApi), body: {
                'token': prif.getString('Token'),
              });
              if (response.body.contains('Logout Success')) {
                prif.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }), (route) => false);
              }
            },
          ),
        ],
      );
    },
  );
}
