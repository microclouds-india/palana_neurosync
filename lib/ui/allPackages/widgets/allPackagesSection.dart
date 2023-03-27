import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:palana_neurosync/Api%20newtwork/Model/Courses%20View%20Model/coursers_view_model.dart';
import 'package:palana_neurosync/ui/homeDetail/widgets/subscribePackageSection.dart';


class AllPackagesSection extends StatefulWidget {
  const AllPackagesSection({Key? key}) : super(key: key);

  @override
  State<AllPackagesSection> createState() => _AllPackagesSectionState();
}

List color = [];

class _AllPackagesSectionState extends State<AllPackagesSection> {
  CousersViewModel _cousersViewModel = CousersViewModel();
  bool packageLoader = false;
  getPackage() async {
    var uri = Uri.parse('https://cashbes.com/palana/apis/courses');
    var rsponse = await http.get(uri);
    if (rsponse.statusCode == 200) {
      var json = jsonDecode(rsponse.body);
      _cousersViewModel = CousersViewModel.fromJson(json);
      setState(() {
        packageLoader = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPackage();
  }

  @override
  Widget build(BuildContext context) {
    return packageLoader
        ? ListView.builder(
            itemCount: _cousersViewModel.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SubscribePackageSection(
                  tittle: 'Tittle',
                  id: _cousersViewModel.data![index].id!,
                  description: _cousersViewModel.data![index].description!,
                  days: _cousersViewModel.data![index].days!,
                  packageName: _cousersViewModel.data![index].title!,
                  benefites: _cousersViewModel.data![index].benefits!,
                  newAmount: _cousersViewModel.data![index].price!,
                  oldAmount: _cousersViewModel.data![index].cutPrice!,
                ),
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
