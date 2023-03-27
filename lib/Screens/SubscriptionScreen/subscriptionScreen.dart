import 'package:flutter/material.dart';
import 'package:palana_neurosync/Api%20newtwork/networks.dart';

import '../../Vars/Vars.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ApiNetworks apiNetworks = ApiNetworks();
    return Scaffold(
      backgroundColor: screenColor,
      appBar: AppBar(
        backgroundColor: screenColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'Subscription',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: apiNetworks.subscriptionNetwork(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container();
          } else {
            return Center(
              child: Text(
                'No Subscriptions',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
