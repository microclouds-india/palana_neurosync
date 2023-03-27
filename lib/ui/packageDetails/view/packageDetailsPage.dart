import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palana_neurosync/Screens/Widget/Login%20Button/login_button.dart';
import 'package:palana_neurosync/Screens/Widget/Snackbar/snack_bar.dart';
import 'package:palana_neurosync/Vars/Vars.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/subscribePackageSection.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Api newtwork/Model/Schedule Notification Model/scheduleNotificationModel.dart';

GetSchedulNotify schedulNotify = GetSchedulNotify();

alaramOnReq(String tocken, String cid, BuildContext context) async {
  final prif = await SharedPreferences.getInstance();
  var url = Uri.parse('https://cashbes.com/palana/apis/course_setting');
  var response = await http.post(url,
      body: {'token': prif.getString('Token'), 'course_id': cid, 'alam': 'on'});
  if (response.statusCode == 200) {
    print('Alaram rq${response.statusCode}');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Alam Requisted!")));
    getSnotifications(cid);
  }
}

getSnotifications(String cid) async {
  var url = Uri.parse('https://cashbes.com/palana/apis/alams');
  var rsponse = await http.post(url, body: {
    'course_id': cid,
  });
  if (rsponse.statusCode == 200) {
    print('Get Notify Status Code ${rsponse.statusCode}');
    ScaffoldMessenger(child: SnackBar(content: Text("Alaram Success fully")));
    Map<String, dynamic> data = jsonDecode(rsponse.body);
    List<dynamic> notifications = data['data'];
    for (var notificationData in notifications) {
      int id = int.parse(notificationData['id']);
      String message = notificationData['message'];
      String alert_time = notificationData['alert_time'];
      NotificationContent content = NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: 'Alert',
        body: message,
        notificationLayout: NotificationLayout.Default,
      );
      // DateTime notificationTime = DateTime.parse('$date $time');
      List<String> parts = alert_time.split(':');
      int Chour = int.parse(parts[0]);
      int Cminute = int.parse(parts[1]);

      AwesomeNotifications().createNotification(
        content: content,
        schedule: NotificationCalendar(
          // day: notificationTime.day,
          // month: notificationTime.month,
          // year: notificationTime.year,
          hour: Chour,
          minute: Cminute,
          repeats: true,
        ),
      );
    }
  }
}

// GetView<PackageDetailsController>
class PackageDetailsPage extends StatefulWidget {
  String id;
  String packageName;
  String description;
  String days;
  String newPrize;
  String oldPrize;
  String benafits;
  PackageDetailsPage(
      {required this.packageName,
      required this.id,
      required this.description,
      required this.benafits,
      required this.days,
      required this.newPrize,
      required this.oldPrize});
  @override
  State<PackageDetailsPage> createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState extends State<PackageDetailsPage> {
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentDataSent(cId: widget.id, price: widget.newPrize, days: widget.days);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
  }
  void _openCheckout(
      {required String amount,
      required String mobilenumber,
      required String mailid}) {
    var options = {
      'key': 'rzp_test_wgEqxsqSWDRTWB',
      'amount': amount,
      'name': widget.packageName,
      'description': widget.description,
      'prefill': {'contact': mobilenumber, 'email': mailid},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }

  paymentDataSent(
      {required String cId,
      required String price,
      required String days}) async {
    final prif = await SharedPreferences.getInstance();
    var url = Uri.parse('https://cashbes.com/palana/apis/subscribe_package');
    var response = await http.post(url, body: {
      'token': prif.get('Token'),
      'course_id': cId,
      'price': price,
      'days': days,
    });

    if (response.statusCode == 200) {
      alaramOnReq(prif.getString('Token').toString(), cId, context);
      ScaffoldMessenger.of(context).showSnackBar(paymentSuccessFully);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(paymentFaild);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.black),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          Strings().package_details,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          SubscribePackageSection(
              id: widget.id,
              benefites: widget.benafits,
              packageName: widget.packageName,
              tittle: widget.packageName,
              description: widget.description,
              days: widget.days,
              newAmount: widget.newPrize,
              oldAmount: widget.oldPrize),
          headingWidget(),
          headingDetailsWidget(context),
          blockButtonWidget(),
        ],
      ),
    );
  }

  Widget headingWidget() {
    return Container(
      margin: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          "Benefits",
          style: TextStyle(
            fontSize: 17,
            color: Colors.deepPurple.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget headingDetailsWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      padding: const EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          textData(widget.packageName, 15, TextOverflow.visible,
              FontWeight.normal, Colors.black),
          textData(widget.description, 13, TextOverflow.visible,
              FontWeight.normal, Colors.grey),
          textData(widget.benafits, 15, TextOverflow.visible, FontWeight.normal,
              Colors.black),
        ],
      ),
    );
  }

  Widget textData(String titleText, double size, TextOverflow textOverflow,
      FontWeight fontweight, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15),
      padding: EdgeInsets.only(bottom: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          titleText,
          overflow: textOverflow,
          softWrap: true,
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: fontweight,
          ),
        ),
      ),
    );
  }

  Widget blockButtonWidget() {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade800,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          // child: BlockButtonWidget(
          //   text: Text(Strings().subscribe.tr,
          //       textAlign: TextAlign.center,
          //       style: Get.textTheme.headline6?.merge(
          //         TextStyle(
          //           color: Colors.white,
          //           fontSize: 15,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       )),
          //   color: Colors.deepPurple.shade800,
          //   onPressed: () {
          //     Razorpay razorpay = new Razorpay();
          //     var options = {
          //       'key': 'rzp_test_wgEqxsqSWDRTWB',
          //       'amount': int.parse(widget.newPrize),
          //       'name': widget.packageName,
          //       'description': widget.description,
          //       'prefill': {
          //         'contact': '9999999999',
          //         'email': 'test@razorpay.com'
          //       },
          //       'external': {
          //         'wallets': ['paytm']
          //       }
          //     };

          //     try {
          //       razorpay.open(options);
          //     } catch (e) {
          //       debugPrint('Error: ${e.toString()}');
          //     }
          //     void paymentSuccess(PaymentSuccessResponse response) {
          //       // Do something when payment succeeds
          //     }

          //     void paymentError(PaymentFailureResponse response) {
          //       // Do something when payment fails
          //     }

          //     void externalWallet(ExternalWalletResponse response) {
          //       // Do something when an external wallet is selected
          //     }

          //     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccess);
          //     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentError);
          //     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
          //   },
          // ).paddingOnly(right: 20, left: 20),
          child: GestureDetector(
              onTap: () async {
                final prif = await SharedPreferences.getInstance();
                // _openCheckout(
                //     amount: '10',
                //     mailid: prif.getString('MailId').toString(),
                //     mobilenumber: prif.getString('MobileNumber').toString());
                
                paymentDataSent(
                    cId: widget.id, price: widget.newPrize, days: widget.days);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Course purchased")));
                alaramOnReq(
                  await  prif.getString('Token').toString(), widget.id, context);
              },
              child: loginButton(context, bColor, 'Subscribe')),
        ),
      ),
    );
  }
}
