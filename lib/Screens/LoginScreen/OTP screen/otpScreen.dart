import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:palana_neurosync/Screens/Widget/Login%20Button/login_button.dart';
import 'package:palana_neurosync/Vars/Vars.dart';
import '../../../Api newtwork/Model/otpTokenMode.dart';
import '../../../Api newtwork/Url.dart';
import '../../Widget/Snackbar/snack_bar.dart';
import '../../Widget/Text Row/text_row.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  String number;
  OtpScreen({required this.number});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

// ignore: unused_element
Timer? _timer;
Timer? _otpTimer;
int _start = 30;
bool timerConttOn = true;
String? controllers;
String? reEnterOtp;

class _OtpScreenState extends State<OtpScreen> {
  void startTimer() {
    _start = 30;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            timerConttOn = false;
            _start--;
          });
        }
      },
    );
  }

  String? otpRespo;

  otpVerification(String number) async {
    Uri otpUrl = Uri.parse(loginOtp);
    var response = await http.post(otpUrl, body: {'phone': number});
    otpRespo = response.body;
  }

  @override
  void initState() {
    super.initState();
    otpVerification(widget.number);
    InitstartTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            textRow(
                sizd: 25,
                fontWeight: FontWeight.w500,
                txt: 'Verification Code'),
            SizedBox(
              height: 20,
            ),
            textRow(
                sizd: 15,
                fontWeight: FontWeight.w300,
                txt:
                    'Please type the Verification Cade\nSend to (91 ${widget.number})'),
            SizedBox(height: 15),
            Row(
              children: [
                OtpTextField(
                  cursorColor: bColor,
                  focusedBorderColor: Colors.grey,
                  numberOfFields: 4,
                  borderColor: Colors.grey,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },

                  onSubmit: (String verificationCode) {
                    controllers = verificationCode;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '00 : ${_start.toString()}',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                Visibility(
                    visible: timerConttOn,
                    child: TextButton(
                        onPressed: () async {
                          startTimer();
                          _otpTimer!.cancel();
                          Uri otpUrl = Uri.parse(loginOtp);
                          var response = await http
                              .post(otpUrl, body: {'phone': widget.number});
                          setState(() {
                            otpRespo = response.body;
                          });
                        },
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(
                              color: bColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 20),
                        )))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () async {
                  EasyLoading.show();
                  if (otpRespo!.contains(controllers!)) {
                    var response =
                        await http.post(Uri.parse(existuser_otp), body: {
                      'phone': widget.number,
                      'otp': controllers,
                    });
                    OTPtokenModel otPtokenModel = OTPtokenModel();
                    otPtokenModel =
                        OTPtokenModel.fromJson(jsonDecode(response.body));
                    final prif = await SharedPreferences.getInstance();
                    await prif.remove('Token');
                    await prif.setString('Token', otPtokenModel.token!);
                    await prif.setString('MobileNumber', widget.number);
                    prif.setBool('LOGIN SUCCESS FULLY', true);
                    EasyLoading.dismiss();
                    print(otPtokenModel.token!);
                    Navigator.of(context).pushReplacementNamed('/home');

                    ScaffoldMessenger.of(context)
                        .showSnackBar(LogiTnSuccesSully);
                  } else {
                    EasyLoading.dismiss();
                    ScaffoldMessenger.of(context).showSnackBar(invalidOtp);
                  }
                },
                child: loginButton(context, bColor, 'Continue')),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }

  void InitstartTimer() {
    const oneSec = const Duration(seconds: 1);
    _otpTimer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
