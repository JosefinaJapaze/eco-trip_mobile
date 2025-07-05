import 'package:ecotrip/ui/join_trip/store/join_trip_store.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TripOffer {
  final int tripId;
  final int totalSeats;
  final String type;
  final double cost;
  final String creator;
  final double toLat;
  final double toLon;
  final double fromLat;
  final double fromLon;
  final String fromAddress;
  final String toAddress;
  final String timeOfDay;
  final String dayOfWeek;
  final DateTime date;

  TripOffer({
    required this.tripId,
    required this.totalSeats,
    required this.type,
    required this.cost,
    required this.creator,
    required this.toLat,
    required this.toLon,
    required this.fromLat,
    required this.fromLon,
    required this.fromAddress,
    required this.toAddress,
    required this.timeOfDay,
    required this.dayOfWeek,
    required this.date,
  });
}

class TripOfferCard extends StatelessWidget {
  final TripOffer tripOffer;
  final Function(String) joinTrip;

  TripOfferCard({required this.tripOffer, required this.joinTrip});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
      color: Color.fromARGB(255, 242, 255, 244),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lime,
                      ),
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Text(tripOffer.creator),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("\$${tripOffer.cost.toStringAsFixed(2)}"),
                    Text("Quedan ${tripOffer.totalSeats} asientos", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              children: [
                SizedBox(width: 30),
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
                        tripOffer.fromAddress,
                        style: TextStyle(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Text(
                        tripOffer.toAddress,
                        style: TextStyle(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tripOffer.type == "frequent" ? 'Día y hora' : 'Fecha de viaje',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      tripOffer.type == "frequent" 
                        ? "${tripOffer.dayOfWeek} ${tripOffer.timeOfDay}"
                        : "${DateFormat('dd/MM/yyyy').format(tripOffer.date)} ${tripOffer.timeOfDay}",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.lime,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      joinTrip(tripOffer.tripId.toString());
                    },

                    child: Text(
                      'Unirse',
                      style: TextStyle(
                        color: Colors.black,
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
