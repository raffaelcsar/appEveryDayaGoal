import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //GoogleMaps - Location - GeoLocation

  Location _location = Location();
  GoogleMapController? _mapController;
  LatLng _latLng = const LatLng(0.0, 0.0);

  @override
  void _createdMap(GoogleMapController controller) {
    _mapController = controller;
    _location.onLocationChanged.listen((event) {
      LatLng local = LatLng(event.latitude!, event.longitude!);
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: local, zoom: 18.0)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createdHome(),
    );
  }

  Widget _createdHome() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Expanded(
                child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: _createdMap,
              myLocationButtonEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: _latLng, zoom: 18.0),
            )),
          ],
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(0, 255, 255, 255),
                Color.fromARGB(0, 255, 255, 255),
                Color.fromARGB(0, 255, 255, 255),
                Color.fromARGB(0, 255, 255, 255),
                Colors.white,
              ],
              center: Alignment.centerRight,
              radius: 0.8,
            ),
          ),
        ),
        Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(40.0),
            child: Row(
              children: [
                Text(
                  'DIA',
                  style: TextStyle(
                    fontSize: 30,
                    height: 5,
                  ),
                ),
                Text(
                  '30',
                  style: TextStyle(
                    fontSize: 40,
                    height: 4,
                    color: Colors.purple[900],
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )),
      ],
    );
  }
}
