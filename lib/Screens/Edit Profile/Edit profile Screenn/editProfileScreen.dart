import 'package:flutter/material.dart';
import 'package:palana_neurosync/Screens/Widget/Login%20Button/login_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Api newtwork/Url.dart';
import '../../../Vars/Vars.dart';
import '../../Widget/Snackbar/snack_bar.dart';
import '../Vars/Controllers.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  String editName;
  String editEmail;
  EditProfileScreen({required this.editName, required this.editEmail});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    editNameController.text = widget.editName;
    editEmailConteroller.text = widget.editEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Edit your profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: editNameController,
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
                controller: editEmailConteroller,
                keyboardType: TextInputType.name,
                cursorColor: bColor,
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
            GestureDetector(
                onTap: () async {
                  if (editNameController.text == '' &&
                      editEmailConteroller.text == '') {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(EditProfilwinvalid);
                  } else {
                    final prif = await SharedPreferences.getInstance();
                    var url = Uri.parse(editProfilrApi);
                    var response = await http.post(url, body: {
                      'token': prif.getString('Token'),
                      'name': editNameController.text,
                      'email': editEmailConteroller.text,
                    });
                    AddData();
                    Navigator.of(context).pop();
                  }
                },
                child: loginButton(context, bColor, 'Save')),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
