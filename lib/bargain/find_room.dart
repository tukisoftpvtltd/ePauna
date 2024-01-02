import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ePauna/bargain/customeLoader.dart';
import 'package:ePauna/presentation/app_data/colors.dart';
import '../bargain/colors.dart';
import 'package:flutter/material.dart';
import '../bargain/components/buttons.dart';
import '../bloc/bargain/bloc/bargain_bloc.dart';
import '../presentation/views/utlis/utils.dart';
import 'MapPage.dart';

// ignore: must_be_immutable
class FindRoom extends StatefulWidget {
  const FindRoom({super.key});

  @override
  State<FindRoom> createState() => _FindRoomState();
}

class _FindRoomState extends State<FindRoom> with TickerProviderStateMixin {
  String locationName = 'Set Your Location';
  String overAllPlaceName = '';
  String placeName = '';
  String latitudeValue = '';
  String longitudeValue = '';
  int hoursValue = 1;

  SetLatLongAndPlaceName(double latitude, double longitude,
      String locationNameValue, String placeNameValue) {
    print("latitude: $latitude");
    print("latitude: $longitude");
    setState(() {
      locationName = locationNameValue;
      placeName = placeNameValue;
      overAllPlaceName = locationName + ',' + placeName;
      latitudeValue = latitude.toString();
      longitudeValue = longitude.toString();
    });
  }

  String pickUplocationName = 'Set Your Location';
  String pickUpoverAllPlaceName = '';
  String pickUpplaceName = '';
  String pickUplatitudeValue = '';
  String pickUplongitudeValue = '';

  SetPickUpLatLongAndPlaceName(double latitude, double longitude,
      String locationNameValue, String placeNameValue) {
    print('Pick Up call back');
    print("latitude: $latitude");
    print("latitude: $longitude");
    setState(() {
      pickUplocationName = locationNameValue;
      pickUpplaceName = placeNameValue;
      pickUpoverAllPlaceName = locationNameValue + ',' + placeNameValue;
      pickUplatitudeValue = latitude.toString();
      pickUplongitudeValue = longitude.toString();
    });
    print("The overall pick up place is");
    print(pickUpoverAllPlaceName);
    _showLocationDialog(context);
  }

  String hlocationName = 'Set Your Location';
  String hoverAllPlaceName = '';
  String hplaceName = '';
  String hlatitudeValue = '';
  String hlongitudeValue = '';

  SetHourlyLatLongAndPlaceName(double latitude, double longitude,
      String locationNameValue, String placeNameValue) {
    print("Hourly callback called");
    print("latitude: $latitude");
    print("latitude: $longitude");
    setState(() {
      hlocationName = locationNameValue;
      hplaceName = placeNameValue;
      hoverAllPlaceName = locationNameValue + ',' + placeNameValue;
      hlatitudeValue = latitude.toString();
      hlongitudeValue = longitude.toString();
    });
  }

  int bedQuantity = 1;
  int personCount = 1;
  int normalbedQuantity = 1;
  int normalpersonCount = 1;

