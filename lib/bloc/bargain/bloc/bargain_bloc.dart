import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

import 'package:ePauna/bargain/counter_offers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/PlayerIdModel.dart';
import '../../../data/repository/bargain_repository/getServiceProviderPlayerId.dart';
part 'bargain_event.dart';
part 'bargain_state.dart';

bool canProcessMessages = true;
final player = AudioPlayer();
playNotification() {
  print("play sound");
  player.play(AssetSource('notification.wav'));
}

class BargainBloc extends Bloc<BargainEvent, BargainState> {
  BargainBloc() : super(BargainInitial()) {
    String? category;
    String? noOfBed;
    double startRange = 0;
    double endRange = 100;
    String? location;
    String? rate;
    int? bedQuantity;
    String? startDate;
    String? endDate;
    bool? startDateSelected;
    bool? endDateSelected;
    int? personCount;
    String? note;
    String? latitude;
    String? longitude;
    List<String> AllPlayerId = [];
    List notifications = [];
    double distance = 0.0;
    bool goToAnotherPage = true;
    String? pickUpoverAllPlaceName;
    String? pickUplatitudeValue;
    String? pickUplongitudeValue;
    bool? hourlyBargain;
    int? hours;

    sendRoomRequest(BuildContext context) async {
      username() async {
        String username = '';
        SharedPreferences prefs = await SharedPreferences.getInstance();
        username = await prefs.getString("username")!;
        String name = username;
        return name;
      }

      String name = await username();
      // var status = await OneSignal.shared.getDeviceState();
      // String? playerId = status!.userId;
      // print("Your player id is");
      // print(playerId);
      String token = '';
      await FirebaseMessaging.instance.requestPermission().then((value) {
        Platform.isIOS
            ? FirebaseMessaging.instance.getAPNSToken().then((value) async {
                print('Token $value');
                token = value.toString();
                try {
                  for (int i = 0; i < AllPlayerId.length; i++) {
                    double kmdistance = distance * 0.621371;
                    String fixedDistance = kmdistance.toStringAsFixed(2);
                    emit(BargainLoadingState());
                    var data = {
                      'to': AllPlayerId[i],
                      'priority': 'high',
                      'data': {
                        "name": "$name",
                        "distance": fixedDistance.toString() + "km",
                        "category": category!,
                        "noOfBed": noOfBed!,
                        "startRange": startRange.toString(),
                        "endRange": endRange.toString(),
                        "location": location.toString(),
                        "rate": rate.toString(),
                        "bedQuantity": bedQuantity.toString(),
                        "startDate": startDate.toString(),
                        "endDate": endDate.toString(),
                        "personCount": personCount.toString(),
                        "note": note.toString(),
                        "customerPlayerId": token.toString(),
                        "pickUpLocation": pickUpoverAllPlaceName.toString(),
                        "pickUpLat": pickUplatitudeValue.toString(),
                        "pickUpLong": pickUplongitudeValue.toString(),
                        "hourlyBargain": "false"
                      }
                    };
                    print(data);
                    print("posting room rewuest Data to");
                    print(AllPlayerId[i]);
                    print(AllPlayerId);
                    await http.post(
                        Uri.parse('https://fcm.googleapis.com/fcm/send'),
                        body: jsonEncode(data),
                        headers: {
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization':
                              'key=AAAAWv03dRM:APA91bHYXhX_D8NeT6BxPmnmGVlzXVIH5-5B3Lk2Q0E8dpwaC186PtExVwwUI_YyLi321v4BUKNfIuA2PpfjuEZqW2mq6MAFXHH2aIPvi-6Na7BtXyfP0dmOoPCPC9VwTmhl07dPSiIu'
                        });
                  }
                } catch (e) {
                  print("Error Occured");
                }
              })
            : FirebaseMessaging.instance.getToken().then((value) async {
                print('Token $value');
                token = value.toString();
                try {
                  for (int i = 0; i < AllPlayerId.length; i++) {
                    double kmdistance = distance * 0.621371;
                    String fixedDistance = kmdistance.toStringAsFixed(2);
                    emit(BargainLoadingState());
                    var data = {
                      'to': AllPlayerId[i],
                      'priority': 'high',
                      'data': {
                        "name": "$name",
                        "distance": fixedDistance.toString() + "km",
                        "category": category!,
                        "noOfBed": noOfBed!,
                        "startRange": startRange.toString(),
                        "endRange": endRange.toString(),
                        "location": location.toString(),
                        "rate": rate.toString(),
                        "bedQuantity": bedQuantity.toString(),
                        "startDate": startDate.toString(),
                        "endDate": endDate.toString(),
                        "personCount": personCount.toString(),
                        "note": note.toString(),
                        "customerPlayerId": token.toString(),
                        "pickUpLocation": pickUpoverAllPlaceName.toString(),
                        "pickUpLat": pickUplatitudeValue.toString(),
                        "pickUpLong": pickUplongitudeValue.toString(),
                        "hourlyBargain": "false"
                      }
                    };
                    print(data);
                    print("posting room rewuest Data to");
                    print(AllPlayerId[i]);
                    print(AllPlayerId);
                    await http.post(
                        Uri.parse('https://fcm.googleapis.com/fcm/send'),
                        body: jsonEncode(data),
                        headers: {
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization':
                              'key=AAAAWv03dRM:APA91bHYXhX_D8NeT6BxPmnmGVlzXVIH5-5B3Lk2Q0E8dpwaC186PtExVwwUI_YyLi321v4BUKNfIuA2PpfjuEZqW2mq6MAFXHH2aIPvi-6Na7BtXyfP0dmOoPCPC9VwTmhl07dPSiIu'
                        });
                  }
                } catch (e) {
                  print("Error Occured");
                }
              });
      });
      // print("The token value is"+token.toString());
      // print("the token is");
      // print(token);

      callback() {
        notifications = [];
        notifications.length = 0;
        print(notifications);
        print(notifications.length);
        print("cleared notification");
        canProcessMessages = !canProcessMessages;
      }

      print("details$notifications ${notifications.length} ");

      notifications.length == 0
          ? FirebaseMessaging.onMessage.listen((RemoteMessage message) {
              print('fetch suru bha');
              // emit(BargainInitial());
              if (canProcessMessages) {
                print("Data is in new page 111");
                print("the can Process Message is " +
                    canProcessMessages.toString());

                print(message.data);
                //  BlocProvider.of<BargainBloc>(context).add(CancelTimerEvent(timer));
                notifications.add(message.data);
                goToAnotherPage = false;
                print("the notification length is");
                print(notifications.length);

                playNotification();
                if (notifications.length == 1) {
                  notifications = [];

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Counter(
                              callback: callback,
                              firstNotification: message.data,
                              category: category,
                              noOfBed: noOfBed,
                              bedQuantity: bedQuantity,
                              startDate: startDate,
                              endDate: endDate,
                              personCount: personCount,
                              note: note,
                              notificationList: notifications,
                              flag: canProcessMessages)));
                  canProcessMessages = false;
                } else {
                  print("navigation error");
                }
                ;
              }

              // print("the notification is");
              // print(notifications);
            })
          : () {};
    }

    sendHourlyRoomRequest(BuildContext context) async {
      username() async {
        String username = '';
        SharedPreferences prefs = await SharedPreferences.getInstance();
        username = await prefs.getString("username")!;
        String name = username;
        return name;
      }

      String name = await username();
      String token;
      await FirebaseMessaging.instance.requestPermission().then((value) {
        Platform.isIOS
            ? FirebaseMessaging.instance.getAPNSToken().then((value) async {
                token = value.toString();
                try {
                  for (int i = 0; i < AllPlayerId.length; i++) {
                    double kmdistance = distance * 0.621371;
                    String fixedDistance = kmdistance.toStringAsFixed(2);
                    emit(BargainLoadingState());
                    var data = {
                      'to': AllPlayerId[i],
                      'priority': 'high',
                      'data': {
                        "name": "$name",
                        "distance": fixedDistance.toString() + "km",
                        "category": category!,
                        "noOfBed": noOfBed!,
                        "startRange": startRange.toString(),
                        "endRange": endRange.toString(),
                        "location": location.toString(),
                        "bedQuantity": bedQuantity.toString(),
                        "personCount": personCount.toString(),
                        "customerPlayerId": token.toString(),
                        "hourlyBargain": "true",
                        'hours': hours.toString(),
                      }
                    };
                    print(data);
                    print("posting Data to");
                    print(AllPlayerId[i]);
                    print(AllPlayerId);
                    await http.post(
                        Uri.parse('https://fcm.googleapis.com/fcm/send'),
                        body: jsonEncode(data),
                        headers: {
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization':
                              'key=AAAAWv03dRM:APA91bHYXhX_D8NeT6BxPmnmGVlzXVIH5-5B3Lk2Q0E8dpwaC186PtExVwwUI_YyLi321v4BUKNfIuA2PpfjuEZqW2mq6MAFXHH2aIPvi-6Na7BtXyfP0dmOoPCPC9VwTmhl07dPSiIu'
                        });
                  }
                } catch (e) {
                  print("Error Occured");
                }
              })
            : FirebaseMessaging.instance.getToken().then((value) async {
                token = value.toString();
                try {
                  for (int i = 0; i < AllPlayerId.length; i++) {
                    double kmdistance = distance * 0.621371;
                    String fixedDistance = kmdistance.toStringAsFixed(2);
                    emit(BargainLoadingState());
                    var data = {
                      'to': AllPlayerId[i],
                      'priority': 'high',
                      'data': {
                        "name": "$name",
                        "distance": fixedDistance.toString() + "km",
                        "category": category!,
                        "noOfBed": noOfBed!,
                        "startRange": startRange.toString(),
                        "endRange": endRange.toString(),
                        "location": location.toString(),
                        "bedQuantity": bedQuantity.toString(),
                        "personCount": personCount.toString(),
                        "customerPlayerId": token.toString(),
                        "hourlyBargain": "true",
                        'hours': hours.toString(),
                      }
                    };
                    print(data);
                    print("posting Data to");
                    print(AllPlayerId[i]);
                    print(AllPlayerId);
                    await http.post(
                        Uri.parse('https://fcm.googleapis.com/fcm/send'),
                        body: jsonEncode(data),
                        headers: {
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization':
                              'key=AAAAWv03dRM:APA91bHYXhX_D8NeT6BxPmnmGVlzXVIH5-5B3Lk2Q0E8dpwaC186PtExVwwUI_YyLi321v4BUKNfIuA2PpfjuEZqW2mq6MAFXHH2aIPvi-6Na7BtXyfP0dmOoPCPC9VwTmhl07dPSiIu'
                        });
                  }
                } catch (e) {
                  print("Error Occured");
                }
              });
      });

      callback() {
        notifications = [];
        notifications.length = 0;
        print(notifications);
        print(notifications.length);
        print("cleared notification");
        canProcessMessages = true;
      }

      print("details$notifications ${notifications.length} ");
      notifications.length == 0
          ? FirebaseMessaging.onMessage.listen((RemoteMessage message) {
              // emit(BargainInitial());
              if (canProcessMessages) {
                print("Data is in new page 111");
                RemoteNotification? notification = message.notification;
                AndroidNotification? android = message.notification?.android;
                print(message.data);
                //  BlocProvider.of<BargainBloc>(context).add(CancelTimerEvent(timer));
                notifications.add(message.data);
                goToAnotherPage = false;
                print("the notification length is");
                print(notifications.length);
                playNotification();
                notifications.length == 1
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Counter(
                                  callback: callback,
                                  firstNotification: message.data,
                                  category: category,
                                  noOfBed: noOfBed,
                                  bedQuantity: bedQuantity,
                                  startDate: startDate,
                                  endDate: endDate,
                                  personCount: personCount,
                                  note: note,
                                  flag: canProcessMessages,
                                )))
                    : () {
                        print("navigation error");
                      };
                // notifications =[];
                canProcessMessages = false;
              }

              // print("the notification is");
              // print(notifications);
            })
          : () {};
    }

    on<BargainEvent>((event, emit) {
      emit(BargainState());
    });
    on<CancelTimerEvent>((event, emit) {
      event.timer.cancel();
    });
    on<BargainNoDataEvent>((event, emit) {
      emit(BargainNoDataState());
    });
    on<getHotelCategory>((event, emit) {
      if (event.index == 0) {
        category = "Normal";
      }
      if (event.index == 1) {
        category = "Budget";
      }
      if (event.index == 2) {
        category = "Star";
      }
    });
    on<getNoOfBed>((event, emit) {
      if (event.index == 0) {
        noOfBed = "Single Bed";
      }
      if (event.index == 1) {
        noOfBed = "Double Bed";
      }
      if (event.index == 2) {
        noOfBed = "Triple Bed";
      }
    });
    on<getRange>((event, emit) {
      startRange = event.start;
      endRange = event.end;
    });
    on<getAdditionalData>((event, emit) {
      location = event.location;
      rate = event.rate;
      bedQuantity = event.bedQuantity;
      startDate = event.startDate;
      endDate = event.endDate;
      startDateSelected = event.startDateSelected;
      endDateSelected = event.endDateSelected;
      personCount = event.personCount;
      note = event.note;
      latitude = event.latitude;
      longitude = event.longitude;
      pickUpoverAllPlaceName = event.pickUpoverAllPlaceName;
      pickUplatitudeValue = event.pickUplatitudeValue;
      pickUplongitudeValue = event.pickUplongitudeValue;
      hourlyBargain = event.hourlyBargain;
      hours = event.hourCount;
      print("data added");
    });

    on<sendData>((event, emit) async {
      if (location == '') {
        print("Location Error");
        emit(BargainErrorState("Location Error"));
      } else if (rate == '') {
        print("No rate error");
        emit(BargainErrorState("Rate Error"));
      } else if (startDateSelected == false) {
        print("Start Date error");
        emit(BargainErrorState("Start Date Error"));
      } else if (endDateSelected == false) {
        print("End Date error");
        emit(BargainErrorState("End Date Error"));
      } else {
        print(latitude);
        print(longitude);
        getServiceProviderPlayerIdRepository repo =
            new getServiceProviderPlayerIdRepository();
        PlayerIdModel playerIdModel = await repo.getServiceProviderPlayerId(
            latitude.toString(), longitude.toString());
        double startRaangeInMiles = startRange * 0.621371;
        double endRangeInMiles = endRange * 0.621371;
        print(startRaangeInMiles);
        print(endRangeInMiles);
        AllPlayerId = [];
        for (int i = 0;
            i < playerIdModel.serviceProviderPlayerIdList!.length;
            i++) {
          print(playerIdModel.serviceProviderPlayerIdList?[i].playerId);
          String onePlayerId =
              playerIdModel.serviceProviderPlayerIdList![i].playerId.toString();
          distance =
              playerIdModel.serviceProviderPlayerIdList![i].distance as double;

          if (onePlayerId == 'null') {
          } else {
            if (distance > startRaangeInMiles && distance < endRangeInMiles) {
              AllPlayerId.add(onePlayerId);
            }
          }
          print(AllPlayerId);
        }
        print("The hourly Bargain is" + hourlyBargain.toString());
        if (hourlyBargain == true) {
          sendHourlyRoomRequest(event.context);
        } else {
          sendRoomRequest(event.context);
        }
      }
    });
  }
}
