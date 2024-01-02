import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import '../choose_room/choose_room.dart';
import '/bloc/internet_bloc.dart';
import '../../../data/repository/save_repository.dart';
import '/data/user_data/data.dart';
import '/presentation/app_data/size.dart';
import '/presentation/internet_lost/error_state.dart';
import '/presentation/internet_lost/not_connection.dart';
import '../../../bloc/internet_state.dart';
import '../../../data/urls/urls.dart';
import '../../../data/models/model.dart';
import '../../../logic/services/services.dart';
import '../../app_data/colors.dart';

class hotelDiscription extends StatefulWidget {
  final dynamic rest_ID;
  final dynamic category;
  Function? onSaved;
  bool fromSaved;
  hotelDiscription({
    super.key,
    required this.rest_ID,
    required this.category,
    this.onSaved,
    this.fromSaved = false,
  });

  @override
  State<hotelDiscription> createState() => _hotelDiscriptionState();
}

class _hotelDiscriptionState extends State<hotelDiscription> {
  var imgNo;
  String? title = '';
  String? address = '';
  String? description = '';
  String? category = '';
  String? sid = '';
  String? contactus = '';
  bool descVisible = false;
  String? googleMapLocation = '';
  String? city = '';
  String? generalFacility = '';
  String? popularFacility = '';
  String? services = '';
  int? min = 0;
  int? max = 0;
  String? createdAt = '';
  String? updatedAt = '';
  String? bid = '';
  bool? showImg = false;
  String? catrgoryName = '';
  String? website = '';
  List<DescPics> descPics = [];
  DescServices descServices = DescServices();
  bool? saveStatus;

  @override
  void initState() {
    super.initState();
    getData(apiUrl: getDesc(resurant_ID: widget.rest_ID));
    descServices
        .descPics(apiUrl: getImgApi(resurant_ID: widget.rest_ID))
        .then((value) {
      descPics = value!;
      showImg = true;
    });
    imgCount();
    saveCheck();
  }

  saveCheck() async {
    SaveServiceRepository saveService = SaveServiceRepository();
    var res = await saveService.getSaveStatus(s_id: widget.rest_ID);
    setState(() {
      saveStatus = res;
    });
  }

