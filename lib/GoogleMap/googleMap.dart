import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}
final homeScaffoldkey=GlobalKey<ScaffoldState>();
const kGoogleApiKey="AIzaSyBb-YTS_bE3p-4eOJ7yxUVXHS80tcpgj5M";
class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  static CameraPosition inittalCamraPosition=CameraPosition(target: LatLng(33.711933,73.057533),zoom: 16.0);
  static const CameraPosition targetPosition=CameraPosition(target: LatLng(33.711933,73.057533),zoom: 16.0,bearing: 192.0,tilt: 60);
late GoogleMapController googleMapController;
Set<Marker> markers={};
getCurrentLocation()async
{
  Position position=await _determinPosition();
  googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude,position.longitude),zoom: 14)));
  markers.clear();
  markers.add(Marker(markerId: MarkerId("current location"),position: LatLng(position.latitude,position.longitude)));

  setState(() {});

}
initState()
{
  getCurrentLocation();
   super.initState();
}
final Mode _mode=Mode.overlay;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: homeScaffoldkey,
      body: Stack(
        children:[
          GoogleMap(
          initialCameraPosition:
          inittalCamraPosition,mapType: MapType.normal,
          zoomControlsEnabled: false,
          markers: markers,
          onMapCreated: (GoogleMapController controller){
          googleMapController=controller;
        },),
          // Positioned(
          //   top: 40,
          //   child: ElevatedButton(onPressed: (){
          //     _handlePressbutton();
          //   }, child: Text("Search Location")),
          // )
      ]
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()async{
          _handlePressbutton();
          setState(() {});
      }, label:Text("Search Location"),icon: Icon(Icons.location_on),),
    );

  }

  _handlePressbutton() async{
  Prediction? p=await PlacesAutocomplete.show(context: context, apiKey: kGoogleApiKey,
   onError: onError,
     mode: _mode,
     language: 'en',
     strictbounds: false,
     types: [''],
     decoration: InputDecoration(
       hintText: "search",
       focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
       borderSide: BorderSide(color: Colors.white),
       )
     ),
     components:[Component(Component.country,"pk")],

   );
   displayPredicition(p!,homeScaffoldkey.currentState);
  }
  void onError(PlacesAutocompleteResponse response){
  // homeScaffoldkey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }
  Future<Position> _determinPosition()async{
    bool serviceInabled;
    LocationPermission permission;
    serviceInabled=await Geolocator.isLocationServiceEnabled();
    if(!serviceInabled)
      {
        return Future.error("Location Service is disabled");
      }
    permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied) {
      permission=await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission denied");
      }
    }
        if(permission==LocationPermission.deniedForever)
          {
            return Future.error("Location Permission permanently denied");
          }
    Position position=await Geolocator.getCurrentPosition();

    return position;
  }
  void displayPredicition(Prediction p, ScaffoldState? currentState) async{
    GoogleMapsPlaces googleMapsPlaces=GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders()
    );
    PlacesDetailsResponse detailsResponse=await googleMapsPlaces.getDetailsByPlaceId(p.placeId!);
    final lat=detailsResponse.result.geometry!.location.lat;
    final lon=detailsResponse.result.geometry!.location.lng;
    markers.clear();
    // final coordinates = new Coordinates(lat, lat);
    //
    // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);

    // var first = addresses.first;
    // print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');

    markers.add(Marker(markerId: const MarkerId("0"),position: LatLng(lat,lon),

    infoWindow:InfoWindow(title:detailsResponse.result.name )
    ));
    setState(() {});
    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat,lon),14));

  }
}

