import 'package:get/get.dart';
import 'package:palana_neurosync/routes/app_routes.dart';
import 'package:palana_neurosync/ui/aboutUs/view/aboutUsPage.dart';
import 'package:palana_neurosync/ui/allPackages/view/AllPackagesPage.dart';
import 'package:palana_neurosync/ui/audio/view/playAudioPage.dart';
import 'package:palana_neurosync/ui/home/binding/home_binding.dart';
import 'package:palana_neurosync/ui/home/view/homePage.dart';
import 'package:palana_neurosync/ui/homeDetail/view/homeDetailsPage.dart';
import 'package:palana_neurosync/ui/packageDetails/view/packageDetailsPage.dart';
import 'package:palana_neurosync/ui/splash/firstSplashScreen.dart';
import 'package:palana_neurosync/ui/splash/splashScreen.dart';

class AppPages {

  static const INITIAL = Routes.INITIALROOT;
  static const HOME = Routes.HOME;

  static final routes = [

    GetPage(name: Routes.INITIALROOT, page: () => FirstSplashScreen()),
    GetPage(name: Routes.SPLASHSCREEN, page: () => SplashScreen()),
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.HOMEDETAILSPAGE, page: () => HomeDetailsPage(), binding: HomeBinding()),
    GetPage(name: Routes.PACKAGEDETAILSPAGE, page: () => PackageDetailsPage(), binding: HomeBinding()),
    GetPage(name: Routes.ALLPACKAGESPAGE, page: () => AllPackagesPge(), binding: HomeBinding()),
    GetPage(name: Routes.ABOUTUSPAGE, page: () => AboutUsPage()),
    GetPage(name: Routes.PLAYAUDIOPAGE, page: () => PlayAudioPage(), binding: HomeBinding()),

  ];

}