import 'dart:async';

import 'package:ecotrip/models/trip/trip.dart';
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class TripRouteScreen extends StatefulWidget {
  @override
  _TripRouteScreenState createState() => _TripRouteScreenState();
}

class _TripRouteScreenState extends State<TripRouteScreen> {
  late MapController controller;
  Trip? trip;
  bool hasDrawn = false;
  bool mapReady = false;

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initMapWithUserPosition: UserTrackingOption(enableTracking: true),
    );
  }

  Future<void> drawMap() async {
    if (hasDrawn || trip == null || !mapReady) return;

    hasDrawn = true;
    await controller.clearAllRoads();

    final from = GeoPoint(
      latitude: trip!.addressFrom?.latitude ?? 0.0,
      longitude: trip!.addressFrom?.longitude ?? 0.0,
    );
    final to = GeoPoint(
      latitude: trip!.addressTo?.latitude ?? 0.0,
      longitude: trip!.addressTo?.longitude ?? 0.0,
    );

    await controller.addMarker(from);
    await controller.addMarker(to);
    await controller.drawRoad(
      from,
      to,
      roadType: RoadType.car,
      roadOption: RoadOption(
        roadWidth: 15,
        roadColor: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Trip) {
      trip = args;
      // If map is already ready, schedule a draw; otherwise the listener will handle it
      if (mapReady) {
        WidgetsBinding.instance.addPostFrameCallback((_) => drawMap());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'trip_route'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(children: [
      _buildMap(),
    ]);
  }

  Widget _buildMap() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: OSMFlutter(
        onMapIsReady: (isReady) async {
          if (isReady && !mapReady) {
            mapReady = true;
            WidgetsBinding.instance.addPostFrameCallback((_) => drawMap());
          }
        },
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
}
