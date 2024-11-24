import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class CreateProgrammedMapScreen extends StatefulWidget {
  @override
  _CreateProgrammedMapScreenState createState() =>
      _CreateProgrammedMapScreenState();
}

class _CreateProgrammedMapScreenState extends State<CreateProgrammedMapScreen> {
  //stores:---------------------------------------------------------------------
  late MapController controller;

  @override
  void initState() {
    super.initState();
    controller = MapController.withUserPosition(
      trackUserLocation: UserTrackingOption(
        enableTracking: true,
        unFollowUser: false,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'join_programmed_trip_title'),
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
              _buildTextButtonNext("/create_programmed_trip_calendar")
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
          zoomOption: ZoomOption(initZoom: 16),
          userTrackingOption: UserTrackingOption(
            enableTracking: true,
            unFollowUser: false,
          ),
        ),
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
              color: Colors.white70,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                onPressed: () => {},
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.my_location_outlined, color: Colors.lime),
                      SizedBox(width: 10),
                      Text(
                        'Origen',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Container(
                          child: Icon(Icons.arrow_drop_down,
                              color: Colors.black54)),
                      SizedBox(width: 10),
                      Text(
                        'Destino',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )
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
