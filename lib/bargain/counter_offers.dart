import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ePauna/bloc/bargain/bloc/bargain_bloc.dart';
import '../bargain/colors.dart';
import '../bargain/components/appbar.dart';
import '../bargain/components/buttons.dart';
import 'package:flutter/material.dart';
import '../presentation/views/booking_page/payment_methods.dart';

bool listen = true;

class Counter extends StatefulWidget {
  Function? callback;
  Map<String, dynamic> firstNotification;
  dynamic startDate;
  dynamic endDate;
  int? personCount;
  String? note;
  String? latitude;
  String? longitude;
  String? category;
  String? noOfBed;
  String? rate;
  int? bedQuantity;
  bool? isFromBargain;
  List? notificationList;
  bool flag;
  Counter(
      {super.key,
      this.callback,
      required this.firstNotification,
      this.personCount,
      this.note,
      this.latitude,
      this.endDate,
      this.startDate,
      this.longitude,
      this.category,
      this.noOfBed,
      this.rate,
      this.bedQuantity,
      this.isFromBargain,
      this.notificationList,
      required this.flag});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  // List<AnimationController>? animationController;

  List notifications = [];
  List notificationsIds = [];
  // getNotifications()
  final player = AudioPlayer();

  playNotification() {
    print("play sound");
    player.play(AssetSource('notification.wav'));
  }

  clearNotification() {
    setState(() {
      notifications = [];
      widget.notificationList = [];
    });
    print("The notification was cleared");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    notifications.add(widget.firstNotification);
    // getNotifications();
    //  OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
    //   setState(() {
    //     notifications.add(event.notification);
    //     notificationsIds.add(event.notification.notificationId);
    //   });
    // });
    canProcessMessages == true
        ? () {}
        : FirebaseMessaging.onMessage.listen((RemoteMessage message) {
            print("value is" + canProcessMessages.toString());
            print("Data is in new page 123");
            RemoteNotification? notification = message.notification;
            AndroidNotification? android = message.notification?.android;
            print(message.data);
            setState(() {
              playNotification();
              notifications.add(message.data);
            });
            print(notifications);
          });
    //  setState(() {
    //    canProcessMessages = false;
    //  });
    // controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 30),
    // )..addListener(() {
    //     setState(() {});
    //   });
    //  controller?.reverse(from: 1.0);
  }

  clearCallback() {
    clearNotification();
    widget.callback!();
    setState(() {
      widget.flag = false;
      listen = false;
    });
  }

  deleteRequest(index) {
    setState(() {
      notifications.removeAt(index);
      if (notifications.length == 0) {
        clearNotification();
        widget.callback!();
        setState(() {
          widget.flag = false;
          listen = false;
        });
        Navigator.of(context).pop();
      }
    });

    // OneSignal.shared.removeNotification(notificationsIds[index]);
    // animationController?.removeAt(index);
  }

