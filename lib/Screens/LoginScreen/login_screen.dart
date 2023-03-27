import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:palana_neurosync/Screens/LoginScreen/OTP%20screen/otpScreen.dart';
import 'package:palana_neurosync/Screens/LoginScreen/User%20login/userLogin.dart';
import 'package:palana_neurosync/Vars/Vars.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widget/Login Button/login_button.dart';
import '../Widget/SignIn Butto/signinBtn.dart';
import '../Widget/Snackbar/snack_bar.dart';
import '../Widget/Text Row/text_row.dart';
import 'Conuntries/contriesScreen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController loginNumberController = TextEditingController();
bool otpConfirm = false;
// Map<String, dynamic>? _fbUser;

class _LoginScreenState extends State<LoginScreen> {
  // Future<UserCredential> signInWithFacebook() async {
  //   final LoginResult loginResult =
  //       await FacebookAuth.instance.login(permissions: ['email']);
  //   if (loginResult == LoginStatus.success) {
  //     final userData = await FacebookAuth.instance.getUserData();
  //     _fbUser = userData;
  //   } else {
  //     print(loginResult.message);
  //   }
  //   setState(() {});
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  // _getGoogleContacts(
  //     {required String name,
  //     required String email,
  //     required String image}) async {
  //   try {
  //     var httpClient = http.Client();
  //     var response = await httpClient.post(
  //         Uri.parse('https://cashbes.com/palana/login/register_google'),
  //         body: {'name': name, 'email': email, 'image': image});
  //     EasyLoading.show();
  //     if (response.statusCode == 200) {
  //       final prif = await SharedPreferences.getInstance();
  //       prif.setBool('LOGIN SUCCESS FULLY', true);
  //       EasyLoading.dismiss();
  //       Navigator.of(context).pushReplacementNamed('/home');
  //     } else {
  //       EasyLoading.dismiss();
  //       ScaffoldMessenger.of(context).showSnackBar(invalidLogin);
  //     }
  //   } catch (err) {
  //     EasyLoading.dismiss();
  //     ScaffoldMessenger.of(context).showSnackBar(invalidLogin);
  //   }
  // }
//fb login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Hello....',
                      style: TextStyle(
                          color: bColor,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                textRow(
                    fontWeight: FontWeight.w300,
                    sizd: 30,
                    txt: 'Enter your number'),
                SizedBox(
                  height: 10,
                ),
                textRow(
                    sizd: 20,
                    fontWeight: FontWeight.w300,
                    txt:
                        'We will send you a verification code\non this number'),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ConuntriesCodeScreen();
                        }));
                      },
                      child: Container(
                        height: 50,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Text(
                            '91',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // Expanded(
                    //   child: Container(
                    //     height: 50,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.all(Radius.circular(10)),
                    //         border: Border.all(color: Colors.grey)),
                    //     child: Expanded(
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: TextField()),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                        child: TextFormField(
                      controller: loginNumberController,
                      cursorColor: bColor,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 20),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    onTap: () async {
                      if (loginNumberController.text.length == 10) {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return OtpScreen(number: loginNumberController.text);
                        }));
                      }
                    },
                    child: loginButton(context, bColor, 'Get OTP')),
                // SizedBox(
                //   height: 10,
                // ),
                // Divider(
                //   color: bColor,
                //   thickness: 2,
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // GestureDetector(
                //     onTap: () {
                //       signInWithFacebook();
                //     },
                //     child: signInBtn(
                //         context, 'facebook.png', 'Continue with Facebook')),
                // SizedBox(
                //   height: 10,
                // ),
                // GestureDetector(
                //     onTap: () async {
                //       EasyLoading.show();
                //       final GoogleSignInAccount? googleUser =
                //           await GoogleSignIn().signIn();
                //       final GoogleSignInAuthentication? googleAuth =
                //           await googleUser?.authentication;
                //       final credential = GoogleAuthProvider.credential(
                //         accessToken: googleAuth?.accessToken,
                //         idToken: googleAuth?.idToken,
                //       );
                //       _getGoogleContacts(
                //           name: googleUser!.displayName!,
                //           email: googleUser.email,
                //           image: googleUser.photoUrl!);
                //     },
                //     child: signInBtn(
                //         context, 'search.png', 'Continue with Google')),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create new account',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w300),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return UserLogin();
                          }));
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              color: bColor, fontWeight: FontWeight.w300),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
