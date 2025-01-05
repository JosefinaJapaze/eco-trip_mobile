import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/trip/trip.dart';
import '../../stores/trip/trip_store.dart';

class JoinFrecuentScreen extends StatefulWidget {
  @override
  _JoinFrecuentScreenState createState() => _JoinFrecuentScreenState();
}

class _JoinFrecuentScreenState extends State<JoinFrecuentScreen> {
  //stores:---------------------------------------------------------------------
  late TripStore _tripStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _tripStore = Provider.of<TripStore>(context);

    // check to see if already called api
    if (!_tripStore.loading) {
      _tripStore.getTrips();
    }
  }

  void insertTrip() {
    _tripStore
        .insertTrip(Trip(
            hasStarted: false,
            isFinished: false,
            seatsLeft: 1, // sacar
            cost: 982, // sacar
            type: "frequent",
            userId: '' // sacar del auth,
            ))
        .then((value) => {Navigator.of(context).pushNamed("/join_request")});
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Viajes disponibles actualmente:"),
          _buildTripHistoryCard("/join_request"),
          _buildTripHistoryCard("/join_request"),
          _buildTextButton("/join_frecuent_trip_map")
        ],
      ),
    );
  }

  Widget _buildTextButton(route) {
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
                    'VER MAPA',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )),
            ])));
  }

  Card _buildTripHistoryCard(route) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      color: Colors.black87,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '1 asiento disponible',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          ListTile(
            subtitle: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: Colors.lime,
                          ),
                          Text(
                            'Calle 13, barrio B, Localidad 1',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: Colors.grey,
                          ),
                          Text(
                            'Calle 7, Barrio 2, Localidad 1',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '\$982',
                  style: TextStyle(
                      color: Colors.lime, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () => {insertTrip()},
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.resolveWith(
                                  (states) => Colors.white),
                              shape: WidgetStateProperty.all(StadiumBorder())),
                          child: Text(
                            'Unirme',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )),
                      Text(
                        '02/05/2022',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