  DateTime startDate = DateTime.now().toLocal();
  DateTime endDate = DateTime.now().add(Duration(days: 1));
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime currentDate = DateTime.now();
  TextEditingController locationContoller = new TextEditingController();
  TextEditingController rateContoller = new TextEditingController();
  TextEditingController noteContoller = new TextEditingController();
  TextEditingController hoursController = new TextEditingController();
  bool startDateSelected = true;
  bool endDateSelected = true;
  void _selectStartDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2300),
    );
    if (selectedDate != null) {
      setState(() {
        startDateSelected = true;
        startDate = selectedDate;
        startDateController.text = dateFormatter.format(startDate);
        endDateController.text =
            dateFormatter.format(startDate.add(Duration(days: 1)));
      });
    }
  }

  void _selectEndDate() async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: startDate.add(Duration(days: 1)),
        firstDate: startDate.add(Duration(days: 1)),
        lastDate: DateTime(2300));
    if (selectedDate != null) {
      setState(() {
        endDateSelected = true;
        endDate = selectedDate;
        endDateController.text = dateFormatter.format(endDate);
      });
    }
  }

  TextEditingController addressContoller = new TextEditingController();
  TextEditingController hourlyAddressContoller = new TextEditingController();
  TextEditingController pickUpAddressContoller = new TextEditingController();
  TabController? _tabController;
  @override
  void initState() {
    setState(() {
      canProcessMessages = true;
    });

    _getCurrentLocation();
    rateContoller.text = "1100";
    startDateController.text = dateFormatter.format(startDate);
    endDateController.text = dateFormatter.format(endDate);
    super.initState();
    _tabController = TabController(
      length: 2, // Specify the number of tabs
      vsync: this, // Use 'this' if the widget is a TickerProvider
    );

    // Listen for tab changes
    _tabController!.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController!.indexIsChanging) {
      // Tab change is happening
      int newTabIndex = _tabController!.index; // Get the new tab index
      print("Tab changed to index $newTabIndex");
      setState(() {
        locationName = '';
        placeName = '';
        overAllPlaceName = '';
        latitudeValue = '';
        longitudeValue = '';
        hlocationName = 'Set Your Location';
        hoverAllPlaceName = '';
        hplaceName = '';
        hlatitudeValue = '';
        hlongitudeValue = '';
      });
      BlocProvider.of<BargainBloc>(context).add(BargainEvent());
      // Perform actions or update UI based on the tab change
    }
  }

  callback() {
    Navigator.of(context).pop();
  }

  void _showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 150,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enter Your Location :",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(left: 0, right: 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: PrimaryColors
                            .backgroundcolor), // Change the border color here
                    borderRadius: BorderRadius.circular(
                        10.0), // You can adjust the border radius as well
                  ),
                  child: TextField(
                      controller: pickUpAddressContoller,
                      readOnly: true,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        prefixIcon: Icon(Icons.location_pin),
                        hintText: pickUpoverAllPlaceName == ''
                            ? "Select Your Location"
                            : "$pickUpoverAllPlaceName",
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapPage(
                                  fromPickUp: true,
                                  callBack: SetPickUpLatLongAndPlaceName,
                                  currentLatitude: currentLatitude,
                                  currentLongitude:
                                      currentLongitude)), // Navigate to MapPage
                        );
                      }),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Submit')),
                  ],
                )
              ]),
            ),
          ),

          // title: Text("Enter Your Location:"),
          // content: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     TextField(
          //       controller: locationController,
          //       decoration: InputDecoration(
          //         hintText: "Enter your location",
          //       ),
          //     ),
          //     SizedBox(height: 20),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         ElevatedButton(
          //           onPressed: () {
          //             Navigator.of(context).pop(); // Close the dialog
          //           },
          //           child: Text("Close"),
          //         ),
          //         ElevatedButton(
          //           onPressed: () {
          //             // Handle the location submission here
          //             String enteredLocation = locationController.text;
          //             print("Location submitted: $enteredLocation");
          //             Navigator.of(context).pop(); // Close the dialog
          //           },
          //           child: Text("Submit"),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        );
      },
    );
  }

  double currentLatitude = 28.22274180305713;
  double currentLongitude = 83.98543306191425;
  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLatitude = position.latitude;
      currentLongitude = position.longitude;
      print("The Lat Lng is " +
          currentLatitude.toString() +
          ' ' +
          currentLongitude.toString());
      // _locationMessage = "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Stack(
          children: [
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                backgroundColor: PrimaryColors.backgroundcolor,
                appBar: AppBar(
                  backgroundColor: whiteColor,
                  elevation: 0,
                  centerTitle: true,
                  title: Text('BARGAIN',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                    ),
                    onPressed: () {
                      // setState(() {
                      //   canProcessMessages = true;
                      // });

                      Navigator.pop(context);
                    },
                    color: Colors.black,
                  ),
                  bottom: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        child: Text(
                          "Normal Bargaining",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Hourly Bargaining",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          color: PrimaryColors.primarywhite,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: BlocBuilder<BargainBloc, BargainState>(
                                    builder: (context, state) {
                                      return CategoryIcon(
                                          controller: rateContoller);
                                    },
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: BedCategory(controller: rateContoller),
                                ),
                                const SizedBox(height: 5),
                                BlocBuilder<BargainBloc, BargainState>(
                                  builder: (context, state) {
                                    Color borderColor = Colors.grey;
                                    if (state is BargainErrorState) {
                                      if (state.errorName == 'Location Error') {
                                        borderColor = Colors.red;
                                      }
                                    }
                                    return Container(
                                      height: 40,
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                borderColor), // Change the border color here
                                        borderRadius: BorderRadius.circular(
                                            10.0), // You can adjust the border radius as well
                                      ),
                                      child: TextField(
                                          controller: addressContoller,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 2,
                                                    horizontal: 10),
                                            floatingLabelAlignment:
                                                FloatingLabelAlignment.center,
                                            prefixIcon:
                                                Icon(Icons.location_pin),
                                            hintText: overAllPlaceName == ''
                                                ? "Select Your Location"
                                                : "$overAllPlaceName",
                                            hintStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MapPage(
                                                        callBack:
                                                            SetLatLongAndPlaceName,
                                                        currentLatitude:
                                                            currentLatitude,
                                                        currentLongitude:
                                                            currentLongitude,
                                                      )), // Navigate to MapPage
                                            );
                                          }),
                                    );
                                  },
                                ),
                                const KMRange(),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 40,
                                        margin: const EdgeInsets.only(left: 10),
                                        child: CustomButton(
                                          onpressed: () {
                                            int currentRate =
                                                int.parse(rateContoller.text);

                                            currentRate = currentRate + 100;
                                            setState(() {
                                              rateContoller.text =
                                                  currentRate.toString();
                                            });
                                          },
                                          label: '+',
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: rateContoller,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 10),
                                              hintText: '0',
                                              prefixIcon: Icon(
                                                  Icons.attach_money_outlined),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 40,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: CustomButton(
                                          onpressed: () {
                                            int currentRate =
                                                int.parse(rateContoller.text);
                                            if (currentRate > 0) {
                                              currentRate = currentRate - 100;
                                            }
                                            setState(() {
                                              rateContoller.text =
                                                  currentRate.toString();
                                            });
                                          },
                                          label: '-',
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      BlocBuilder<BargainBloc, BargainState>(
                                        builder: (context, state) {
                                          Color widgetColor = Colors.grey;
                                          if (state is BargainErrorState) {
                                            if (state.errorName ==
                                                'Start Date Error') {
                                              widgetColor = Colors.red;
                                            }
                                          }
                                          return Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0, right: 5),
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10, right: 5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          widgetColor), // Change the border color here
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0), // You can adjust the border radius as well
                                                ),
                                                child: TextField(
                                                  readOnly: true,
                                                  controller:
                                                      startDateController,
                                                  decoration: InputDecoration(
                                                    floatingLabelAlignment:
                                                        FloatingLabelAlignment
                                                            .center,
                                                    hintText: "Check In",
                                                    border: InputBorder.none,
                                                    hintStyle: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 13,
                                                    ),
                                                    prefixIcon: Icon(
                                                      Icons
                                                          .calendar_month_outlined,
                                                    ),
                                                  ),
                                                  onTap: _selectStartDate,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      BlocBuilder<BargainBloc, BargainState>(
                                        builder: (context, state) {
                                          Color widgetColor2 = Colors.grey;
                                          if (state is BargainErrorState) {
                                            if (state.errorName ==
                                                'End Date Error') {
                                              widgetColor2 = Colors.red;
                                            }
                                          }
                                          return Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0, right: 5),
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10, right: 5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          widgetColor2), // Change the border color here
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0), // You can adjust the border radius as well
                                                ),
                                                child: TextField(
                                                  readOnly: true,
                                                  controller: endDateController,
                                                  decoration: InputDecoration(
                                                    floatingLabelAlignment:
                                                        FloatingLabelAlignment
                                                            .center,
                                                    hintText: 'Check Out',
                                                    border: InputBorder.none,
                                                    hintStyle: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 13,
                                                    ),
                                                    prefixIcon: Icon(
                                                      Icons
                                                          .calendar_month_outlined,
                                                    ),
                                                  ),
                                                  onTap: _selectEndDate,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: TextFormField(
                                            onFieldSubmitted: (val) {
                                              normalpersonCount =
                                                  int.parse(val);
                                              print(normalpersonCount);
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 10),
                                              hintText:
                                                  'No of Person :  $normalpersonCount',
                                              prefixIcon:
                                                  Icon(Icons.person_add_sharp),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 40,
                                        margin: const EdgeInsets.only(left: 10),
                                        child: CustomButton(
                                          onpressed: () {
                                            setState(() {
                                              normalbedQuantity++;
                                            });
                                          },
                                          label: '+',
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: TextFormField(
                                            readOnly: true,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 10),
                                              hintText:
                                                  'Bed Quantity: $normalbedQuantity',
                                              prefixIcon:
                                                  Icon(Icons.hotel_outlined),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 40,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: CustomButton(
                                          onpressed: () {
                                            if (normalbedQuantity > 1) {
                                              setState(() {
                                                normalbedQuantity--;
                                              });
                                            }
                                          },
                                          label: '-',
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: TextField(
                                    controller: noteContoller,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      hintText: 'Notes',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    _showLocationDialog(context);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 9),
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: PrimaryColors.primaryblue,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Need A Pick Up?",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                color:
                                                    PrimaryColors.primaryblue),
                                          ),
                                          Icon(
                                            Icons.motorcycle,
                                            color: PrimaryColors.primaryblue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, right: 9),
                                  width: double.infinity,
                                  height: 50,
                                  child: CustomButton(
                                    onpressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      BlocProvider.of<BargainBloc>(context).add(
                                          getAdditionalData(
                                              overAllPlaceName,
                                              rateContoller.text,
                                              normalbedQuantity,
                                              startDate.toString(),
                                              endDate.toString(),
                                              startDateSelected,
                                              endDateSelected,
                                              normalpersonCount,
                                              hoursValue,
                                              noteContoller.text,
                                              latitudeValue,
                                              longitudeValue,
                                              pickUpoverAllPlaceName,
                                              pickUplatitudeValue,
                                              pickUplongitudeValue,
                                              false));

                                      BlocProvider.of<BargainBloc>(context)
                                          .add(sendData(context));

                                      // startTimer();
                                    },
                                    label: 'Find Room',
                                    size: 15,
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          color: PrimaryColors.primarywhite,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: BlocBuilder<BargainBloc, BargainState>(
                                    builder: (context, state) {
                                      return CategoryIcon(
                                          controller: rateContoller);
                                    },
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: BedCategory(controller: rateContoller),
                                ),
                                const SizedBox(height: 5),
                                BlocBuilder<BargainBloc, BargainState>(
                                  builder: (context, state) {
                                    Color borderColor = Colors.grey;
                                    if (state is BargainErrorState) {
                                      if (state.errorName == 'Location Error') {
                                        borderColor = Colors.red;
                                      }
                                    }
                                    return Container(
                                      height: 40,
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                borderColor), // Change the border color here
                                        borderRadius: BorderRadius.circular(
                                            10.0), // You can adjust the border radius as well
                                      ),
                                      child: TextField(
                                          controller: hourlyAddressContoller,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 2,
                                                    horizontal: 10),
                                            floatingLabelAlignment:
                                                FloatingLabelAlignment.center,
                                            prefixIcon:
                                                Icon(Icons.location_pin),
                                            hintText: hoverAllPlaceName == ''
                                                ? "Select Your Location"
                                                : "$hoverAllPlaceName",
                                            hintStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MapPage(
                                                        fromHourly: true,
                                                        callBack:
                                                            SetHourlyLatLongAndPlaceName,
                                                        currentLatitude:
                                                            currentLatitude,
                                                        currentLongitude:
                                                            currentLongitude,
                                                      )), // Navigate to MapPage
                                            );
                                          }),
                                    );
                                  },
                                ),
                                const KMRange(),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: TextFormField(
                                            onFieldSubmitted: (val) {
                                              personCount = int.parse(val);
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 10),
                                              hintText:
                                                  'No of Person :  $personCount',
                                              prefixIcon:
                                                  Icon(Icons.person_add_sharp),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 40,
                                        margin: const EdgeInsets.only(left: 10),
                                        child: CustomButton(
                                          onpressed: () {
                                            setState(() {
                                              bedQuantity++;
                                            });
                                          },
                                          label: '+',
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: TextFormField(
                                            readOnly: true,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 10),
                                              hintText:
                                                  'Bed Quantity: $bedQuantity',
                                              prefixIcon:
                                                  Icon(Icons.hotel_outlined),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 40,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: CustomButton(
                                          onpressed: () {
                                            setState(() {
                                              if (bedQuantity > 1) {
                                                bedQuantity--;
                                              }
                                            });
                                          },
                                          label: '-',
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: TextFormField(
                                            onFieldSubmitted: (val) {
                                              hoursValue = int.parse(val);
                                            },
                                            // controller: hoursController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 10),
                                              hintText:
                                                  'Hours (For Rooms) : $hoursValue',
                                              prefixIcon:
                                                  Icon(Icons.access_time),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, right: 9),
                                  width: double.infinity,
                                  height: 55,
                                  child: CustomButton(
                                    onpressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      BlocProvider.of<BargainBloc>(context).add(
                                          getAdditionalData(
                                              hoverAllPlaceName,
                                              '0',
                                              bedQuantity,
                                              DateTime.now().toString(),
                                              DateTime.now().toString(),
                                              true,
                                              true,
                                              personCount,
                                              hoursValue,
                                              '',
                                              hlatitudeValue,
                                              hlongitudeValue,
                                              pickUpoverAllPlaceName,
                                              pickUplatitudeValue,
                                              pickUplongitudeValue,
                                              true));

                                      BlocProvider.of<BargainBloc>(context)
                                          .add(sendData(context));
                                      // startTimer();
                                    },
                                    label: 'Find Room',
                                    size: 15,
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<BargainBloc, BargainState>(
              builder: (context, state) {
                if (state is BargainLoadingState) {
                  return Container(
                      color: Colors.grey.withOpacity(0.2),
                      child: CustomeLoader(
                        callback: callback,
                      ));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class KMRange extends StatefulWidget {
  const KMRange({super.key});

  @override
  State<KMRange> createState() => _KMRangeState();
}

class _KMRangeState extends State<KMRange> {
  RangeValues values = const RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    RegExp regExp = RegExp(r'[-+]?\d*\.?\d+');
    RangeLabels labels = RangeLabels(
      values.start.toString(),
      values.end.toString(),
    );
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: RangeSlider(
              activeColor: PrimaryColors.primaryblue,
              inactiveColor: Colors.grey[400],
              values: values,
              labels: labels,
              min: 0,
              divisions: 10,
              max: 100,
              onChanged: (newValue) {
                values = newValue;
                print(newValue.start);
                print(newValue.end);
                BlocProvider.of<BargainBloc>(context)
                    .add(getRange(newValue.start, newValue.end));

                setState(() {});
              },
            ),
          ),
          Text(
              '${values.toString().split(",")[1].replaceAll(RegExp(r'[^0-9.]'), '').split(".")[0]} KM'),
        ],
      ),
    );
  }
}
