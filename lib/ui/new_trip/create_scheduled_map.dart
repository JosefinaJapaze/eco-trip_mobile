import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/ui/new_trip/store/new_trip_store.dart';
import 'package:ecotrip/utils/routes/routes.dart';
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class CreateScheduledMapScreen extends StatefulWidget {
  @override
  _CreateScheduledMapScreenState createState() =>
      _CreateScheduledMapScreenState();
}

class _CreateScheduledMapScreenState extends State<CreateScheduledMapScreen> {
  late MapController controller;
  GeoPoint? geoPointOrigin;
  GeoPoint? geoPointDestination;
  RoadInfo? selectedRoad;

  String helperText = 'Seleccionar origen';

  late NewTripStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = getIt<NewTripStore>();
  }

  @override
  void initState() {
    super.initState();
    controller = MapController.withUserPosition(
      trackUserLocation: UserTrackingOption(
        enableTracking: true,
        unFollowUser: false,
      ),
    );

    controller.listenerMapSingleTapping.addListener(() {
      final geoPoint = controller.listenerMapSingleTapping.value;
      if (geoPoint == null) return;

      if (geoPointOrigin == null) {
        geoPointOrigin = geoPoint;
        setState(() {
          helperText = 'Seleccionar destino';
        });
        _addMarker(geoPointOrigin!);
      } else if (geoPointDestination == null) {
        geoPointDestination = geoPoint;
        setState(() {
          helperText = 'Todo listo';
        });
        _addMarker(geoPointDestination!);
      }

      if (geoPointOrigin != null && geoPointDestination != null) {
        final dest = geoPointDestination as GeoPoint;
        final origin = geoPointOrigin as GeoPoint;
        controller
            .drawRoad(
          origin,
          dest,
          roadOption: RoadOption(
              roadColor: Colors.green,
              roadWidth: 10,
              roadBorderWidth: 10,
              roadBorderColor: Colors.green),
        )
            .then((road) {
          selectedRoad = road;
        });
      }
    });
  }

  void _addMarker(GeoPoint geoPoint) {
    controller.addMarker(
      geoPoint,
      markerIcon: MarkerIcon(
        icon: Icon(
          Icons.location_on,
          color: Colors.blue,
          size: 40,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'join_programmed_trip_title'),
      body: _buildBody(),
    );
  }

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
              _buildTextButtonNext(Routes.create_scheduled_trip_calendar)
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
        width: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white70,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => {},
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      helperText == 'Todo listo'
                          ? Icons.check
                          : Icons.my_location_outlined,
                      color: Colors.lime,
                    ),
                    SizedBox(width: 10),
                    Text(
                      helperText,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextButtonNext(route) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: helperText == 'Todo listo' ? Colors.lime : Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => {
                      if (helperText == 'Todo listo')
                        createScheduledTrip(context)
                    },
                child: Text(
                  'SIGUIENTE',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void createScheduledTrip(BuildContext context) {
    if (geoPointDestination == null || geoPointOrigin == null) {
      _store.errorStore.errorMessage = 'Selecciona un origen y destino';
      return;
    }
    Navigator.of(context)
        .pushNamed(Routes.create_frecuent_trip_calendar, arguments: {
      'origin': geoPointOrigin,
      'destination': geoPointDestination,
    });
  }
}
