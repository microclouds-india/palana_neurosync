import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:palana_neurosync/Screens/Reminder/reminderScreenUi.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Api newtwork/Model/Profile View Model/profile_view_model.dart';
import '../../../Api newtwork/Url.dart';
import '../../../Screens/Disclaimer/disclaimerScreen.dart';
import '../../../Screens/Edit Profile/Edit profile Screenn/editProfileScreen.dart';
import '../../../Screens/SubscriptionScreen/subscriptionScreen.dart';
import '../../../Screens/Widget/AlertBox/alert_box.dart';
import '../../../Screens/faq_Screen/faq_Screen.dart';
import '../../../Vars/Share/shareFn.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

ProfileViewModel _profileViewModel = ProfileViewModel();
bool profileScreenLoading = false;
ValueNotifier<String> NameData = ValueNotifier(
  _profileViewModel.data![0].name!,
);

class _ProfilePageState extends State<ProfilePage> {
  getProfileData() async {
    final prif = await SharedPreferences.getInstance();
    var url = Uri.parse(profileScreenApi);
    var response = await http.post(url, body: {
      'token': prif.getString('Token'),
    });
    var json = jsonDecode(response.body);
    _profileViewModel = ProfileViewModel.fromJson(json);
    setState(() {
      profileScreenLoading = true;
    });
    prif.setString('MailId', _profileViewModel.data![0].email!);
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: profileScreenLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Colors.pink.shade600,
                              Colors.deepPurple.shade800,
                            ]),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return EditProfileScreen(
                              editEmail: _profileViewModel.data![0].email!,
                              editName: NameData.value,
                            );
                          }));
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SafeArea(
                                  child: Container(
                                    margin: EdgeInsets.all(15.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        AssetImages().no_notifications,
                                        width: 40.0,
                                        height: 40.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                SafeArea(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ValueListenableBuilder(
                                          valueListenable: NameData,
                                          builder: (BuildContext context,
                                              String value, Widget) {
                                            return Text(
                                              value,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            );
                                          }),
                                      SizedBox(height: 5),
                                      Text(
                                        _profileViewModel.data![0].phone!,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            profileTabSection(),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        profileSection(
                            title: Strings().reminder,
                            iconData: Icons.alarm,
                            iconColor: Colors.red,
                            buttonAction: () async {
                              final prif =
                                  await SharedPreferences.getInstance();
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ReminderScreen();
                                // selectedWeek: prif.getStringList('stringList')!.toList(),
                              }));
                            }),
                        profileSection(
                            title: Strings().subscriptions,
                            iconData: Icons.notifications_on_outlined,
                            iconColor: Colors.yellow.shade800,
                            buttonAction: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return SubscriptionScreen();
                              }));
                            }),
                        profileSection(
                            title: Strings().blog,
                            iconData: Icons.wifi,
                            iconColor: Colors.yellow.shade800,
                            buttonAction: () async {
                              final url =
                                  Uri.parse('https://neurosync.in/blog/');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              }
                            }),
                        profileSection(
                            title: Strings().our_website,
                            iconData: Icons
                                .signal_cellular_connected_no_internet_0_bar,
                            iconColor: Colors.yellow.shade800,
                            buttonAction: () async {
                              final url = Uri.parse('https://neurosync.in/');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              }
                            }),
                        profileSection(
                            title: Strings().rate_app,
                            iconData: Icons.thumb_up,
                            iconColor: Colors.yellow.shade800,
                            buttonAction: () async {
                              LaunchReview.launch(
                                androidAppId: "id=com.palana.palanawellness",
                              );
                            }),
                        profileSection(
                            title: Strings().about_us,
                            iconData: Icons.people,
                            iconColor: Colors.green.shade800,
                            buttonAction: () {
                              Get.toNamed(Routes.ABOUTUSPAGE);
                            }),
                        profileSection(
                            title: Strings().disclaimer,
                            iconData: Icons.share,
                            iconColor: Colors.green.shade800,
                            buttonAction: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return DisclimerScreen();
                              }));
                            }),
                        profileSection(
                            title: Strings().share,
                            iconData: Icons.share,
                            iconColor: Colors.green.shade800,
                            buttonAction: () {
                              ShareApp shareApp = ShareApp();
                              shareApp.shareAppFn();
                            }),
                        profileSection(
                            title: Strings().faqs,
                            iconData: Icons.question_mark,
                            iconColor: Colors.green.shade800,
                            buttonAction: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return FaqScreen();
                              }));
                            }),
                        profileSection(
                            title: Strings().terms_and_conditions,
                            iconData: Icons.note_alt_outlined,
                            iconColor: Colors.green.shade800,
                            buttonAction: () async {
                              final url = Uri.parse(
                                  'https://neurosync.in/terms-of-service-refund-policy/');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              }
                            }),
                        profileSection(
                            title: Strings().privacy_policy,
                            iconData: Icons.event_note_outlined,
                            iconColor: Colors.green.shade800,
                            buttonAction: () async {
                              final url = Uri.parse(
                                  'https://neurosync.in/privacy-policy/');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              }
                            }),
                        profileSection(
                            title: Strings().logout,
                            iconData: Icons.logout,
                            iconColor: Colors.red,
                            buttonAction: () {
                              showMyDialog(context);
                            }),
                      ],
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  Widget profileSection(
      {required String title,
      required IconData iconData,
      required Color iconColor,
      required void Function() buttonAction}) {
    return GestureDetector(
      onTap: buttonAction,
      child: Container(
        margin: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 7.0, bottom: 7.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(48), // Image radius
                  child: Icon(iconData, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_forward_ios,
                    color: Colors.grey.shade500, size: 17),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  Widget profileTabSection() {
    return Container(
      height: 175,
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffF15C22),
                    width: 2.0,
                  ),
                ),
              ),
              tabs: [
                Tab(
                  text: "week",
                ),
                Tab(
                  text: "month",
                ),
                Tab(
                  text: "year",
                ),
              ],
            ),
            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  tabView(
                      statics: true,
                      hrr: false,
                      hour: 0,
                      packagename: 'Relax',
                      totalHour: 168),
                  tabView(
                      statics: true,
                      hrr: false,
                      hour: 0,
                      packagename: 'Relaz',
                      totalHour: 730.001.toInt()),
                  tabView(
                      statics: false,
                      hrr: true,
                      hour: 1000,
                      packagename: 'relax',
                      totalHour: 8760)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statiticsTxt(String txt) {
    return Text(
      txt,
      style: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  Widget tabView({
    required String packagename,
    required bool statics,
    required bool hrr,
    required int hour,
    required int totalHour,
  }) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          children: [
            Visibility(
                visible: hrr,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                              color: Colors.yellow, shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          packagename,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          hour.toString(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                )),
            Visibility(
                visible: statics,
                child: Center(child: statiticsTxt('No Statitics'))),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                statiticsTxt('Total'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      width: 300,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: (hour / totalHour) * 300,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                statiticsTxt('${hour}h')
              ],
            )
          ],
        ),
      ),
    );
  }
}
