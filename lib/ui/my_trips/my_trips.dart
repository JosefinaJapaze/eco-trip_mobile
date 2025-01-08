import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

import '../../models/trip/trip.dart';

class MyTripsScreen extends StatefulWidget {
  @override
  _MyTripsScreenState createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {

  late List<Widget> cards;

  bool displayFrequent = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'my_trips_title'),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------Widget _buildBody() {
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTripOptions(),
            ..._buildTripHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildTripOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
              onPressed: () => {
                    setState(() {
                      displayFrequent = false;
                    })
                  },
              child: Text(
                'Viajes programados',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: displayFrequent ? 14 : 16,
                ),
              )),
          TextButton(
              onPressed: () => {
                    setState(() {
                      displayFrequent = true;
                    })
                  },
              child: Text(
                'Viajes frecuentes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: displayFrequent ? 16 : 14,
                ),
              ))
        ]),
      ),
    );
  }

  List<Widget> _buildTripHistory() {
    //if (_tripStore.tripList == null || _tripStore.tripList!.trips == null) {
      //return <Widget>[
        //Text("No se poseen viajes programados actualmente."
            //"Puedes crear o unirte a un viaje desde la pestaña Nuevo Viaje")
      //];
    //}

    cards = <Widget>[];
    //_tripStore.tripList!.trips!.forEach((element) {
      //if (element.type == "frequent" && displayFrequent) {
        //cards.add(_buildTripHistoryCard(element));
      //}

      //if (element.type == "programmed" && !displayFrequent) {
        //cards.add(_buildTripHistoryCard(element));
      //}
    //});

    return cards;
  }

  Card _buildTripHistoryCard(Trip trip) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      color: Theme.of(context).colorScheme.tertiary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sin iniciar',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
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
                            Icons.call_made,
                            color: Colors.black,
                          ),
                          Text(
                            'Calle 13, Barrio B, Localidad 1',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call_received,
                            color: Colors.black,
                          ),
                          Text(
                            'Calle 7, Barrio 2, Localidad 1',
                            style: TextStyle(color: Colors.black),
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
                  '\$${trip.cost}',
                  style: TextStyle(
                      color: Colors.indigo, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () =>
                              {Navigator.of(context).pushNamed("/trip_route")},
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.resolveWith(
                                  (states) => Colors.black),
                              shape: WidgetStateProperty.all(StadiumBorder())),
                          child: Text(
                            'Recorrido',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                      Text(
                        '02/05/2022',
                        style: TextStyle(
                            color: Colors.black45, fontWeight: FontWeight.bold),
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
