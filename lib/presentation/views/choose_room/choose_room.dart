import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ePauna/bargain/colors.dart';
// import 'package:flutter_svg/svg.dart';
import '/bloc/internet_bloc.dart';
import '/data/user_data/data.dart';
import '/presentation/app_data/colors.dart';
import '/presentation/app_data/size.dart';
import '/data/urls/urls.dart';
import '/logic/services/services.dart';
import '/presentation/internet_lost/error_state.dart';
import '/presentation/internet_lost/not_connection.dart';
import '/presentation/views/login_signup/login.dart';
import '../../../bloc/internet_state.dart';
import '../../../data/models/select_room_model.dart';
import '../booking_page/booking.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChooseRoom extends StatefulWidget {
  final serviceId;
  final businessId;
  const ChooseRoom({super.key, this.serviceId, required this.businessId});

  @override
  State<ChooseRoom> createState() => _ChooseRoomState(this.serviceId);
}

class _ChooseRoomState extends State<ChooseRoom> {
  var serviceId;
  _ChooseRoomState(this.serviceId);
  DateTime checkIn =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime checkout = DateTime.now().add(const Duration(days: 1));

  int quantity = 1;

  List<SelectRoom> room = [];
  bool showRooms = false;
  SelectRoomServices services = SelectRoomServices();
  @override
  void initState() {
    print("the service id is");
    print(serviceId);
    services.getRooms(apiUrl: selectRoomApi(restID: serviceId)).then((value) {
      setState(() {
        room = value!;
        showRooms = true;
      });
    });
    super.initState();
  }

