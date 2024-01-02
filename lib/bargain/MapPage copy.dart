// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_app/User/Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
// import '../../../../../Controller/bloc/Home/location/bloc/location_bloc.dart';
// import '../../../../../Controller/bloc/map/bloc/map_bloc.dart';
// import '../../../../constants/colors.dart';
// import '../../../../custome_loader.dart';
// import '../HomeScreensNavigation.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:google_maps_webservice/places.dart' as places;

// import 'LocationChangePage.dart';

// class MapPage extends StatefulWidget {
//   bool? fromPayment;
//   MapPage({super.key, this.fromPayment});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   LatLng? _center =
//       LatLng(28.21754500300589, 83.98650613439649); // Initial map center
//   LatLng markerPosition = LatLng(28.21754500300589, 83.98650613439649);
//   void findLocation() {
//     final double latitude = markerPosition.latitude;
//     final double longitude = markerPosition.longitude;
//   }

//   Set<Marker> markers = {};

//   GoogleMapController? mapController;

//   Marker staticMarker = Marker(
//     markerId: MarkerId('static_marker'),
//     position: LatLng(0, 0),
//     draggable: false,
//   );

//   bool locationloaded = false;
//   String? locationName = 'null';
//   String? placeName = 'null';
//   Position? currentLocation;
//   Position? currentPosition;
//   bool loading = false;
//   Future<void> getCurrentLocationInMobile() async {
//     try {
//       print("Hello");
//       setState(() {
//         loading =true;
//       });
//       SharedPreferences _locationDetail = await SharedPreferences.getInstance();
//       String? latitude = _locationDetail.getString('latitude');
//       String? longitude = _locationDetail.getString('longitude');
//       print(latitude);
//       if (latitude != null) {
//         print("Part 1");
//         setState(() {
//           _center = LatLng(double.parse(latitude!), double.parse(longitude!));
//           locationloaded = true;
//           loading = false;
//         });
//         locationName = _locationDetail.getString('locationName');
//         placeName = _locationDetail.getString('placeName');
//       } else {
//         currentPosition = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high,
//         );

//         List<Placemark> placemarks = await placemarkFromCoordinates(
//           currentPosition!.latitude,
//           currentPosition!.longitude,
//           localeIdentifier: 'en',
//         );

//         setState(() {
//           _center =
//               LatLng(currentPosition!.latitude, currentPosition!.longitude);
//           Placemark currentPlacemark = placemarks.first;
//           locationName = currentPlacemark.name ?? '';
//           placeName = currentPlacemark.street ?? '';
//           print("The current location is: $locationName, $placeName");

