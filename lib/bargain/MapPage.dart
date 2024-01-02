import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/places.dart' as places;
class MapPage extends StatefulWidget {
  bool? fromPickUp;
  bool? fromHourly;
  Function callBack;
  double currentLatitude;
  double currentLongitude;
  MapPage({super.key,
  this.fromPickUp,
  this.fromHourly,
  required this.callBack,
  required this.currentLatitude,
  required this.currentLongitude,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _center =
      LatLng(28.21754500300589, 83.98650613439649); // Initial map center
  LatLng markerPosition = LatLng(28.21754500300589, 83.98650613439649);
  void findLocation() {
    final double latitude = markerPosition.latitude;
    final double longitude = markerPosition.longitude;
  }

  Set<Marker> markers = {};

  GoogleMapController? mapController;

  Marker staticMarker = Marker(
    markerId: MarkerId('static_marker'),
    position: LatLng(0, 0),
    draggable: false,
  );
  

  bool locationloaded = false;
  String? locationName = 'null';
  String? placeName = 'null';
  Position? currentLocation;
  Position? currentPosition;
  bool loading = false;
  Future<void> getCurrentLocationInMobile() async {
    try {
      SharedPreferences _locationDetail = await SharedPreferences.getInstance();
      String? latitude = _locationDetail.getString('latitude');
      String? longitude = _locationDetail.getString('longitude');
      print(latitude);
      if (latitude != null) {
        print("Part 1");
        setState(() {
          _center = LatLng(double.parse(latitude!), double.parse(longitude!));
          locationloaded = true;
          loading = false;
        });
        locationName = _locationDetail.getString('locationName');
        placeName = _locationDetail.getString('placeName');
      } else {
        currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition!.latitude,
          currentPosition!.longitude,
          localeIdentifier: 'NP',
        );

        setState(() {
          _center =
              LatLng(currentPosition!.latitude, currentPosition!.longitude);
          Placemark currentPlacemark = placemarks.first;
          locationName = currentPlacemark.name ?? '';
          placeName = currentPlacemark.street ?? '';
          print("The current location is: $locationName, $placeName");

          loading = false;
          locationloaded = true;
        });
      }
    } catch (e) {
      // Handle any errors that occur during location retrieval
      print('Error getting current location: $e');
    }
  }
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> getLocation(double latitude, double longitude) async {
    try {
      SharedPreferences _locationDetail = await SharedPreferences.getInstance();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
        localeIdentifier: 'NP',
      );

      Placemark currentPlacemark = placemarks.first;
      setState(() {
        locationName = currentPlacemark.name ?? '';
        placeName = currentPlacemark.street ?? '';
        _locationDetail.setString('locationName', locationName!);
        _locationDetail.setString('placeName', placeName!);
        _locationDetail.setString('latitude', latitude.toString()!);
        _locationDetail.setString('longitude', longitude.toString()!);
        locationloaded = true;
        print("The current location is: $locationName, $placeName");
      });
      
    } catch (e) {
      // Handle any errors that occur during location retrieval
      print('Error getting current location: $e');
    }
  }

