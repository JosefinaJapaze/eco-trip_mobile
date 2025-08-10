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
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Text(
              "No se poseen viajes programados actualmente. Puedes crear o unirte a un viaje desde la pestaña Nuevo Viaje",
              textAlign: TextAlign.center,
            ),
          ),
        ),
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
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
      color: Color.fromARGB(255, 242, 255, 244),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            // Status and cost section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Sin iniciar',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${trip.cost}",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 15),

            // Route visualization
            Row(
              children: [
                SizedBox(width: 10),
                Column(
                  children: [
                    Icon(Icons.circle, color: Colors.lime, size: 12),
                    Container(
                      height: 30,
                      width: 2,
                      color: Colors.grey,
                    ),
                    Icon(Icons.circle, color: Colors.yellow, size: 12),
                  ],
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.addressFrom?.address ?? 'N/A',
                        style: TextStyle(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Text(
                        trip.addressTo?.address ?? 'N/A',
                        style: TextStyle(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            // Date and action button section
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.type == "frequent" ? 'Día y hora' : 'Fecha de viaje',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        trip.type == "frequent" 
                          ? "Frecuente" // You might want to show actual day/time if available
                          : (trip.scheduledTripParams?.startDate != null
                              ? trip.scheduledTripParams!.startDate!.toString().split(' ').first
                              : 'N/A'),
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/trip_route", arguments: trip);
                      },
                      child: Text(
                        'Recorrido',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
