import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/common/assetImages.dart';
import 'package:palana_neurosync/common/strings.dart';
import 'package:palana_neurosync/routes/app_routes.dart';
import 'package:palana_neurosync/ui/profile/controller/profileController.dart';

class ProfilePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
              child: Column(
                children: [
                  Row(
                    children: [
                      SafeArea(
                        child: Container(
                          margin: EdgeInsets.all(15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(AssetImages().no_notifications,
                              width: 40.0,
                              height: 40.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Name",
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "9999999999",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
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
            Column(
              children: [
                const SizedBox(height: 10),
                profileSection(
                    title: Strings().reminder,
                    iconData: Icons.alarm,
                    iconColor: Colors.red,
                    buttonAction: () {
                      Get.toNamed(Routes.HOMEDETAILSPAGE);
                    }),
                profileSection(
                    title: Strings().subscriptions,
                    iconData: Icons.notifications_on_outlined,
                    iconColor: Colors.yellow.shade800,
                    buttonAction: () {
                      Get.toNamed(Routes.HOMEDETAILSPAGE);
                    }),
                profileSection(
                    title: Strings().blog,
                    iconData: Icons.wifi,
                    iconColor: Colors.yellow.shade800,
                    buttonAction: () {
                      Get.toNamed(Routes.HOMEDETAILSPAGE);
                    }),
                profileSection(
                    title: Strings().our_website,
                    iconData: Icons.signal_cellular_connected_no_internet_0_bar,
                    iconColor: Colors.yellow.shade800,
                    buttonAction: () {
                      Get.toNamed(Routes.HOMEDETAILSPAGE);
                    }),
                profileSection(
                    title: Strings().rate_app,
                    iconData: Icons.thumb_up,
                    iconColor: Colors.yellow.shade800,
                    buttonAction: () {
                      Get.toNamed(Routes.HOMEDETAILSPAGE);
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
                      Get.toNamed(Routes.HOMEDETAILSPAGE);
                    }),
                profileSection(
                    title: Strings().share,
                    iconData: Icons.share,
                    iconColor: Colors.green.shade800,
                    buttonAction: () {
                      Get.toNamed(Routes.HOMEDETAILSPAGE);
                    }),
                profileSection(
                    title: Strings().faqs,
                    iconData: Icons.question_mark,
                    iconColor: Colors.green.shade800,
                    buttonAction: () {
                      Get.toNamed(Routes.HOMEDETAILSPAGE);
                    }),
                profileSection(
                    title: Strings().terms_and_conditions,
                    iconData: Icons.note_alt_outlined,
                    iconColor: Colors.green.shade800,
                    buttonAction: () {
                      Get.toNamed(Routes.HOMEDETAILSPAGE);
                    }),
                profileSection(
                    title: Strings().privacy_policy,
                    iconData: Icons.event_note_outlined,
                    iconColor: Colors.green.shade800,
                    buttonAction: () {
                      Get.toNamed(Routes.HOMEDETAILSPAGE);
                    }),
                profileSection(
                    title: Strings().logout,
                    iconData: Icons.logout,
                    iconColor: Colors.red,
                    buttonAction: () {
                      Get.toNamed(Routes.HOMEDETAILSPAGE);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
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
                  Container(
                    child: Center(
                      child: Text(
                        'week',
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        'month',
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        'year',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
