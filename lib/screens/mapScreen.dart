import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  static String mapRoute = "/MapScreen";
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  double lat = 28.7041;
  double lang = 77.1025;
  final Map<String, Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void setCurrentLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    setState(() {
      lat = currentLocation.latitude;
      lang = currentLocation.longitude;
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: Stack(children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, lang),
            zoom: 11.0,
          ),
          markers: _markers.values.toSet(),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: FloatingActionButton(
            onPressed: setCurrentLocation,
            child: Icon(Icons.location_on),
          ),
        ),
      ]),
    );
  }
}
