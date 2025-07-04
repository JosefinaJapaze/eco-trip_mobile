import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/ui/my_trips/store/my_trips_store.dart';
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:ecotrip/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../models/trip/trip.dart';

class MyTripsScreen extends StatefulWidget {
  @override
  _MyTripsScreenState createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  late MyTripsStore _tripStore;

  bool displayFrequent = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tripStore = getIt<MyTripsStore>();
    _tripStore.fetchTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'my_trips_title'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTripOptions(),
                Observer(
                  builder: (context) {
                    if (_tripStore.isLoading) {
                      return Container();
                    }
                    return Column(
                      children: _buildTripHistory(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _tripStore.isLoading,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
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
              ),
              )
        ]),
      ),
    );
  }

  List<Widget> _buildTripHistory() {
    if (_tripStore.tripsFuture.status == FutureStatus.rejected ||
        _tripStore.tripsFuture.value == null ||
        _tripStore.tripsFuture.value!.isEmpty) {
      return <Widget>[
        Text("No se poseen viajes programados actualmente."
            "Puedes crear o unirte a un viaje desde la pestaña Nuevo Viaje")
      ];
    }

    final List<Widget> cards = <Widget>[];
    _tripStore.tripsFuture.value!.forEach((element) {
      if (element.type == "frequent" && displayFrequent) {
        cards.add(_buildTripHistoryCard(element));
      }

      if (element.type == "scheduled" && !displayFrequent) {
        cards.add(_buildTripHistoryCard(element));
      }
    });

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
                          Flexible(
                            child: Text(
                              trip.addressFrom?.address ?? 'N/A',
                              style: TextStyle(color: Colors.black),
                            ),
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
                          Flexible(
                            child: Text(
                              trip.addressTo?.address ?? 'N/A',
                              style: TextStyle(color: Colors.black),
                            ),
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
                          onPressed: () => {
                                Navigator.of(context).pushNamed("/trip_route",
                                    arguments: trip)
                              },
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
