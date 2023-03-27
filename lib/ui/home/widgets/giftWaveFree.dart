import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palana_neurosync/routes/app_routes.dart';
import 'package:palana_neurosync/ui/homeDetail/view/homeDetailsPage.dart';

import '../../../Api newtwork/Model/Courses View Model/coursers_view_model.dart';
import '../../../Api newtwork/Model/More waves model/more_waves_model.dart';

class CourseWaveFreeWidget extends StatelessWidget {
  int count;
  // FilesData filesData;
  CourseWaveFreeWidget({
    required this.count,
    // required this.filesData,
  });

  String tempImg =
      'https://firebasestorage.googleapis.com/v0/b/resso-52e3f.appspot.com/o/WhatsApp-Image-2020-09-25-at-7.15.05-PM.jpeg?alt=media&token=07ebe9de-ad53-4e1c-9d0e-5fed1f3b2e5f';

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return HomeDetailsPage(
               
                // filesData: filesData,
                img: tempImg,
                id: '',
                free: true,
                prize: '',
                days: '',
                cutPrize: '',
                packageDiscription: '',
                packageName: 'Relax',
                benefits: 'improing your confidence',
                tittle: 'Relax',
                description: 'Personal empowerment and self esteem\nbooster',
                audioUrl: '',
                videoLink: '',
              );
            }));
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image(
                  width: double.infinity,
                  height: 150,
                  image: NetworkImage(tempImg),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                height: 150,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(84, 0, 0, 0),
                        Color.fromARGB(139, 0, 0, 0).withOpacity(0.1)
                      ],
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      stops: [0.1, 0.9],
                      tileMode: TileMode.clamp),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    itemDetailsSection('Relax', 13.0),
                    itemDetailsSection(
                        'Personal empowerment and self esteem\nbooster', 11.0),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  itemDetailsSection(String itemDetailsText, double fontSize) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 10.0, bottom: 5.0),
        child: Text(
          itemDetailsText,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
