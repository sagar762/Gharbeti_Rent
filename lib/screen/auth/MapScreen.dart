
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gharbeti/screen/auth/stepperexample.dart';
import 'package:gharbeti/widget/CustomButton.dart';
import 'package:gharbeti/widget/CustomTextField.dart';
import 'package:gharbeti/widget/color.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
// import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:auto_reload/auto_reload.dart';

import '../../controller/steper_controller.dart';
import 'HouseForm.dart';

class MapScreen extends StatefulWidget{
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final controller = Get.put(SteperController());
  Set<Marker> markers = {};
  late double lat;
  late double lan;
  String? address;
  String? _currentAddress;
  // String? _currentAddress1;
  String googleApikey = "AIzaSyC4vO-waVV5zjhQ4DQIPkln-s79zdtXBDA";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String location = "Search Location";
  final TextEditingController locationController = TextEditingController();
  var place;
  void getCurrentAddress() async {

  }
  @override
  void initState() {
    _determinePosition();
    super.initState();

    // getLocation();
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  @override
  Widget build(BuildContext context) {
    bool allowClose = false;
    return  Scaffold(
        appBar: AppBar(
          title: Text("Google Maps"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Stack(
            children:[
               GoogleMap(
                padding: EdgeInsets.only(top: 500.h, right: 50),
                // padding: EdgeInsets.only(top: 510.0.h, right: 5.0),
               zoomGesturesEnabled: true,
                zoomControlsEnabled: false,


                initialCameraPosition: CameraPosition(
                  target: startLocation,

                  zoom: 14.0,
                ),
                // initialCameraPosition: CameraPosition(
                //   target: _currentPosition(),
                //   zoom: 16.0,
                // ),
                mapType: MapType.normal,
                onMapCreated: (controller) { //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
                onCameraMove: (CameraPosition cameraPositiona) {
                  cameraPosition = cameraPositiona;
                },
                onCameraIdle: () async {
                  List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
                  setState(() {
                    location = placemarks.first.subLocality.toString() + ", " + placemarks.first.subAdministrativeArea.toString();
                    // print(prefs.getString('textaddress'));
                  });
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('textaddress', location);
                },
              ),

              Center( //picker image on google map
                child: Icon(Icons.location_on, color: Colors.red, size: 50.0,)
                // Image.asset("assets/images/picker.png", width: 80,),
              ),

              //search autoconplete input
              Positioned(  //search input bar
                  top:10.h,
                  child: InkWell(
                      onTap: () async {
                        place = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: googleApikey,
                            mode: Mode.overlay,
                            types: [],
                            strictbounds: false,
                            components: [Component(Component.country, 'np')],
                            //google_map_webservice package
                            onError: (err){
                              print(err);
                            }
                        );

                        if(place != null){
                          setState(() {
                            location = place.description.toString();
                          });
                          //form google_maps_webservice package
                          final plist = GoogleMapsPlaces(apiKey:googleApikey,
                            apiHeaders: await GoogleApiHeaders().getHeaders(),
                            //from google_api_headers package
                          );
                          String placeid = place.placeId ?? "0";
                          final detail = await plist.getDetailsByPlaceId(placeid);
                          final geometry = detail.result.geometry!;
                          final lat = geometry.location.lat;
                          final lang = geometry.location.lng;
                          var newlatlang = LatLng(lat, lang);
                          List<Placemark> placemarks = await placemarkFromCoordinates(
                              lat, lang);
                          Placemark placeMark = placemarks[0];
                          _currentAddress =
                          '${placeMark.subLocality}, ${placeMark.subAdministrativeArea}, ${placeMark.postalCode}';
                          // print(_currentAddress);
                          // final SharedPreferences prefs  = await SharedPreferences.getInstance();
                          // prefs.setString('address', _currentAddress!);
                          // print(prefs.getString('address'));
                          setState(() {

                          });
                          // setState(() async {
                          //   // addressController.text = _currentAddress.toString();
                          //
                          //
                          //   // addressController.text = placeMark.toString();
                          //   // print(addressController);
                          // });
                          print(newlatlang);
                          //move map camera to selected place with animation
                          mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                        }
                      },
                      child:
                      Padding(
                        padding: EdgeInsets.all(15).w,
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width - 40,
                              child: ListTile(
                                title:Text(location, style: TextStyle(fontSize: 18),),
                                trailing: Icon(Icons.search),
                                dense: true,
                              )
                          ),
                        ),
                      )
                  )
              ),
              Positioned.fill(
                top: 660.h,
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomButton(text: 'Confirm', onPressed: () async{
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      address = prefs.getString('textaddress');
                      print(address);
                      // getCurrentAddress()
                      if(address!= null) {
                        controller.getprefs();
                        Get.off(()=>HouseInfoForm());

                      } else {
                        Get.showSnackbar(
                          GetSnackBar(
                            title: 'Failed',
                            message: 'Please Search your Address',
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    }, height: 135.h, width: 35.w,),
                  )
              )


            ]
        ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, right: 12.0).h,
        child: SizedBox(
          height: 50.h,
          width: 50.w,
          child: FloatingActionButton(
            onPressed: () async {
              Position position = await _determinePosition();
              mapController
                  ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));
              markers.clear();
              markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude)));
              setState(() {});

            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.gps_fixed),
          ),
        ),
      ),
    );
  }
}