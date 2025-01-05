import 'dart:async';

import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';

class JoinFrequentMapScreen extends StatefulWidget {
  @override
  _JoinFrequentMapScreenState createState() => _JoinFrequentMapScreenState();
}

class _JoinFrequentMapScreenState extends State<JoinFrequentMapScreen> {
  late MapController controller;

  Timer? timer;
  bool shouldDrawRoad = true;

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initMapWithUserPosition: UserTrackingOption(enableTracking: true),
      initPosition: GeoPoint(latitude: -26.8274, longitude: -65.2078),
    );
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => drawMap());
  }

  Future<void> drawMap() async {
    if (!shouldDrawRoad) {
      return;
    }

    shouldDrawRoad = false;
    await controller.clearAllRoads();
    var location = await _determinePosition();
    await controller.addMarker(
      GeoPoint(latitude: location.latitude, longitude: location.longitude),
    );
    await controller.drawRoad(
      GeoPoint(latitude: location.latitude, longitude: location.longitude),
      GeoPoint(latitude: -26.8350, longitude: -65.2150),
      roadType: RoadType.car,
      roadOption: RoadOption(
        roadWidth: 15,
        roadColor: Colors.blue,
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'join_frecuent_trip_title'),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------Widget _buildBody() {
  Widget _buildBody() {
    return Stack(children: [
      _buildMap(),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildTextButtonFind(),
              _buildTextButtonNext("/join_frecuent_trip_calendar")
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _buildMap() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: OSMFlutter(
        osmOption: OSMOption(
            userLocationMarker: UserLocationMaker(
              directionArrowMarker: MarkerIcon(
                icon: Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.blue,
                  size: 56,
                ),
              ),
              personMarker: MarkerIcon(
                icon: Icon(
                  Icons.person_pin_circle,
                  color: Colors.blue,
                  size: 56,
                ),
              ),
            ),
            zoomOption: ZoomOption(initZoom: 14),
            userTrackingOption: UserTrackingOption(enableTracking: false)),
        controller: controller,
      ),
    );
  }

  Widget _buildTextButtonFind() {
    return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                  onPressed: () => {},
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Ingrese su destino',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  )),
            ])));
  }

  Widget _buildTextButtonNext(route) {
    return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lime,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                  onPressed: () => {Navigator.of(context).pushNamed(route)},
                  child: Text(
                    'SIGUIENTE',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )),
            ])));
  }
}
