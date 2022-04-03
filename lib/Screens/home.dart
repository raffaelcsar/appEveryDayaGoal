import 'package:everydayagoal/Feature/notification.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

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
    double appendDistance;

    _location.onLocationChanged.listen((event) {
      LatLng local = LatLng(event.latitude!, event.longitude!);
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: local, zoom: 18.0)));

      if (route.length > 0) {
        appendDistance = Geolocator.distanceBetween(route.last.latitude,
            route.last.longitude, local.latitude, local.longitude);
        _distance = _distance + appendDistance;
        int timeDuration = (_time! - _lastTime!);

        if (_lastTime != null && timeDuration != 0) {
          _speed = (appendDistance / (timeDuration / 100)) * 3.6;

          if (_speed != 0) {
            _avgSpeed = _avgSpeed + _speed;
            _speedCount++;
          }
        }
      }
      _lastTime = _time;
      route.add(local);

      polyline.add(Polyline(
          polylineId: PolylineId(event.toString()),
          visible: true,
          points: route,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          color: Colors.deepPurple));

      setState(() {});
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
        _radialEffects(),
        _countDays(),
        // _buttonNotification(),
        _informationOfRun(),
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

  Widget _radialEffects() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Color.fromARGB(0, 255, 255, 255),
            Color.fromARGB(0, 255, 255, 255),
          ],
          stops: [0.4, 0.6, 1],
        ),
      ),
    );
  }

  // Widget _buttonNotification() {
  //   return GestureDetector(
  //     onTap: () {
  //       NotificationService()
  //           .showNotification(1, "Every Day a Goal", "Teste", 1);
  //     },
  //     child: Container(
  //       height: 40,
  //       width: 200,
  //       color: Colors.deepPurple,
  //       child: Center(
  //         child: Text(
  //           "Gerar Notificação!",
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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

  Widget _informationOfRun() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        height: 280,
        padding: EdgeInsets.fromLTRB(20, 100, 20, 10),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Color.fromARGB(0, 255, 255, 255),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.7, 1])),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Column on Distance

              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.show_chart_rounded,
                          color: Colors.black, size: 30.0),
                      Text("Distância",
                          style: GoogleFonts.kanit(
                              fontSize: 10, fontWeight: FontWeight.w300)),
                    ],
                  ),
                  Text(
                    ((_distance / 1000).toStringAsFixed(2)),
                    style: GoogleFonts.kanit(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple),
                  ),
                ],
              ),

              //Column on Speed

              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.speed, color: Colors.black, size: 30.0),
                      Text("Velocidade",
                          style: GoogleFonts.kanit(
                              fontSize: 10, fontWeight: FontWeight.w300)),
                    ],
                  ),
                  Text(
                    _speed.toStringAsFixed(2),
                    style: GoogleFonts.kanit(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple),
                  ),
                ],
              ),

              // Column on Time

              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer_outlined,
                          color: Colors.black, size: 30.0),
                      Text("Tempo",
                          style: GoogleFonts.kanit(
                              fontSize: 10, fontWeight: FontWeight.w300)),
                    ],
                  ),
                  StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: 0,
                      builder: (context, snap) {
                        _time = snap.data;
                        _displayTime =
                            StopWatchTimer.getDisplayTimeHours(_time!) +
                                ":" +
                                StopWatchTimer.getDisplayTimeMinute(_time!) +
                                ":" +
                                StopWatchTimer.getDisplayTimeSecond(_time!);
                        return Text(
                          _displayTime!,
                          style: GoogleFonts.kanit(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepPurple),
                        );
                      })
                ],
              ),
            ],
          ),
          _buttonStartAndStop(),
        ]),
      ),
    );
  }

  Widget _statusOfRun() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.speed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buttonStartAndStop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30.0, right: 10.0),
          child: GestureDetector(
            onTap: () {
              NotificationService()
                  .showNotification(1, "Every Day a Goal", "Teste", 1);
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: Colors.deepPurple,
              ),
              child: Icon(
                Icons.play_arrow,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30.0, left: 10.0),
          child: GestureDetector(
            onTap: () {
              NotificationService()
                  .showNotification(1, "Every Day a Goal", "Teste", 1);
            },
            child: Container(
              width: 90,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: Colors.redAccent,
              ),
              child: Icon(Icons.stop, size: 40, color: Colors.white),
              // GestureDetector(onTap: () {}),
            ),
          ),
        ),
      ],
    );
  }
}
