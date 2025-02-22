import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/ui/join_trip/store/join_trip_store.dart';
import 'package:ecotrip/ui/join_trip/widgets/trip_offer_card.dart';
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class JoinScheduledScreen extends StatefulWidget {
  @override
  _JoinScheduledScreenState createState() => _JoinScheduledScreenState();
}

class _JoinScheduledScreenState extends State<JoinScheduledScreen> {
  late JoinTripStore _store;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = getIt<JoinTripStore>();
    Geolocator.getCurrentPosition().then((position) {
      _store.listNearbyTrips(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'join_scheduled_trip_title'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text("Viajes disponibles actualmente:"),
                TripOfferCard(
                  tripOffer: TripOffer(
                    tripId: 1,
                    totalSeats: 3,
                    type: 'scheduled',
                    cost: 123,
                    creator: 'Juan',
                    toLat: -26.82417,
                    toLon: -65.21999,
                    fromLat: -26.82417,
                    fromLon: -65.21999,
                    fromAddress: 'Calle 13, barrio B, Localidad 1',
                    toAddress: 'Calle 7, Barrio 2, Localidad 1',
                    timeOfDay: '12:00',
                    dayOfWeek: 'Lunes',
                    date: DateTime.now(),
                  ),
                ),
                TripOfferCard(
                  tripOffer: TripOffer(
                    tripId: 1,
                    totalSeats: 3,
                    type: 'scheduled',
                    cost: 123,
                    creator: 'Juan',
                    toLat: -26.82417,
                    toLon: -65.21999,
                    fromLat: -26.82417,
                    fromLon: -65.21999,
                    fromAddress: 'Calle 13, barrio B, Localidad 1',
                    toAddress: 'Calle 7, Barrio 2, Localidad 1',
                    timeOfDay: '12:00',
                    dayOfWeek: 'Lunes',
                    date: DateTime.now(),
                  ),
                ),
                TripOfferCard(
                  tripOffer: TripOffer(
                    tripId: 1,
                    totalSeats: 3,
                    type: 'scheduled',
                    cost: 123,
                    creator: 'Juan',
                    toLat: -26.82417,
                    toLon: -65.21999,
                    fromLat: -26.82417,
                    fromLon: -65.21999,
                    fromAddress: 'Calle 13, barrio B, Localidad 1',
                    toAddress: 'Calle 7, Barrio 2, Localidad 1',
                    timeOfDay: '12:00',
                    dayOfWeek: 'Lunes',
                    date: DateTime.now(),
                  ),
                ),
                TripOfferCard(
                  tripOffer: TripOffer(
                    tripId: 1,
                    totalSeats: 3,
                    type: 'scheduled',
                    cost: 123,
                    creator: 'Juan',
                    toLat: -26.82417,
                    toLon: -65.21999,
                    fromLat: -26.82417,
                    fromLon: -65.21999,
                    fromAddress: 'Calle 13, barrio B, Localidad 1',
                    toAddress: 'Calle 7, Barrio 2, Localidad 1',
                    timeOfDay: '12:00',
                    dayOfWeek: 'Lunes',
                    date: DateTime.now(),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        _buildTextButton("/join_scheduled_trip_map")
      ],
    );
  }

  Widget _buildTextButton(route) {
    return Positioned(
      bottom: 20,
      left: MediaQuery.of(context).size.width * 0.2,
      right: MediaQuery.of(context).size.width * 0.2,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.lime,
        ),
        child: TextButton(
          onPressed: () => Navigator.of(context).pushNamed(route),
          child: Text(
            'VER MAPA',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