  @override
  initState() {
    super.initState();
    print("hello");
    _center = LatLng(widget.currentLatitude, widget.currentLongitude);
    //getCurrentLocationInMobile();
  }
   @override
  void dispose(){
    mapController?.dispose(); 
   
      
    super.dispose(); // Call the superclass's dispose method

    // Dispose of the GoogleMapController
    // super.dispose();
  }


//   Location location = Location();
//    Future<void> _getCurrentLocation() async {
//     try {
//       LocationData locationData = await location.getLocation();
//       mapController.animateCamera(CameraUpdate.newLatLng(LatLng(
//         locationData.latitude,
//         locationData.longitude,
//       )));
//     } catch (e) {
//       // Handle location error
//       print(e.toString());
//     }
//   }
// }
final String googleApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
final places.GoogleMapsPlaces _places =
    places.GoogleMapsPlaces(apiKey: "AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0");
    List<places.Prediction> _suggestions = [];
TextEditingController _searchController = TextEditingController();
void _onSearchButtonPressed(String input) async {
  print("The nimput value is");
  setState(() {
        _suggestions =[];
      });
  print(input);
    if (input.isNotEmpty) {
      final places = GoogleMapsPlaces(
        apiKey: 'AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0'
        
        );
      PlacesSearchResponse response = await places.searchByText(input,region: "NP");
      print("The latitude and longitude is");
     
      if (response.isOkay && response.results.isNotEmpty) {
        final place = response.results[0];
         print(place.geometry?.location.lat);
          print(place.geometry?.location.lng);
        mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(place.geometry?.location.lat ?? 0, place.geometry?.location.lng ?? 0)),
        );
        setState(() {
                  disappear = false;  
                  });
         FocusScope.of(context).requestFocus(FocusNode());
          
      }
    }
  }
  bool disappear = false;
   void _onTextChanged(String value) async {
    setState(() {
      disappear = true;
    });
    final response = await _places.autocomplete(value,  components: [Component(Component.country, 'NP')],);
    print(value);
    if (response.isOkay) {
      setState(() {
        _suggestions = response.predictions;
        print(_suggestions[0].description.toString());
      });
    }
    if(value == ''){
      setState(() {
        _suggestions =[];
      });
      
    }
  }
    Widget _buildSuggestionsList() {
    return
      ListView.builder(
        shrinkWrap: true,
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_suggestions[index].description.toString()),
            onTap: () {
              _searchController.text = _suggestions[index].description.toString();
              _onSearchButtonPressed(_searchController.text);
            },
          );
        },
      );
  }
  bool makeTheMapDisappear = false;
  @override
  Widget build(BuildContext context) {
    
  double screenHeight = MediaQuery.of(context).size.height;
   double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async{
        print("Bye1234");
        //         setState(() {
        //   loading =true;
        // });
        //          await Future.delayed(Duration(seconds: 1));
        //          setState(() {
        //                           makeTheMapDisappear =true;
        //                         });
        //           await Future.delayed(Duration(milliseconds: 100));
        //         Navigator.pop(context);
                return true;
              },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () async{
                  setState(() {
            loading =true;
          });
                   
                   setState(() {
                                    makeTheMapDisappear =true;
                                  });
                    await Future.delayed(Duration(milliseconds: 100));
                  Navigator.pop(context);
                },
                color: Colors.black,
              ),
            title: Text(
              "Set Location",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body:Stack(
                  children: [
                    makeTheMapDisappear == false ?Padding(
                      padding: const EdgeInsets.fromLTRB(0,40,0,0),
                      child: Container(
                        height:screenHeight,
                        width: screenWidth,
                        child: GoogleMap(
                          compassEnabled: true,
                          indoorViewEnabled: true,
                          mapType: MapType.normal,
                          
                          onMapCreated: (controller) {
                            mapController = controller;
                          },
                          onCameraMove: (cameraPosition) {
                            setState(() {
                              markerPosition = cameraPosition.target;
                            });
                          },
                          initialCameraPosition:
                              CameraPosition(target: _center!, zoom: 18),
                          onTap: (position) {},
                          markers: markers,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                        ),
                        
                      ),
                    ):Container(),
               disappear == false ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Icon(
                          Icons.location_pin,
                          size: 60,
                          color:Color(0xff276BAE)
                        ),
                      ),
                    ):Container(),
                    
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              height: 35,
                              child: 
                              disappear == false ? ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    loading =true;
                                  });
                                  await getLocation(markerPosition.latitude.toDouble(),markerPosition.longitude.toDouble());
                                  // if(widget.fromPickUp == true){

                                  // }
                                  
                                      
                                  await Future.delayed(Duration(seconds: 2));
                                  setState(() {
                                    makeTheMapDisappear =true;
                                  });
                                  
                                   Navigator.pop(context); 
                                   widget.callBack(markerPosition.latitude.toDouble(),
                                      markerPosition.longitude.toDouble(),locationName,placeName);
                                  // getLocation(markerPosition.latitude.toDouble(),
                                  //     markerPosition.longitude.toDouble());
                                },
                                child: Text("SET LOCATION"),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Color(0xff276BAE)),
                                ),
                              ):Container(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                         Column(
                           children: [
                             Container(
                               height: 50,
                                           color: Colors.white,
                                           child: Padding(
                                             padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                             // padding: const EdgeInsets.all(8.0),
                                             child: Container(
                                               height: 30,
                                               width: 500,
                                               decoration: BoxDecoration(
                                                 color: Colors.white,
                                                 borderRadius: BorderRadius.circular(10),
                                                 border: Border.all(color: Colors.grey)
                                               ),
                                               child: Column(
                                                 children: [
                                                              TextFormField(
                                                       controller: _searchController,
                                                       decoration: InputDecoration(
                                                         hintText: 'Search...',
                                                             border: InputBorder.none,
                                                             contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), 
                                                         suffixIcon: IconButton(
                                                           icon: Icon(Icons.search),
                                                           onPressed:(){},
                                                         ),
                                                       ),
                                                       onChanged: _onTextChanged,
                                                       onTap: (){
                                                         setState(() {
                                                           disappear = true;
                                                         });
                                                       },
                                                              ),
                                                 ],
                                               ),
                                             ),
                                           ),
                                         ),
                            Container(
                                   color: Colors.white,
                                   child: _buildSuggestionsList()),
                            loading == true ? Container(
                              height: screenHeight-150,
                              color: Colors.grey.withOpacity(0.1),
                              child: Center(
                                child:
                                CircularProgressIndicator(
                                  
                                )
                              ),
                            ):Container(),
                           ],
                         ),
              
                  ],
                ),
        ),
      ),
    );
  }
}