  @override
  void dispose() {
    clearNotification();
    widget.callback!();
    setState(() {
      widget.flag = false;
      listen = false;
    });
    FirebaseMessaging.instance.unsubscribeFromTopic('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        clearNotification();
        widget.callback!();
        setState(() {
          widget.flag = false;
          listen = false;
        });
        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: PrimaryColors.backgroundcolor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(onpressed: () {
              clearNotification();
              widget.callback!();
              setState(() {
                widget.flag = false;
                listen = false;
              });
              Navigator.pop(context);
            }),
          ),
          body: Container(
            height: 800,
            child: notifications.length == 0
                ? Container(
                    height: 400,
                    color: PrimaryColors.primarywhite,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: Column(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 300,
                            width: width,
                            child: Image.asset(
                              'assets/images/no_booking.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Text(
                          'Loading....',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: notifications.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.linear,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5),
                        margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        color: PrimaryColors.primarywhite,
                        child: Column(
                          children: [
                            //         LinearProgressIndicator(
                            //   value: animationController?[index].value,
                            //   semanticsLabel: 'Linear progress indicator',
                            // ),
                            CounterOffer(
                              indexValue: index,
                              callback: deleteRequest,
                              amount:
                                  notifications[index]['rate']?.toString() ??
                                      'N/A',
                              label: notifications[index]['hotel_name']
                                      ?.toString() ??
                                  'N/A',
                              image: notifications[index]['logo'] ??
                                  'assets/images/hotelimage.jpg'?.toString(),
                              icon: Icons.star,
                              star: notifications[index]['hotel_type']
                                      ?.toString() ??
                                  'N/A',
                              service: notifications[index]['hotel_desc']
                                      ?.toString() ??
                                  'N/A',
                              counterType: notifications[index]['requestType']
                                      ?.toString() ??
                                  'N/A',
                              offer1:
                                  notifications[index]['offer1']?.toString() ??
                                      'N/A',
                              offer2:
                                  notifications[index]['offer2']?.toString() ??
                                      'N/A',
                              offer3:
                                  notifications[index]['offer3']?.toString() ??
                                      'N/A',
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AcceptDecline(
                                    onpressed: () {
                                      //                   clearNotification();
                                      // widget.callback!();
                                      // setState(() {
                                      //   widget.flag =false;
                                      //   listen = false;
                                      // });
                                      print("The index is ");
                                      print(index);
                                      deleteRequest(index);
                                    },
                                    bgcolor: PrimaryColors.primaryred,
                                    label: 'Decline',
                                  ),
                                  const SizedBox(width: 30),
                                  AcceptDecline(
                                    onpressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => PaymentMethods(
                                              sessionBookingName: 'Hotel Surya',
                                              sId: notifications[index]['sid'],
                                              amount: (int.parse(
                                                          notifications[index]
                                                              ['rate']) *
                                                      widget.bedQuantity!)
                                                  .toString(),
                                              sessionBookingId: '123456789',
                                              isFromBargain: true,
                                              rate: notifications[index]['rate']
                                                  ?.toString(),
                                              hotelType: widget.category,
                                              bed_type: widget.noOfBed,
                                              room_quantity:
                                                  widget.bedQuantity.toString(),
                                              checkin_date: widget.startDate,
                                              checkout_date: widget.endDate,
                                              note: widget.note,
                                              no_of_guest:
                                                  widget.personCount.toString(),
                                              clearCallBack: clearCallback)));
                                    },
                                    bgcolor: PrimaryColors.primarygreen,
                                    label: 'Accept',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
          ),
        ),
      ),
    );
  }
}

class CounterOffer extends StatefulWidget {
  int indexValue;
  Function callback;
  final String label;
  final String image;
  final String amount;
  final String star;
  final String service;
  final String counterType;
  final String offer1;
  final String offer2;
  final String offer3;
  final IconData? icon;

  CounterOffer({
    required this.indexValue,
    required this.callback,
    required this.label,
    required this.image,
    required this.amount,
    required this.star,
    required this.service,
    required this.counterType,
    required this.offer1,
    required this.offer2,
    required this.offer3,
    this.icon,
    super.key,
  });

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
        if (controller.value == 0.0) {
          print("finished");
          widget.callback(widget.indexValue);
        }
        setState(() {});
      });
    controller.reverse(from: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: controller.value,
            semanticsLabel: 'Linear progress indicator',
          ),
          Row(
            children: [
              Container(
                  height: widget.counterType == 'counter' ? 90 : 65,
                  width: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/nophoto.jpg',
                      image: widget.image)
                  //Image.asset(widget.image),
                  ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
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
                            "Rs. " + widget.amount,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(widget.icon,
                                    color: Colors.amber, size: 16),
                                Text(
                                  widget.star,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                            Text(
                              '1.1 Km',
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                        Text(
                          widget.service,
                          maxLines: 2,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.grey.shade500),
                        ),
                        widget.counterType == 'counter'
                            ? Text(
                                "Offer 1: " + widget.offer1,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.grey.shade500),
                              )
                            : Container(),
                        widget.counterType == 'counter'
                            ? Text(
                                "Offer 2: " + widget.offer2,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.grey.shade500),
                              )
                            : Container(),
                        widget.counterType == 'counter'
                            ? Text(
                                "Offer 3: " + widget.offer3,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.grey.shade500),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
