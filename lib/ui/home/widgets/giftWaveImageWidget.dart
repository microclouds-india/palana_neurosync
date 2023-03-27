import 'package:flutter/material.dart';
import 'package:palana_neurosync/ui/homeDetail/view/homeDetailsPage.dart';

import '../../../Api newtwork/Model/More waves model/more_waves_model.dart';
import '../../homeDetail/view/courseDetailsPage.dart';

class GiftWaveImageWidget extends StatelessWidget {
  int count;
  MoreWavesModel moreWavesModel;
  var filesData;
  Map<String, dynamic> imgThumbnail;
  GiftWaveImageWidget(
      {required this.count,
      required this.filesData,
      required this.moreWavesModel,
      required this.imgThumbnail});

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
      itemCount: moreWavesModel.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CourseDetailsScreen(
                id: moreWavesModel.data![index].id.toString(),
                img: imgThumbnail['data'][index]['image']['data'][0]['image'] ??
                    'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg',
              );
              //  HomeDetailsPage(

              //   img:
              //   id: moreWavesModel.data![index].id.toString(),
              //   free: false,
              //   prize: moreWavesModel.data![index].price ?? '00',
              //   days: moreWavesModel.data![index].days ?? '00',
              //   cutPrize: moreWavesModel.data![index].cutPrice ?? '00',
              //   packageDiscription:
              //       moreWavesModel.data![index].description ?? 'No description',
              //   packageName: moreWavesModel.data![index].title ?? 'no tittle',
              //   benefits: moreWavesModel.data![index].benefits ?? 'no benefits',
              //   tittle: moreWavesModel.data![index].title ?? 'no tittle',
              //   description:
              //       moreWavesModel.data![index].description ?? 'nodescription',
              //   audioUrl: moreWavesModel.data![index].audioUrl ?? '',
              //   videoLink: moreWavesModel.data![index].videoUrl ?? '',
              // );
            }));
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image(
                  width: double.infinity,
                  height: 150,
                  image: NetworkImage(imgThumbnail['data'][index]['image']
                          ['data'][0]['image'] ??
                      'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg'),
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
                      begin: AlignmentDirectional.bottomStart,
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
                    itemDetailsSection(
                        moreWavesModel.data![index].title!, 13.0),
                    itemDetailsSection(
                        moreWavesModel.data![index].description!, 11.0),
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
