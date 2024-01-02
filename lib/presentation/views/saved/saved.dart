// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ePauna/presentation/custom_widgets/results_card.dart';
// import 'package:flutter_svg/svg.dart';
import '/presentation/app_data/size.dart';
import '/data/urls/urls.dart';
import '/data/models/model.dart';
import '/logic/services/services.dart';
import '../../app_data/colors.dart';
import '../hotel_desc/hotel_description.dart';

class Saved extends StatefulWidget {
  final user_ID;

  const Saved({required this.user_ID});

  @override
  State<Saved> createState() => _SavedState(user_ID);
}

List<Model> saved = <Model>[];

class _SavedState extends State<Saved> {
  var user_ID;
  _SavedState(this.user_ID);

  Services services = Services();
  bool isLoaded = false;
  bool showSaved = false;

  double baseWidth = 428;
  bool isLoading = false;

  List<Model> fetched = <Model>[];

  @override
  void initState() {
    isLoaded ? null : loadData();
    super.initState();
  }

  void loadData() {
    setState(() {
      isLoading = true;
    });
    services.getHotels(apiUrl: savedApi()).then((value) {
      setState(() {
        saved = value!;
        fetched = value;
        showSaved = true;
        isLoaded = true;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context: context);
    double fem = MediaQuery.of(context).size.width / baseWidth;
    // double ffem = fem * 0.97;
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 3), () async {
          setState(() {
            services.getHotels(apiUrl: savedApi()).then((value) {
              setState(() {
                saved = value!;
                showSaved = true;
              });
            });
          });
        });
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: isLoading
            ? Container(
                height: Get.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: showSaved,
                    child: (saved.isEmpty)
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    "assets/images/unavailable.png",
                                  ),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor),
                                    onPressed: () {},
                                    child: Text('No Saved Items'))
                              ],
                            ),
                          )
                        : isLoaded
                            ? ListView.builder(
                                itemCount: saved.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) {
                                  Future.delayed(Duration(seconds: 3),
                                      () async {
                                    Expanded(
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  });
                                  return SizedBox(
                                    child: GestureDetector(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    hotelDiscription(
                                                        fromSaved: true,
                                                        onSaved: loadData,
                                                        category: saved[index]
                                                                .categoryName ??
                                                            'N/A',
                                                        rest_ID:
                                                            saved[index].sid),
                                              ));
                                        }),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: ResultCard(
                                              ratings:
                                                  saved[index].averageRating,
                                              address:
                                                  saved[index].address ?? 'N/A',
                                              imageUrl: baseUrl +
                                                  "ServiceProviderProfile/" +
                                                  saved[index].logo!,
                                              fullName: saved[index].fullName ??
                                                  'N/A',
                                              index: index,
                                              priceRange:
                                                  ' Rs. ${saved[index].min} ',
                                              serviceCategory:
                                                  saved[index].categoryName ??
                                                      'N/A',
                                              size: size),
                                        )),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: fetched.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) {
                                  Future.delayed(Duration(seconds: 3),
                                      () async {
                                    Expanded(
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  });
                                  return SizedBox(
                                    child: GestureDetector(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    hotelDiscription(
                                                        fromSaved: true,
                                                        onSaved: loadData,
                                                        category: fetched[index]
                                                                .categoryName ??
                                                            'N/A',
                                                        rest_ID:
                                                            fetched[index].sid),
                                              ));
                                        }),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: ResultCard(
                                              ratings:
                                                  fetched[index].averageRating,
                                              address: fetched[index].address ??
                                                  'N/A',
                                              imageUrl: baseUrl +
                                                  "ServiceProviderProfile/" +
                                                  fetched[index].logo!,
                                              fullName:
                                                  fetched[index].fullName ??
                                                      'N/A',
                                              index: index,
                                              priceRange:
                                                  'NRP ${fetched[index].min} - Rs. ${fetched[index].max}',
                                              serviceCategory:
                                                  fetched[index].categoryName ??
                                                      'N/A',
                                              size: size),
                                        )),
                                  );
                                },
                              ),
                  )
                ],
              ),
      ),
    );
  }
}
