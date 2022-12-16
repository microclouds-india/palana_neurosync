import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/ui/downloads/view/downloadsPage.dart';
import 'package:palana_neurosync/ui/home/controller/home_controller.dart';
import 'package:palana_neurosync/ui/home/view/palanaHome.dart';
import 'package:palana_neurosync/ui/notifications/view/notificationPage.dart';
import 'package:palana_neurosync/ui/profile/view/profilePage.dart';
import 'package:palana_neurosync/ui/waves/view/wavesPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
            children: [
              PalanaHome(),
              WavesPage(),
              DownloadsPage(),
              NotificationPage(),
              ProfilePage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey.shade800,
            selectedItemColor: Colors.deepPurple.shade800,
            onTap: controller.changeTabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.tabIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              _bottomNavigationBarItem(
                  iconData: Icons.home,
                label: "Home"),
              _bottomNavigationBarItem(
                  iconData: Icons.waves,
                  label: "Waves"),
              _bottomNavigationBarItem(
                  iconData: Icons.library_music_outlined,
                  label: "Profile"),
              _bottomNavigationBarItem(
                  iconData: Icons.notifications,
                  label: "Notifications"),
              _bottomNavigationBarItem(
                  iconData: Icons.person,
                  label: "Profile"),
            ],
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({required IconData iconData, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(iconData),
      label: label,
    );
  }
}
