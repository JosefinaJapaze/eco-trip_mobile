import 'package:ecotrip/data/network/apis/trip/trip_api.dart';
import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/ui/new_trip/store/new_trip_store.dart';
import 'package:ecotrip/utils/routes/routes.dart';
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:ecotrip/widgets/error_message_widget.dart';
import 'package:ecotrip/widgets/navigate_widget.dart';
import 'package:ecotrip/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class CreateFrecuentCalendarScreen extends StatefulWidget {
  @override
  _CreateFrecuentCalendarScreenState createState() =>
      _CreateFrecuentCalendarScreenState();
}

class _CreateFrecuentCalendarScreenState
    extends State<CreateFrecuentCalendarScreen> {
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
      appBar: BaseAppBar(titleKey: 'join_programmed_trip_title'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Seleccione los días del recorrido',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  'Seleccione la hora',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                _buildDropDownButton(),
                SizedBox(height: 12),
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
                      borderSide: BorderSide(
                          width: 3, color: Colors.black), //<-- SEE HERE
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Ingrese costo:',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: _costController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Colors.black), //<-- SEE HERE
                    ),
                  ),
                ),
                _buildTextButtonFindTrips("/create_request"),
              ],
            ),
          ),
        ),
        Observer(builder: (context) {
          if (_store.success) {
            return NavigateWidget(Routes.home);
          }
          return ErrorMessageWidget(_store.errorStore.errorMessage);
        }),
        Observer(builder: (_) {
          return Visibility(
              visible: _store.isLoading,
              child: CustomProgressIndicatorWidget());
        })
      ],
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
