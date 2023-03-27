// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:palana_neurosync/routes/app_routes.dart';
// import 'package:palana_neurosync/ui/homeDetail/view/homeDetailsPage.dart';

// import '../../../Api newtwork/Model/Courses View Model/coursers_view_model.dart';
// import '../../../Api newtwork/Model/More waves model/more_waves_model.dart';

// class CourseWaveImageWidget extends StatelessWidget {
//   String img;
//   // FilesData filesData;
//   int count;
//   CousersViewModel cousersViewModel;
//   CourseWaveImageWidget(
//       {required this.count, required this.cousersViewModel, required this.img,
//       // required this.filesData,
//       });

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       primary: false,
//       shrinkWrap: true,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10.0,
//         mainAxisSpacing: 10.0,
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//       itemCount: cousersViewModel.data!.length,
//       itemBuilder: (BuildContext context, int index) {
//         return GestureDetector(
//           onTap: () {
//             Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//               return HomeDetailsPage(
      
//               //  filesData: filesData,
//                                 img: img,
//                 id: cousersViewModel.data![index].id.toString(),
//                 free: false,
//                 prize: cousersViewModel.data![index].price!,
//                 days: cousersViewModel.data![index].days!,
//                 cutPrize: cousersViewModel.data![index].cutPrice!,
//                 packageDiscription: cousersViewModel.data![index].description!,
//                 packageName: cousersViewModel.data![index].title!,
//                 benefits: cousersViewModel.data![index].benefits,
//                 tittle: cousersViewModel.data![index].title,
//                 description: cousersViewModel.data![index].description,
//                 audioUrl: cousersViewModel.data![index].audioUrl,
//                 videoLink: cousersViewModel.data![index].videoUrl,
//               );
//             }));
//           },
//           child: Stack(
//             children: [
//               Image(
//                 width: double.infinity,
//                 height: 280,
//                 image: NetworkImage(img),
//                 fit: BoxFit.cover,
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 150,
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       colors: [Colors.grey, Colors.grey.withOpacity(0.1)],
//                       begin: AlignmentDirectional.topStart,
//                       end: AlignmentDirectional.bottomEnd,
//                       stops: [0.1, 0.9],
//                       tileMode: TileMode.clamp),
//                   borderRadius: const BorderRadius.all(Radius.circular(20)),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     itemDetailsSection(
//                         cousersViewModel.data![index].title!, 13.0),
//                     itemDetailsSection(
//                         cousersViewModel.data![index].description!, 11.0),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   itemDetailsSection(String itemDetailsText, double fontSize) {
//     return Align(
//       alignment: Alignment.bottomLeft,
//       child: Container(
//         margin: const EdgeInsets.only(left: 10.0, bottom: 5.0),
//         child: Text(
//           itemDetailsText,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: fontSize,
//           ),
//         ),
//       ),
//     );
//   }
// }
