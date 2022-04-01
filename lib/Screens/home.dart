import 'package:everydayagoal/Feature/notification.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:stop_watch_timer/stop_watch_timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Set<Polyline> polyline = {};
  Location _location = Location();
  GoogleMapController? _mapController;
  LatLng _latLng = const LatLng(0.0, 0.0);
  List<LatLng> route = [];

  double _distance = 0;
  String? _displayTime;
  int? _time;
  int? _lastTime;
  double _speed = 0;
  double _avgSpeed = 0;
  int _speedCount = 0;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

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
            Expanded(child: _googleMaps()),
          ],
        ),
        _radialEfects(),
        _buttonNotification(),
        _countDays()
      ],
    );
  }

  Widget _googleMaps() {
    return GoogleMap(
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: _createdMap,
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(target: _latLng, zoom: 16.0),
    );
  }

  Widget _radialEfects() {
    return Container(
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
    );
  }

  Widget _buttonNotification() {
    return GestureDetector(
      onTap: () {
        NotificationService()
            .showNotification(1, "Every Day a Goal", "Meta Alcançada", 1);
      },
      child: Container(
        height: 40,
        width: 200,
        color: Colors.deepPurple,
        child: Center(
          child: Text(
            "Gerar Notificação!",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _countDays() {
    return Container(
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
      ),
    );
  }
}
