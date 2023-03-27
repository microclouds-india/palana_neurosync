import 'package:get/get.dart';
import 'package:palana_neurosync/ui/allPackages/controller/allPackagesController.dart';
import 'package:palana_neurosync/ui/audio/controller/playAudioController.dart';
import 'package:palana_neurosync/ui/downloads/controller/downlodsController.dart';
import 'package:palana_neurosync/ui/home/controller/home_controller.dart';
import 'package:palana_neurosync/ui/home/controller/palana_home_controller.dart';
import 'package:palana_neurosync/ui/homeDetail/controller/home_details_controller.dart';
import 'package:palana_neurosync/ui/notifications/controller/notification_controller.dart';
import 'package:palana_neurosync/ui/packageDetails/controller/packageDetailsController.dart';
import 'package:palana_neurosync/ui/profile/controller/profileController.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<PalanaHomeController>(() => PalanaHomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<DownloadsController>(() => DownloadsController());
    // Get.put(HomeDetailsController());
    Get.lazyPut<PackageDetailsController>(() => PackageDetailsController());
    Get.lazyPut<AllPackagesController>(() => AllPackagesController());
    // Get.lazyPut<PlayAudioController>(() => PlayAudioController());
  }
}
