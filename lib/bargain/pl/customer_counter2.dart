// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/app_data/colors.dart';
import '../../presentation/app_data/size.dart';
import '../colors.dart';
import '../components/buttons.dart';

class CustomerCounterPL2 extends StatefulWidget {
  String hotelName;
  CustomerCounterPL2({super.key,
  required this.hotelName});

  @override
  State<CustomerCounterPL2> createState() => _CustomerCounterPL2State();
}

class _CustomerCounterPL2State extends State<CustomerCounterPL2>
    with TickerProviderStateMixin {
  String YourPlayerId = '';
  String senderPlayerId = '';

  DeclineOffer(String customerIdValue) async {
    var status = await OneSignal.shared.getDeviceState();
    String? playerId = status!.userId;
    print(playerId);
    var notification = OSCreateNotification(
      playerIds: [customerIdValue!],
      content: "The offer rate was declined",
      heading: widget.hotelName,
    );
    await OneSignal.shared.postNotification(notification);
  }

  AcceptOffer(String customerIdValue, String rate) async {
    var status = await OneSignal.shared.getDeviceState();
    String? playerId = status!.userId;
    print(playerId);
    var notification = OSCreateNotification(
        playerIds: [customerIdValue!],
        content: "The offer rate was accepted",
        heading: widget.hotelName,
        additionalData: {
          "requestType": "accept",
          "rate": rate,
          "offer1": "",
          "offer2": "",
          "offer3": "",
          "distance": "1.7km",
          "hotel_name": '',
          "hotel_type": "5 star Hotel",
          "hotel_desc":
              "Free Breakfast, Free Ride, Sight Seeing, Travel & Trekking"
        });
    await OneSignal.shared.postNotification(notification);
  }

  deleteRequest(index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  String title = 'loading';
  String body = 'loading';
  //String hotelName = '';
  List<OSNotification> notifications = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getHotelData();
    getUserPlayerId();
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      setState(() {
        notifications.add(event.notification);
      });
    });
  }
  // getHotelData()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? sid  = prefs.getString('sid');
  //   print("the sid value is");
  //   print(sid);
  //   ServiceProvideDetailRepository repo = ServiceProvideDetailRepository();
  //   hotelData = await repo.getServiceProvideDetail(sid!);
  //   setState(() {
  //     hotelName = hotelData!.fullName.toString();
  //   });
    
  // }

  getUserPlayerId() async {
    var status = await OneSignal.shared.getDeviceState();
    String? playerId = status!.userId;
    setState(() {
      YourPlayerId = playerId!;
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    AppSize size = AppSize(context: context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: PrimaryColors.backgroundcolor,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: PrimaryColors.primarywhite,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            leading: null,
            actions: [
              
            ]),
        body:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: PrimaryColors.backgroundcolor,
                    height: 3,
                  ),
                  Container(
                    color: PrimaryColors.primarywhite,
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.person_outline,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                widget.hotelName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: PrimaryColors.primaryblue,
                                  fontSize: 15 * size.ex_small(),
                                  fontWeight: FontWeight.w500,
                                  height: 1.5 * size.ex_small() / size.small(),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 10,
                  ),
                  Container(
                    color: PrimaryColors.backgroundcolor,
                    height: 3,
                  ),
                  Container(
                    color: Colors.white,
                    height: 10,
                  ),
                 notifications.length == 0
            ? Container(
                    height: 400,
                    color: PrimaryColors.primarywhite,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: Column(
                      children: [
                        Container(
                          height: 300,
                          width: width,
                          child: Image.asset('assets/images/no_booking.png'),
                        ),
                        Text(
                          'No Bookings yet',
                          style: TextStyle(
                            fontSize: size.large() / 20,
                            fontWeight: FontWeight.w600,
                            height: 1.5 * size.small() / size.small(),
                          ),
                        )
                      ],
                    ),
                  ):
                      SingleChildScrollView(
                child: ListView.builder(
                  itemCount: notifications.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      margin: const EdgeInsets.all(10),
                      color: PrimaryColors.primarywhite,
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.linear,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        // width: 600,
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              // Text("Player Id is"),
                              // SelectableText(YourPlayerId),
                              Expanded(
                                flex: 3,
                                child: CounterOffer(
                                  label: notifications[index]
                                          .additionalData?['name']
                                          ?.toString() ??
                                      'N/A',
                                  image: 'assets/images/profile.jpg',
                                  amount: notifications[index]
                                          .additionalData?['rate']
                                          ?.toString() ??
                                      'N/A',
                                  Checked_in: notifications[index]
                                          .additionalData?['startDate']
                                          ?.toString() ??
                                      'N/A',
                                  Checked_out: notifications[index]
                                          .additionalData?['endDate']
                                          ?.toString() ??
                                      'N/A',
                                  roomquantity: notifications[index]
                                          .additionalData?['bedQuantity']
                                          ?.toString() ??
                                      'N/A',
                                  noofguest: notifications[index]
                                          .additionalData?['personCount']
                                          ?.toString() ??
                                      'N/A',
                                  distance: notifications[index]
                                          .additionalData?['distance']
                                          ?.toString() ??
                                      'N/A',
                                  customerPlayerId: notifications[index]
                                          .additionalData?['customerPlayerId']
                                          ?.toString() ??
                                      'N/A',
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AcceptDecline(
                                        onpressed: () {
                                          deleteRequest(index);
                                        },
                                        bgcolor: PrimaryColors.primaryred,
                                        label: 'Decline',
                                      ),
                                      const SizedBox(width: 10),
                                      
                                      const SizedBox(width: 10),
                                      AcceptDecline(
                                        onpressed: () {
                                          String customerId =
                                              notifications[index]
                                                      .additionalData?[
                                                          'customerPlayerId']
                                                      ?.toString() ??
                                                  'N/A';
                                          String rateValue =
                                              notifications[index]
                                                      .additionalData?['rate']
                                                      ?.toString() ??
                                                  'N/A';
                                          AcceptOffer(customerId, rateValue);
                                        },
                                        bgcolor: PrimaryColors.primarygreen,
                                        label: 'Accept',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
        
                ],
              ),
        ),
    );
  }
}

class CounterOffer extends StatefulWidget {
  final String label;
  final String image;
  final String amount;
  final String Checked_in;
  final String Checked_out;
  final String? roomquantity;
  final String? noofguest;
  final String? distance;
  final String? customerPlayerId;

  const CounterOffer(
      {required this.label,
      required this.image,
      required this.amount,
      required this.Checked_in,
      required this.Checked_out,
      this.roomquantity,
      this.noofguest,
      this.customerPlayerId,
      super.key,
      this.distance});

  @override
  State<CounterOffer> createState() => _CounterOfferState();
}

class _CounterOfferState extends State<CounterOffer>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..addListener(() {
        setState(() {});
      });
    controller.reverse(from: 1.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Image.asset(widget.image),
        ),
        // ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: controller.value,
                semanticsLabel: 'Linear progress indicator',
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      "Rs." + widget.amount,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: PrimaryColors.primaryblue,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Checked In:  ${widget.Checked_in.toString().split(' ')[0]}',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.grey.shade500),
                        ),
                        Text('${widget.distance} ',
                            style: const TextStyle(
                                fontFamily: 'Poppins', color: Colors.green))
                      ],
                    ),
                    Text(
                      'Checked Out:  ${widget.Checked_out.toString().split(' ')[0]}',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.grey.shade500),
                    ),
                    Text(
                      'Room Quantity: ${widget.roomquantity} ',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.grey.shade500),
                    ),
                    Text(
                      'No of Guest: ${widget.noofguest} ',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.grey.shade500),
                    ),
                    // SelectableText(
                    //   'Customer Player Id: ${widget.customerPlayerId} ',
                    //   style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       fontSize: 12,
                    //       color: Colors.grey.shade500),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