  saveUnsave() async {
    SaveServiceRepository saveService = SaveServiceRepository();
    await saveService.saveUnsaveService(s_id: widget.rest_ID);
    setState(() {
      // saveStatus = null;
      saveCheck();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize size = AppSize(context: context);
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<InternetBloc, InternetState>(
      builder: (context, state) {
        if (state is InternetLostState) {
          return InternetLostScreen();
        }
        if (state is InternetGainedState) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: whiteColor,
              leading: IconButton(
                onPressed: () {
                  widget.fromSaved ? widget.onSaved!() : null;
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: blackColor,
                ),
              ),
              centerTitle: true,
              // systemOverlayStyle: SystemUiOverlayStyle(
              //   statusBarIconBrightness: Brightness.light,
              //   statusBarColor: mainColor,
              // ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.width-70,
                                      child: Text(
                                        title!,
                                        style: TextStyle(
                                          fontSize: 24 * size.ex_small(),
                                          fontWeight: FontWeight.bold,
                                          color: blackColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                    child: Align(
                                  alignment: Alignment.topRight,
                                  child: (saveStatus == true && user_id != null)
                                      ? FloatingActionButton(
                                          backgroundColor: mainColor,
                                          mini: true,
                                          onPressed: saveUnsave,
                                          child: Icon(Icons.favorite,
                                              size: size.small() * 20),
                                        )
                                      : (saveStatus == false && user_id != null)
                                          ? FloatingActionButton(
                                              backgroundColor: mainColor,
                                              mini: true,
                                              onPressed: saveUnsave,
                                              child: Icon(Icons.favorite_border,
                                                  size: size.small() * 20),
                                            )
                                          : SizedBox.shrink(),
                                ))
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${widget.category} ,',
                                  style: TextStyle(
                                    fontSize: 15 * size.ex_small(),
                                    fontWeight: FontWeight.w400,
                                    color: blackColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 3 * size.ex_small(),
                                ),
                                SvgPicture.asset(
                                  "assets/map-pin-line.svg",
                                  color: blackColor,
                                  width: size.ex_small() * 15,
                                ),
                                SizedBox(
                                  width: 3 * size.ex_small(),
                                ),
                                Flexible(
                                  child: Text(
                                    address!,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 15 * size.ex_small(),
                                      fontWeight: FontWeight.w400,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10 * size.ex_small(),
                            ),
                            SizedBox(
                              height: size.large() * 0.9,
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 4,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0),
                                itemBuilder: (BuildContext context, int index) {
                                  return index <= 2
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              5 * size.small()),
                                          child: Visibility(
                                            visible: showImg!,
                                            replacement: Container(
                                              width: size.ex_small() * 100,
                                              height: height * 0.2,
                                              color: Colors.grey[200],
                                            ),
                                            child: (index != 2)
                                                ? FadeInImage.assetNetwork(
                                                    placeholder:
                                                        'assets/images/nophoto.jpg',
                                                    image:
                                                        '${baseUrl}ServiceProviderGallery/${(showImg!) ? descPics[index].image : ''}',
                                                    fit: BoxFit.cover,
                                                  )
                                                : (descPics.length >= 3)
                                                    ? FadeInImage.assetNetwork(
                                                        placeholder:
                                                            'assets/images/nophoto.jpg',
                                                        image:
                                                            "${baseUrl}ServiceProviderGallery/${(showImg!) ? descPics[index].image : ''}",
                                                            fit: BoxFit.cover,)
                                                    : Container(
                                                        width: size.ex_small() *
                                                            100,
                                                        height: height * 0.2,
                                                        color: Colors.grey[200],
                                                      ),
                                          ),
                                        )
                                      : Stack(
                                          children: [
                                            Positioned.fill(
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      content: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                        child: Stack(
                                                          children: [
                                                            Swiper(
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return FadeInImage
                                                                    .assetNetwork(
                                                                  placeholder:
                                                                      'assets/images/nophoto.jpg',
                                                                  image:
                                                                      "${baseUrl}ServiceProviderGallery/${descPics[index].image}",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                );
                                                              },
                                                              itemCount:
                                                                  descPics
                                                                      .length,
                                                              pagination:
                                                                  const SwiperPagination(),
                                                              // control:
                                                              //     SwiperControl(),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child:
                                                                  FloatingActionButton(
                                                                mini: true,
                                                                backgroundColor:
                                                                    whiteColor,
                                                                foregroundColor:
                                                                    blackColor,
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Icon(
                                                                    Icons
                                                                        .close),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5 * size.small()),
                                                  child: Visibility(
                                                    visible: showImg!,
                                                    replacement: Container(
                                                      width:
                                                          size.ex_small() * 100,
                                                      height: height * 0.22,
                                                      color: Colors.grey[200],
                                                    ),
                                                    child: (descPics.length > 3)
                                                        ? FadeInImage
                                                            .assetNetwork(
                                                            placeholder:
                                                                'assets/images/nophoto.jpg',
                                                            image:
                                                                '${baseUrl}ServiceProviderGallery/${(showImg!) ? descPics[index].image : ''}',
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Container(
                                                            width:
                                                                size.ex_small() *
                                                                    100,
                                                            height:
                                                                height * 0.22,
                                                            color: Colors
                                                                .grey[200],
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 15,
                                                right: 15,
                                                child: Container(
                                                  color: blackColor,
                                                  child: Row(children: [
                                                    Icon(
                                                      Icons.collections,
                                                      color: whiteColor,
                                                    ),
                                                    Visibility(
                                                      visible: showImg!,
                                                      child: Text(
                                                        "",
                                                        style: TextStyle(
                                                            color: whiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Text("+",
                                                        style: TextStyle(
                                                            color: whiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ]),
                                                ))
                                          ],
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.small() * 10,
                              size.small() * 10,
                              size.small() * 10,
                              size.small() * 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About Hotel :',
                                style: TextStyle(
                                  fontSize: 17 * size.ex_small(),
                                  fontWeight: FontWeight.bold,
                                  color: blackColor,
                                ),
                              ),
                              SizedBox(
                                height: size.ex_small() * 10,
                              ),
                              Visibility(
                                visible: descVisible,
                                replacement: Shimmer.fromColors(
                                  period: Duration(milliseconds: 800),
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: double.infinity,
                                    height: size.ex_small() * 100,
                                    color: Colors.white,
                                  ),
                                ),
                                child: Text(
                                  '${description}',
                                  style: TextStyle(
                                    height:
                                        1.4 * size.ex_small() / size.small(),
                                    fontSize: 14 * size.ex_small(),
                                    fontWeight: FontWeight.w400,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.ex_small() * 17,
                              ),
                              // MapPage(location: title!),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Service & Facilities :',
                              style: TextStyle(
                                fontSize: 20 * size.ex_small(),
                                fontWeight: FontWeight.w600,
                                height: 1.5 * size.ex_small() / size.small(),
                                color: blackColor,
                              ),
                            ),
                            Visibility(
                              visible: descVisible,
                              replacement: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: size.ex_small() * 300,
                                  color: Colors.white,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'General',
                                          style: TextStyle(
                                            fontSize: 16 * size.ex_small(),
                                            wordSpacing: 10,
                                            fontWeight: FontWeight.w400,
                                            color: blackColor,
                                          ),
                                        ),
                                        for (int i = 0;
                                            i <
                                                splitWord(generalFacility)
                                                        .length -
                                                    1;
                                            i++)
                                          if (splitWord(generalFacility)[i] !=
                                              '')
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/check-line.svg",
                                                  color: blackColor,
                                                  width: size.ex_small() * 14,
                                                ),
                                                SizedBox(
                                                  width: size.ex_small() * 4,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    '${splitWord(generalFacility)[i]}',
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontSize:
                                                          14 * size.ex_small(),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.5 *
                                                          size.ex_small() /
                                                          size.small(),
                                                      color: blackColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Most Popular',
                                            style: TextStyle(
                                              fontSize: 16 * size.ex_small(),
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xcc000000),
                                            ),
                                          ),
                                          for (int i = 0;
                                              i <
                                                  splitWord(popularFacility)
                                                          .length -
                                                      1;
                                              i++)
                                            (splitWord(popularFacility)[i] !=
                                                    '')
                                                ? Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                        SvgPicture.asset(
                                                          "assets/check-line.svg",
                                                          color: blackColor,
                                                          width:
                                                              size.ex_small() *
                                                                  14,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              size.ex_small() *
                                                                  4,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            '${splitWord(popularFacility)[i]}',
                                                            style: TextStyle(
                                                              fontSize: 14 *
                                                                  size.ex_small(),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 1.5 *
                                                                  size.ex_small() /
                                                                  size.small(),
                                                              color: blackColor,
                                                            ),
                                                          ),
                                                        )
                                                      ])
                                                : SizedBox.shrink(),
                                        ]),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10 * size.ex_small(),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Services',
                                        style: TextStyle(
                                          fontSize: 18 * size.ex_small(),
                                          wordSpacing: 10,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xcc000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                  for (int i = 0;
                                      i < splitWord(services).length - 1;
                                      i++)
                                    (splitWord(services)[i] != '')
                                        ? Row(children: [
                                            SvgPicture.asset(
                                              "assets/check-line.svg",
                                              color: blackColor,
                                              width: size.ex_small() * 14,
                                            ),
                                            SizedBox(
                                              width: size.ex_small() * 4,
                                            ),
                                            Flexible(
                                              child: Text(
                                                '${splitWord(services)[i]}',
                                                style: TextStyle(
                                                  fontSize:
                                                      14 * size.ex_small(),
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.5 *
                                                      size.ex_small() /
                                                      size.small(),
                                                  color: blackColor,
                                                ),
                                              ),
                                            )
                                          ])
                                        : SizedBox.shrink(),
                                  SizedBox(
                                    height: size.large() * 0.09,
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
            ),
            bottomNavigationBar: Container(
                width: double.infinity,
                height: 65 * size.small(),
                color: whiteColor,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ChooseRoom(
                                businessId: bid,
                                serviceId: widget.rest_ID,
                              )));
                    },
                    child: Visibility(
                      visible: (bid.toString() == "") ? false : true,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: blackColor, width: 2),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.small() * 10,
                              size.small() * 5,
                              size.small() * 10,
                              size.small() * 5),
                          child: Text(
                            "Select ${(bid.toString() == "1") ? "Room" : "Service"}",
                            style: TextStyle(
                              fontSize: 20 * size.ex_small(),
                              fontWeight: FontWeight.w500,
                              height: 1.5 * size.ex_small() / size.small(),
                              color: blackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          );
        }
        return const InternetErrorScreen();
      },
    );
  }

  splitWord(word) {
    List list = (word != null) ? word.split('[#]') : [];
    return list;
  }

  Future<void> imgCount() async {
    var client = http.Client();
    var imgCount = Uri.parse(
        baseUrl + "api/serviceProviderImageGallery/" + widget.rest_ID);

    try {
      var count_response = await client.get(
        imgCount,
      );

      if (count_response.statusCode == 200) {
        var count = json.decode(count_response.body);
        setState(() {
          imgNo = count.length;
        });
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> getData({required String apiUrl}) async {
    var headersList = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(apiUrl);
    var req = http.Request(apiType, url);
    req.headers.addAll(headersList);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    final body = jsonDecode(resBody);
    var data = {
      'Sid': await body["Sid"],
      'Address': await body["Address"],
      'ContactUs': await body["ContactUs"],
      'Website': await body["Website"],
      'GoogleMapLocation': await body["GoogleMapLocation"],
      'Description': await body["Description"],
      'City': await body["City"],
      'GeneralFacilitiy': await body["GeneralFacilitiy"],
      'PopularFacilitiy': await body["PopularFacilitiy"],
      'Services': await body["Services"],
      'min': await body["min"],
      'max': await body["max"],
      'created_at': await body["created_at"],
      'updated_at': await body["updated_at"],
      'FullName': await body["FullName"],
      'Bid': await body["Bid"],
      'categoryName': await body["categoryName"],
    };

    setState(() {
      title = data['FullName'];
      address = data["Address"];
      description = data["Description"];
      category = data["categoryName"];
      sid = data["Sid"];
      contactus = data["ContactUs"];
      website = data["Website"];
      googleMapLocation = data["GoogleMapLocation"];
      city = data["City"];
      generalFacility = data["GeneralFacilitiy"];
      popularFacility = data["PopularFacilitiy"];
      services = data["Services"];
      min = data["min"];
      max = data["max"];
      createdAt = data["created_at"];
      updatedAt = data["updated_at"];
      bid = data["Bid"];
      catrgoryName = data["categoryName"];
      descVisible = true;
    });
  }
}
