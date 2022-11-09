import 'package:boilerplate/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class JoinFrecuentMapScreen extends StatefulWidget {
  @override
  _JoinFrecuentMapScreenState createState() => _JoinFrecuentMapScreenState();
}

class _JoinFrecuentMapScreenState extends State<JoinFrecuentMapScreen> {
  //stores:---------------------------------------------------------------------
  late MapController controller;

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(latitude: -26.8274, longitude: -65.2078)
    );
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
          initZoom: 14,
          controller: controller,
          markerOption: MarkerOption(
            defaultMarker: MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.blue,
                size: 56,
              ),
            ),
          ),
          trackMyPosition: false,
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
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                  onPressed: () => {
                  },
                  child:
                  Row(
                    children: [
                      Icon(Icons.search, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Ingrese su destino',
                        style:
                        TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  )
                  ),
            ]
            )
        ));
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
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                  onPressed: () => {
                    Navigator.of(context).pushNamed(route)
                  },
                  child: Text(
                    'SIGUIENTE',
                    style:
                    TextStyle(
                      color: Colors.black,
                    ),
                  )),
            ]
            )
        ));
  }
}