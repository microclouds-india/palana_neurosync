// import 'package:flutter/material.dart';
// import 'package:palana_neurosync/common/assetImages.dart';
// import 'package:palana_neurosync/common/strings.dart';

// class NoInternetScreen extends StatelessWidget {
//   const NoInternetScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       body: Stack(
//         children: [
//           SizedBox(
//             height: double.infinity,
//             width: double.infinity,
//             child: Image.asset(AssetImages().bg_image, fit: BoxFit.cover),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Container(
//                   margin: EdgeInsets.only(left: 50, right: 50),
//                   child: Image.asset(AssetImages().logo),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Center(
//                 child: Container(
//                   margin: EdgeInsets.only(left: 50, right: 50),
//                   child: Text(
//                     Strings().caring_quote,
//                     style: TextStyle(
//                       color: Colors.deepPurple.shade100,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Center(
//                 child: ElevatedButton(
//                     onPressed: () {},
//                     child: Text(
//                       'Retry',
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     )),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Center(
//                 child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pushNamed('/downloadscreen');
//                     },
//                     child: Text(
//                       'Go Offline',
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     )),
//               )
//             ],
//           ),
//         ],
//       ),
//     ));
//   }
// }
