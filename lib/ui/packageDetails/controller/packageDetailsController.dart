import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/common/ui.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PackageDetailsController extends GetxController {

  late Razorpay _razorpay;

  @override
  void onInit() {
    // TODO: implement onInit
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.onInit();
  }

  @override
  void dispose() {
    _razorpay.clear();
  }


  Future<void> generate_ODID(String username) async {
    var orderOptions = {
      'amount': int.parse("10") * 100,  // amount in the smallest currency unit
      'currency': "INR",
      // 'receipt': "order_rcptid_11"
    };
    final client = HttpClient();
    final request = await client.postUrl(Uri.parse('https://api.razorpay.com/v1/orders'));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${'rzp_test_wgEqxsqSWDRTWB'}:${'FvH3IYzvoEAsKNDGhhUl2603'}'));
    request.headers.set(HttpHeaders.authorizationHeader, basicAuth);
    request.add(utf8.encode(json.encode(orderOptions)));
    final response = await request.close();
    response.transform(utf8.decoder).listen((contents) {
      print('ORDERID'+contents);
      String orderId = contents.split(',')[0].split(":")[1];
      orderId = orderId.substring(1, orderId.length - 1);
      Map<String, dynamic> checkoutOptions = {
        'key': 'rzp_test_wgEqxsqSWDRTWB',
        'amount': int.parse("10") * 100,
        'name': username,
        'order_id': orderId,
        'description': "Tourism",
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'prefill': {'contact': '${9999999999}', 'email': '${"username@gmail.com"}'},
        'external': {
          'wallets': ['paytm']
        }
      };
      try {
        _razorpay.open(checkoutOptions);
      } catch (e) {
        print(e.toString());
      }
    });

    // Razorpay razorpay = Razorpay();
    // var options = {
    //   'key': 'rzp_test_wgEqxsqSWDRTWB',
    //   'amount': 1000,
    //   'name': 'Acme Corp.',
    //   'description': 'Fine T-Shirt',
    //   'retry': {'enabled': true, 'max_count': 1},
    //   'send_sms_hash': true,
    //   'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    //   'external': {
    //     'wallets': ['paytm']
    //   }

    // };
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {

    // var now = new DateTime.now();
    // var formatter = new DateFormat('dd-MM-yyyy');
    // String formattedDate = formatter.format(now);

    // print("success response: "+response.orderId+"\n"+response.paymentId+"\n"+response.signature+"\n");


    Get.showSnackbar(Ui.SuccessSnackBar(message: "Payment Success".tr, title: "Success", iconData: Icons.check_circle_outline));

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.showSnackbar(Ui.SuccessSnackBar(message: response.code.toString() + " - " + response.message.toString().tr, title: "Error", iconData: Icons.error_outline));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.showSnackbar(Ui.SuccessSnackBar(message: response.walletName.toString().tr, title: "External Wallet", iconData: Icons.check_circle_outline));
  }

}