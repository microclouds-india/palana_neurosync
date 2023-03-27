import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:palana_neurosync/Database/Init%20Database/initDatabase.dart';
import 'package:palana_neurosync/routes/app_pages.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'Api newtwork/Notifications/alaram_notifications.dart';
import 'Database/Alam Database/alamyDatabase.dart';

// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
int hourCount = 0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage((message) {
  // return AwesomeNotifications().createNotificationFromJsonData(message.data);
  // });
  await initDatabase();
  await initAlamyDatabase();
  // await AndroidAlarmManager.initialize();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'basic notifications',
            channelDescription: 'notification for basic tests')
      ],
      debug: true);

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation();
  }

  runApp(
    GetMaterialApp(
      builder: EasyLoading.init(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      themeMode: ThemeMode.system,
    ),
  );
  configLoading();
}
