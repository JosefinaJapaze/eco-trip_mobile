import 'package:another_flushbar/flushbar_helper.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:ecotrip/data/network/apis/trip/trip_api.dart';
import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/ui/new_trip/store/new_trip_store.dart';
import 'package:ecotrip/utils/locale/app_localization.dart';
import 'package:ecotrip/utils/routes/routes.dart';
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class CreateScheduledCalendarScreen extends StatefulWidget {
  @override
  _CreateScheduledCalendarScreenState createState() =>
      _CreateScheduledCalendarScreenState();
}

class _CreateScheduledCalendarScreenState
    extends State<CreateScheduledCalendarScreen> {
  late NewTripStore _store;

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
  GeoPoint? geoPointOrigin;
  GeoPoint? geoPointDestination;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = getIt<NewTripStore>();
  }

  void insertTrip() {
    try {
      this.cost = double.parse(_costController.value.text);
      this.availableSeats = int.parse(_asController.value.text);
    } catch (e) {
      print(e);
      return;
    }
    _store.createNewTrip(
      CreateTripParams(
        origin: CreateTripAddress(
          address: 'origin',
          latitude: geoPointOrigin!.latitude,
          longitude: geoPointOrigin!.longitude,
        ),
        destination: CreateTripAddress(
          address: 'destination',
          latitude: geoPointDestination!.latitude,
          longitude: geoPointDestination!.longitude,
        ),
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        availableSeats: availableSeats!,
        cost: cost!,
        type: 'scheduled',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    geoPointDestination = args['origin'];
    geoPointOrigin = args['destination'];
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'join_scheduled_trip_title'),
      body: _buildBody(),
    );

  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Seleccione los dias de inicio y regreso del recorrido',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.range,
                firstDate: DateTime.now().add(Duration(days: 1)),
                lastDate: DateTime.now().add(Duration(days: 120)),
                currentDate: DateTime.now(),
              ),
              value: [startDate, endDate],
              onValueChanged: (value) {
                if (startDate == null) {
                  setState(() {
                    startDate = value[0];
                  });
                } else if (endDate == null) {
                  setState(() {
                    endDate = value[1];
                  });
                }
              },
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Seleccione la hora',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildDropDownButton(),
          SizedBox(height: 20),
          Text(
            'Ingrese lugares disponibles:',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: TextField(
              controller: _asController,
              decoration: InputDecoration(
                icon: Icon(Icons.people),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 3, color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Ingrese costo:',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: TextField(
              controller: _costController,
              decoration: InputDecoration(
                icon: Icon(Icons.attach_money),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 3, color: Colors.black),
                ),
              ),
            ),
          ),
          _buildTextButtonFindTrips(Routes.create_request),
        ],
      ),
    );
  }

  Widget _buildDropDownButton() {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57),
                blurRadius: 5)
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => {insertTrip()},
              child: Text(
                'CONFIRMAR',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