//           loading = false;
//           locationloaded = true;
//         });
//       }
//       setState(() {
//         print(loading);
//         loading =false;
//       });
//     } catch (e) {
//       // Handle any errors that occur during location retrieval
//       print('Error getting current location: $e');
//     }
//   }

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   Future<void> getLocation(double latitude, double longitude) async {
//     try {
//       // BlocProvider.of<LocationBloc>(context).add(OnLocationLoading());
//       setState(() {
//         loading = true;
//       });
//       print("the loader is");
//       print(loading);
//       SharedPreferences _locationDetail = await SharedPreferences.getInstance();
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         latitude,
//         longitude,
//         localeIdentifier: 'en',
//       );

//       Placemark currentPlacemark = placemarks.first;
//       setState(() {
//         loading =true;
//         locationName = currentPlacemark.name ?? '';
//         placeName = currentPlacemark.street ?? '';
//         _locationDetail.setString('locationName', locationName!);
//         _locationDetail.setString('placeName', placeName!);
//         _locationDetail.setString('latitude', latitude.toString()!);
//         _locationDetail.setString('longitude', longitude.toString()!);
//         locationloaded = true;
//         print("The current location is: $locationName, $placeName");
//       });
//       await Future.delayed(Duration(seconds: 2));
//       if (widget.fromPayment == true) {
//         Get.back();
//         Get.back();
//       } else {
//         Get.offAll(BlocProvider(
//           create: (context) => HomePageBloc(),
//           child: BlocProvider(
//             create: (context) => HomeNavigationBloc(),
//             child: BlocProvider(
//               create: (context) => LocationBloc(),
//               child: HomeScreensNavigation(
//                 currentIndexNumber: 0,
//                 loginStatus: "true",
//                 homeData: [],
//                 advertisementData: [],
//               ),
//             ),
//           ),
//         ));
//       }
//     } catch (e) {
//       // Handle any errors that occur during location retrieval
//       print('Error getting current location: $e');
//     }
//   }

//   @override
//   initState() {
//     super.initState();
//     BlocProvider.of<MapBloc>(context).add(MapLoadingEvent());
//     // getCurrentLocationInMobile();
//   }

//   @override
//   void dispose() {
//     // Dispose of the GoogleMapController
//     print("dispose");
//     // mapController?.clearTileCache();
//     mapController?.dispose();
//     super.dispose();
//   }

// //   Location location = Location();
// //    Future<void> _getCurrentLocation() async {
// //     try {
// //       LocationData locationData = await location.getLocation();
// //       mapController.animateCamera(CameraUpdate.newLatLng(LatLng(
// //         locationData.latitude,
// //         locationData.longitude,
// //       )));
// //     } catch (e) {
// //       // Handle location error
// //       print(e.toString());
// //     }
// //   }
// // }
//   final String googleApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
//   final places.GoogleMapsPlaces _places = places.GoogleMapsPlaces(
//       apiKey: "AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0");
//   List<places.Prediction> _suggestions = [];
//   TextEditingController _searchController = TextEditingController();
//   void _onSearchButtonPressed(String input) async {
//     print("The nimput value is");
//     setState(() {
//       _suggestions = [];
//     });
//     print(input);
//     if (input.isNotEmpty) {
//       final places =
//           GoogleMapsPlaces(apiKey: 'AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0');
//       PlacesSearchResponse response = await places.searchByText(input);
//       print("The latitude and longitude is");
//       if (response.isOkay && response.results.isNotEmpty) {
//         final place = response.results[0];
//         print(place.geometry?.location.lat);
//         print(place.geometry?.location.lng);
//         mapController?.animateCamera(
//           CameraUpdate.newLatLng(LatLng(place.geometry?.location.lat ?? 0,
//               place.geometry?.location.lng ?? 0)),
//         );
//         setState(() {
//           disappear = false;
//         });
//         FocusScope.of(context).requestFocus(FocusNode());
//       }
//     }
//   }

//   bool disappear = false;
//   void _onTextChanged(String value) async {
//     setState(() {
//       disappear = true;
//     });
//     final response = await _places.autocomplete(value, region: "NP");
//     print(value);
//     if (response.isOkay) {
//       setState(() {
//         _suggestions = response.predictions;
//         print(_suggestions[0].description.toString());
//       });
//     }
//     if (value == '') {
//       setState(() {
//         _suggestions = [];
//       });
//     }
//   }

//   Widget _buildSuggestionsList() {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: _suggestions.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(_suggestions[index].description.toString()),
//           onTap: () {
//             _searchController.text = _suggestions[index].description.toString();
//             _onSearchButtonPressed(_searchController.text);
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return WillPopScope(
//       onWillPop: () async {
//         mapController?.dispose();
//         await Future.delayed(Duration(seconds: 1));
//        Get.back();
//         return true;
//       },
//       child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             leading: BackButton(
//               color: Colors.black,
//               onPressed: ()async{
//                 mapController?.dispose();
//                 await Future.delayed(Duration(seconds: 1));
//                 Get.back();
//               }
//             ),
//             title: Text(
//               "Set Delivery Location",
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//           body: BlocBuilder<MapBloc, MapState>(
//                   builder: (context, state) {
//                     print("The state is");
//                     print(state);
//                     if(state is MapLoadingState){
//                       return Container(
//                       child: Center(child: CustomeLoader()),
//                     );
//                     }
//                     if(state is MapLoadedState){
//                       // loading =false;
//                       return Stack(
//       children: [
//         Container(
//           height: Get.height,
//           width: Get.width,
//           child: Container(
//             height: Get.height,
//             width: Get.width,
//             child: GoogleMap(
//               myLocationEnabled: true,
//               myLocationButtonEnabled: true,
//               indoorViewEnabled: true,
//               mapType: MapType.normal,
//               onMapCreated: (controller) {
//                 mapController = controller;
//               },
//               onCameraMove: (cameraPosition) {
//                 setState(() {
//                   markerPosition = cameraPosition.target;
//                 });
//               },
//               initialCameraPosition: CameraPosition(target: state.center, zoom: 18),
//               onTap: (position) {},
//               markers: markers,
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.center,
//           child: Container(
//             child: Icon(
//               Icons.location_pin,
//               size: 60,
//               color: Colours.primarygreen,
//             ),
//           ),
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 200,
//                   height: 35,
//                   child: disappear == false
//                       ? ElevatedButton(
//                           onPressed: () async {
                            
//                             getLocation(markerPosition.latitude.toDouble(),
//                                 markerPosition.longitude.toDouble());
//                           },
//                           child: Text("SET LOCATION"),
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 Colours.primarygreen),
//                           ),
//                         )
//                       : Container(),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 50,
//             ),
//           ],
//         ),
//         Column(
//           children: [
//             Container(
//               color: Colors.white,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                 child: Container(
//                   width: 500,
//                   height: 52,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.grey)),
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: _searchController,
//                         decoration: InputDecoration(
//                           hintText: 'Search...',
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 12),
//                           suffixIcon: IconButton(
//                             icon: Icon(Icons.search),
//                             onPressed: () {},
//                           ),
//                         ),
//                         onChanged: _onTextChanged,
//                         onTap: () {
//                           setState(() {
//                             disappear = true;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Container(color: Colors.white, child: _buildSuggestionsList())
//           ],
//         ),
//       loading?
//       Container(child: CustomeLoader())
//       :Container()
//       ],
//     );
//                     }
//                     else{
//                       return Container(
//                       child: Center(child: CircularProgressIndicator()),
//                     );
//                     }
                    
//                   },
//                 ),
              
//     ),
//     );
//   }

  
// }
