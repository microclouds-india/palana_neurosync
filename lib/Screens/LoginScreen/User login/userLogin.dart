import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Api newtwork/Model/otpTokenMode.dart';
import '../../../Api newtwork/Url.dart';
import '../../../Vars/Vars.dart';
import '../../Widget/Login Button/login_button.dart';
import '../../Widget/Snackbar/snack_bar.dart';
import '../../Widget/Text Row/text_row.dart';
import 'const.dart';
import 'package:http/http.dart' as http;

class UserLogin extends StatefulWidget {
  UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  String? responseData;
  Timer? _timer;
  int rTime = 30;
  bool rgisterCount = true;
  void rOtPstartTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (rTime == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            rgisterCount = false;
            rTime--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Hello....',
                  style: TextStyle(
                      color: bColor, fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            textRow(
                fontWeight: FontWeight.w300,
                sizd: 20,
                txt: 'Enter your name & email'),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: signUpNameController,
                keyboardType: TextInputType.name,
                cursorColor: bColor,
                decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: signUpEmailController,
                cursorColor: bColor,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: signUpNumberController,
                cursorColor: bColor,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Mobile number',
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '00 : ${rTime.toString()}',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                TextButton(
                    onPressed: () async {
                      if (signUpNumberController.text.length == 10) {
                        rOtPstartTimer();
                        Uri otpUrl = Uri.parse(loginOtp);
                        var response = await http.post(otpUrl,
                            body: {'phone': signUpNumberController.text});
                        responseData = response.body;
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(invalidSnackbar);
                      }
                    },
                    child: Text(
                      "Send OTP",
                      style: TextStyle(
                          color: bColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 20),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                cursorColor: bColor,
                controller: signUpOTPController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'OTP',
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            GestureDetector(
                onTap: () async {
                  if (signUpNameController.text == '' &&
                      signUpEmailController.text == '' &&
                      signUpNumberController.text == '' &&
                      signUpNumberController.text == '' &&
                      signUpOTPController.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(snackBarNotData);
                  }

                  if (signUpNumberController.text.length == 10 &&
                      responseData!.contains(signUpOTPController.text)) {
                    var exResponse = http.post(Uri.parse(existuser_otp), body: {
                      'phone': signUpNumberController.text,
                      'otp': signUpOTPController.text,
                    });
                    OTPtokenModel otPtokenModel = OTPtokenModel();
                    final prif = await SharedPreferences.getInstance();
                    await prif.remove('Token');
                    await prif.setString('Token', otPtokenModel.token!);
                    await prif.setBool('S-LOGIN', true);
                    var registerResponse =
                        await http.post(Uri.parse(signUpUrl), body: {
                      'phone': signUpNumberController.text,
                      'name': signUpNameController.text,
                      'otp': signUpOTPController.text,
                      'email': signUpEmailController.text
                    });
                    print(registerResponse.body);
                    await prif.setString('UName',signUpNameController.text);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(LoginSuccesSully);
                    Navigator.of(context).pushReplacementNamed('/home');
                  }
                },
                child: loginButton(context, bColor, 'Continue')),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