  DateTime? fromYear;
  DateTime? nextYear;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    AppSize size = AppSize(context: context);
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
              centerTitle: true,
              title: widget.businessId == '1'
                  ? Text(
                      'Select Room',
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  : Text(
                      'Select Service',
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),

              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: blackColor,
                  )),
              // title: Padding(
              //   padding: EdgeInsets.only(top: 3, bottom: 3),
              //   child: IntrinsicWidth(
              //     child: Image(
              //       height: size.large() / 10,
              //       image: AssetImage('assets/pauna1-1.png'),
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              // ),
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: SizedBox(
                height: double.infinity,
                child: Visibility(
                  visible: showRooms,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: (room.isEmpty)
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
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Continue Booking'))
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: room.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: double.infinity,
                              child: Card(
                                elevation: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(3 * size.small()),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        size.small() * 10,
                                        size.small() * 10,
                                        size.small() * 10,
                                        size.ex_small() * 10),
                                    child: Stack(children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 250 * size.small(),
                                                    child: Text(
                                                      room[index].serviceTitle!,
                                                      style: TextStyle(
                                                        fontSize: 17 *
                                                            size.ex_small(),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: size.ex_small() * 8,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: size.ex_small() * 7,
                                          ),
                                          SizedBox(
                                            width: 80 * size.small(),
                                            child: Text(
                                              'Services :',
                                              style: TextStyle(
                                                fontSize: 14 * size.ex_small(),
                                                fontWeight: FontWeight.w600,
                                                height: 1.5 *
                                                    size.ex_small() /
                                                    size.small(),
                                                color: blackColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: size.large() / 2,
                                            child: Text(
                                              '${(room[index].serviceAndFacility!).replaceAll('[#]', ', ')}',
                                              style: TextStyle(
                                                fontSize: 11 * size.ex_small(),
                                                fontWeight: FontWeight.w500,
                                                letterSpacing:
                                                    0.22 * size.small(),
                                                color: blackColor,
                                              ),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: size.ex_small() * 10,
                                          // ),
                                          // SizedBox(
                                          //   width: 124 * size.small(),
                                          //   child: Text(
                                          //     'Status Currently :',
                                          //     style: TextStyle(
                                          //       fontSize: 14 * size.ex_small(),
                                          //       fontWeight: FontWeight.w600,
                                          //       height: 1.5 *
                                          //           size.ex_small() /
                                          //           size.small(),
                                          //       color: const Color(0xff276bae),
                                          //     ),
                                          //   ),
                                          // ),
                                          // SizedBox(
                                          //   height: size.ex_small() * 5,
                                          // ),
                                          // Container(
                                          //   color: (room[index].status != 0)
                                          //       ? successColor
                                          //       : errorColor,
                                          //   child: Padding(
                                          //     padding: EdgeInsets.fromLTRB(
                                          //         size.ex_small() * 7,
                                          //         size.ex_small() * 2,
                                          //         size.ex_small() * 7,
                                          //         size.ex_small() * 2),
                                          //     child: Text(
                                          //       (room[index].status != 0)
                                          //           ? 'Available'
                                          //           : 'Unavaible',
                                          //       style: TextStyle(
                                          //         fontSize:
                                          //             10 * size.ex_small(),
                                          //         fontWeight: FontWeight.w500,
                                          //         height: 1.5 *
                                          //             size.ex_small() /
                                          //             size.small(),
                                          //         color: whiteColor,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: size.ex_small() * 7,
                                          ),
                                          SizedBox(
                                            width: 71 * size.small(),
                                            height: 21 * size.small(),
                                            child: Text(
                                              'NRP. ${room[index].serviceRate}',
                                              style: TextStyle(
                                                fontSize: 14 * size.ex_small(),
                                                fontWeight: FontWeight.w600,
                                                height: 1.5 *
                                                    size.ex_small() /
                                                    size.small(),
                                                color: blackColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.ex_small() * 2,
                                          ),
                                          Text(
                                            widget.businessId == '1'
                                                ? 'Price Per Night'
                                                : 'Price Per Service',
                                            style: TextStyle(
                                              fontSize: 11 * size.ex_small(),
                                              fontWeight: FontWeight.w500,
                                              height: 1.5 *
                                                  size.ex_small() /
                                                  size.small(),
                                              letterSpacing:
                                                  0.22 * size.small(),
                                              color: blackColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.ex_small() * 7,
                                          ),
                                          Row(
                                            children: [
                                              // SvgPicture.asset(
                                              //   "assets/check-line.svg",
                                              //   color: const Color(0xff505356),
                                              //   width: size.ex_small() * 15,
                                              // ),
                                              // SizedBox(
                                              //   width: 3 * size.ex_small(),
                                              // ),
                                              SizedBox(
                                                width: 136 * size.small(),
                                                height: 17 * size.small(),
                                                child: Text(
                                                  'Includes taxes and fees',
                                                  style: TextStyle(
                                                    fontSize:
                                                        11 * size.ex_small(),
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.5 *
                                                        size.ex_small() /
                                                        size.small(),
                                                    letterSpacing:
                                                        0.22 * size.small(),
                                                    color: blackColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: size.ex_small() * 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              quantity = 1;
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  //                                                                          setState(() {
                                                  pickedStartDate =
                                                      DateTime.now();
                                                  pickedEndDate = DateTime.now()
                                                      .add(Duration(days: 1));
                                                  fromYear = DateTime.now();
                                                  // });
                                                  return Container(
                                                    width: double.infinity,
                                                    child: AlertDialog(
                                                      scrollable: true,
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '${room[index].serviceTitle!}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    blackColor),
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    mainColor,
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: IconButton(
                                                                color:
                                                                    whiteColor,
                                                                onPressed: () {
                                                                  //                                                 setState(() {
                                                                  //   pickedStartDate = DateTime.now();
                                                                  //   pickedEndDate = DateTime.now().add(Duration(days: 1));
                                                                  //   fromYear = DateTime.now();
                                                                  // });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: Icon(Icons
                                                                    .close)),
                                                          )
                                                        ],
                                                      ),
                                                      content: Container(
                                                        width: size.large(),
                                                        child: StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              StateSetter
                                                                  setState) {
                                                            return Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        "Quantity :"),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              color: const Color(
                                                                                  0xff9F9F9F),
                                                                              width:
                                                                                  1),
                                                                          borderRadius: const BorderRadius
                                                                              .all(
                                                                              Radius.circular(10))),
                                                                      width: 80,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            // Text("${(room[index].selectRoomIn != null && room[index].out != null) ? room[index].selectRoomIn! - room[index].out! : 0}"),
                                                                            Text("$quantity"),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              color: const Color(
                                                                                  0xff9F9F9F),
                                                                              width:
                                                                                  1),
                                                                          borderRadius: const BorderRadius
                                                                              .all(
                                                                              Radius.circular(10))),
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          Center(
                                                                        child: IconButton(
                                                                            onPressed: () {
                                                                              quantity < ((room[index].selectRoomIn != null && room[index].out != null) ? room[index].selectRoomIn! - room[index].out! : 0) ? quantity++ : quantity;
                                                                              setState(() {});
                                                                            },
                                                                            icon: Icon(
                                                                              Icons.add,
                                                                              color: PrimaryColors.primaryblue,
                                                                            )),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              color: const Color(
                                                                                  0xff9F9F9F),
                                                                              width:
                                                                                  1),
                                                                          borderRadius: const BorderRadius
                                                                              .all(
                                                                              Radius.circular(10))),
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          Center(
                                                                        child: IconButton(
                                                                            onPressed: () {
                                                                              (quantity > 1) ? quantity-- : quantity;
                                                                              setState(() {});
                                                                            },
                                                                            icon: Icon(
                                                                              Icons.remove,
                                                                              color: PrimaryColors.primaryblue,
                                                                            )),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Text(
                                                                  "Check-In / Check-Out :",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color:
                                                                          blackColor),
                                                                ),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          fromYear = await showDatePicker(
                                                                              context: context,
                                                                              initialDate: pickedStartDate,
                                                                              firstDate: pickedStartDate,
                                                                              lastDate: DateTime(2300));
                                                                          if (fromYear !=
                                                                              null) {
                                                                            setState(() {
                                                                              pickedStartDate = fromYear!;
                                                                              pickedEndDate = fromYear!.add(Duration(days: 1));
                                                                            });
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(color: const Color(0xff9F9F9F), width: 1),
                                                                              borderRadius: const BorderRadius.all(Radius.circular(7))),
                                                                          padding:
                                                                              EdgeInsets.all(8),
                                                                          child:
                                                                              Text(
                                                                            '${pickedStartDate.year}-${(pickedStartDate.month > 9) ? pickedStartDate.month : '0${pickedStartDate.month}'}-${(pickedStartDate.day > 9) ? pickedStartDate.day : '0${pickedStartDate.day}'}',
                                                                            style:
                                                                                TextStyle(fontSize: 12),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    (widget.businessId.toString() ==
                                                                            '1')
                                                                        ? Text(
                                                                            "To",
                                                                            style:
                                                                                TextStyle(color: Color(0xff737272)),
                                                                          )
                                                                        : SizedBox
                                                                            .shrink(),
                                                                    SizedBox(
                                                                      width: 9,
                                                                    ),
                                                                    (widget.businessId.toString() ==
                                                                            '1')
                                                                        ? Expanded(
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () async {
                                                                                DateTime? checkOut;
                                                                                if (fromYear == null) {
                                                                                  checkOut = await showDatePicker(context: context, initialDate: pickedEndDate, firstDate: pickedEndDate, lastDate: DateTime(2300));
                                                                                } else {
                                                                                  checkOut = await showDatePicker(context: context, initialDate: pickedEndDate, firstDate: pickedEndDate, lastDate: DateTime(2300));
                                                                                }

                                                                                if (checkOut != null) {
                                                                                  setState(() {
                                                                                    pickedEndDate = checkOut!;
                                                                                  });
                                                                                }
                                                                              },
                                                                              child: Container(
                                                                                padding: EdgeInsets.all(8),
                                                                                decoration: BoxDecoration(border: Border.all(color: const Color(0xff9F9F9F), width: 1), borderRadius: const BorderRadius.all(Radius.circular(7))),
                                                                                child: Text(
                                                                                  '${pickedEndDate.year}-${(pickedEndDate.month > 9) ? pickedEndDate.month : '0${pickedEndDate.month}'}-${(pickedEndDate.day > 9) ? pickedEndDate.day : '0${pickedEndDate.day}'}',
                                                                                  style: TextStyle(fontSize: 12),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : SizedBox
                                                                            .shrink(),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      size.ex_small() *
                                                                          10,
                                                                ),
                                                                Container(
                                                                  decoration: const BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10))),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        MaterialButton(
                                                                      color:
                                                                          mainColor,
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        (user_id !=
                                                                                null)
                                                                            ? Navigator.of(context).push(MaterialPageRoute(builder:
                                                                                (context) {
                                                                                return booking(
                                                                                  hotelName: room[index].categoryName,
                                                                                  imageUrl: baseUrl + "ServiceImages/" + room[index].imageName!,
                                                                                  ServiceRate: room[index].serviceRate,
                                                                                  ServiceTitle: room[index].serviceTitle,
                                                                                  category: room[index].categoryName,
                                                                                  checkInDate: pickedStartDate,
                                                                                  checkOutDate: pickedEndDate,
                                                                                  days: quantity,
                                                                                  service_Id: serviceId,
                                                                                  serviceCategoryId: room[index].serviceId,
                                                                                  businessId: widget.businessId,
                                                                                );
                                                                              }))
                                                                            : Navigator.of(context).push(MaterialPageRoute(builder:
                                                                                (context) {
                                                                                return Login(
                                                                                  beforePayment: true,
                                                                                );
                                                                              }));
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Book",
                                                                        style: TextStyle(
                                                                            color:
                                                                                whiteColor,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5 * size.small()),
                                                border: Border.all(
                                                    color: mainColor),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0,
                                                      10 * size.ex_small(),
                                                      0,
                                                      10 * size.ex_small()),
                                                  child: Text(
                                                    // 'Book Now',
                                                    'Book Now',
                                                    style: TextStyle(
                                                      fontSize:
                                                          18 * size.ex_small(),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.5 *
                                                          size.ex_small() /
                                                          size.small(),
                                                      color: mainColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.large() * 0.09,
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: SizedBox(
                                            width: 120 * size.small(),
                                            height: size.ex_small() * 100,
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/nophoto.jpg',
                                              image: baseUrl +
                                                  "ServiceImages/" +
                                                  room[index].imageName!,
                                              fit: BoxFit.cover,
                                            )),
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                            );
                          }),
                ),
              ),
            ),
          );
        }
        return const InternetErrorScreen();
      },
    );
  }
}
