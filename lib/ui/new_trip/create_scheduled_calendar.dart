import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/trip/trip.dart';
import '../../stores/trip/trip_store.dart';

class CreateScheduledCalendarScreen extends StatefulWidget {
  @override
  _CreateScheduledCalendarScreenState createState() =>
      _CreateScheduledCalendarScreenState();
}

class _CreateScheduledCalendarScreenState
    extends State<CreateScheduledCalendarScreen> {
  //stores:---------------------------------------------------------------------
  late TripStore _tripStore;

  final List<String> items = [
    '06:00hs',
    '12:00hs',
    '18:00hs',
    '00:00hs',
  ];
  String? selectedHour;

  final TextEditingController _asController = TextEditingController();
  int? availableSeats;
  final TextEditingController _costController = TextEditingController();
  double? cost;

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
    try {
      this.cost = double.parse(_costController.value.text);
      this.availableSeats = int.parse(_asController.value.text);
    } catch (e) {
      print(e);
      return;
    }

    _tripStore
        .insertTrip(Trip(
            hasStarted: false,
            isFinished: false,
            seatsLeft: this.availableSeats, // sacar
            cost: this.cost, // sacar
            type: "programmed",
            userId: '' // sacar del auth,
            ))
        .then((value) => {Navigator.of(context).pushNamed("/create_request")});
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Seleccione los días del recorrido',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Seleccione la hora',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildDropDownButton(),
          Text(
            'Ingrese lugares disponibles:',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _asController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 3, color: Colors.black), //<-- SEE HERE
              ),
            ),
          ),
          Text(
            'Ingrese costo o canje:',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _costController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 3, color: Colors.black), //<-- SEE HERE
              ),
            ),
          ),
          _buildTextButtonFindTrips("/create_request"),
        ],
      ),
    );
  }

  Widget _buildDropDownButton() {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          //background color of dropdown button
          border: Border.all(color: Colors.black, width: 3),
          //border of dropdown button
          boxShadow: <BoxShadow>[
            //apply shadow on Dropdown button
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                blurRadius: 5) //blur radius of shadow
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: DropdownButton(
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedHour,
          onChanged: (value) {
            setState(() {
              selectedHour = value as String;
            });
          },
        ),
      ),
    );
  }

  Widget _buildTextButtonFindTrips(route) {
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
                  onPressed: () => {insertTrip()},
                  child: Text(
                    'CONFIRMAR',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )),
            ])));
  }
}
