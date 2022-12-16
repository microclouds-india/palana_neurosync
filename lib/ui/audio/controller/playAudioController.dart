// import 'package:audioplayers/audioplayers.dart';
// import 'package:get/get.dart';
//
// class PlayAudioController extends GetxController {
//
//   final audioPlayer = AudioPlayer().obs;
//   var isPlaying = false.obs;
//   var duration = Duration.zero.obs;
//   var position = Duration.zero.obs;
//
//   @override
//   void onInit() async {
//
//     setAudio();
//
//     audioPlayer.value.onPlayerStateChanged.listen((state) {
//         isPlaying.value = state == PlayerState.playing;
//     });
//     audioPlayer.value.onDurationChanged.listen((newDuration) {
//         duration.value = newDuration;
//     });
//     audioPlayer.value.onPositionChanged.listen((newPosition) {
//         position.value = newPosition;
//     });
//
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     // TODO: implement onClose
//     audioPlayer.value.pause();
//     super.onClose();
//   }
//
//   @override
//   void dispose() {
//     audioPlayer.value.pause();
//     audioPlayer.value.dispose();
//     super.dispose();
//   }
//
//   Future setAudio() async {
//     audioPlayer.value.setReleaseMode(ReleaseMode.loop);
//
//     String url ="https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
//     audioPlayer.value.setSourceUrl(url);
//   }
//
// }