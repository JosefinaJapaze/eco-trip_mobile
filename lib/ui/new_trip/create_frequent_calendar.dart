import 'package:ecotrip/data/network/apis/trip/trip_api.dart';
import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/models/trip/trip.dart';
import 'package:ecotrip/ui/new_trip/store/new_trip_store.dart';
import 'package:ecotrip/utils/routes/routes.dart';
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class CreateFrequentCalendarScreen extends StatefulWidget {
  @override
  _CreateFrequentCalendarScreenState createState() =>
      _CreateFrequentCalendarScreenState();
}

class _CreateFrequentCalendarScreenState
    extends State<CreateFrequentCalendarScreen> {
  late NewTripStore _store;

  final TextEditingController _asController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  double? cost;
  GeoPoint? geoPointOrigin;
  GeoPoint? geoPointDestination;
  DayOfWeek? selectedDay;
  int? selectedHour;
  int totalSeats = 0;

  String intSelectedTimeToString(int time) {
    int minute = time % 100;
    int hour = time ~/ 100;
    if (time < 59) {
      return '00:${minute.toString().padLeft(2, '0')}';
    }
    if (time < 1000) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  bool canInsertTrip() {
    return selectedDay != null && selectedHour != null && _asController.text.isNotEmpty && _costController.text.isNotEmpty;
  }

  void handleSelectedDay(DayOfWeek day) {
    setState(() {
      selectedDay = day;
    });
  }

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
    if (!canInsertTrip()) {
      return;
    }
    try {
      this.cost = double.parse(_costController.value.text);
      this.totalSeats = int.parse(_asController.value.text);
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
        availableSeats: totalSeats,
        cost: cost!,
        type: 'frequent',
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
      appBar: BaseAppBar(titleKey: 'join_frequent_trip_title'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Seleccione el dia de la semana',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 8,
                  child: TextButton(
                    onPressed: () {
                      handleSelectedDay(DayOfWeek.LUNES);
                    },
                    child: Text("Lun"),
                    style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      backgroundColor: selectedDay == DayOfWeek.LUNES
                          ? Colors.lime
                          : Colors.white,
                      side: BorderSide(color: Colors.lime, width: 3),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 8,
                  child: TextButton(
                    onPressed: () {
                      handleSelectedDay(DayOfWeek.MARTES);
                    },
                    child: Text("Mar"),
                    style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      backgroundColor: selectedDay == DayOfWeek.MARTES
                          ? Colors.lime
                          : Colors.white,
                      side: BorderSide(color: Colors.lime, width: 3),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 8,
                  child: TextButton(
                    onPressed: () {
                      handleSelectedDay(DayOfWeek.MIERCOLES);
                    },
                    child: Text("Mie"),
                    style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      backgroundColor: selectedDay == DayOfWeek.MIERCOLES
                          ? Colors.lime
                          : Colors.white,
                      side: BorderSide(color: Colors.lime, width: 3),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 8,
                  child: TextButton(
                    onPressed: () {
                      handleSelectedDay(DayOfWeek.JUEVES);
                    },
                    child: Text("Jue"),
                    style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      backgroundColor: selectedDay == DayOfWeek.JUEVES
                          ? Colors.lime
                          : Colors.white,
                      side: BorderSide(color: Colors.lime, width: 3),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 8,
                  child: TextButton(
                    onPressed: () {
                      handleSelectedDay(DayOfWeek.VIERNES);
                    },
                    child: Text("Vie"),
                    style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      backgroundColor: selectedDay == DayOfWeek.VIERNES
                          ? Colors.lime
                          : Colors.white,
                      side: BorderSide(color: Colors.lime, width: 3),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 8,
                  child: TextButton(
                    onPressed: () {
                      handleSelectedDay(DayOfWeek.SABADO);
                    },
                    child: Text("Sab"),
                    style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      backgroundColor: selectedDay == DayOfWeek.SABADO
                          ? Colors.lime
                          : Colors.white,
                      side: BorderSide(color: Colors.lime, width: 3),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 8,
                  child: TextButton(
                    onPressed: () {
                      handleSelectedDay(DayOfWeek.DOMINGO);
                    },
                    child: Text("Dom"),
                    style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      backgroundColor: selectedDay == DayOfWeek.DOMINGO
                          ? Colors.lime
                          : Colors.white,
                      side: BorderSide(color: Colors.lime, width: 3),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          selectedHour == null
              ? Container()
              : Text('Hora seleccionada'),
          _buildElevatedButtonSelectHour(),
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
                  borderSide: BorderSide(width: 3, color: Colors.black),
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
                  borderSide: BorderSide(width: 3, color: Colors.black),
                ),
              ),
            ),
          ),
          _buildTextButtonFindTrips(Routes.create_request),
        ],
      ),
    );
  }

  Widget _buildElevatedButtonSelectHour() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lime,
        foregroundColor: Colors.black,
      ),
      onPressed: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.inputOnly,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: Colors.lime,
                      secondary: Colors.lime,
                      surface: Colors.white,
                      primaryContainer: Colors.white,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    alwaysUse24HourFormat: true,
                  ),
                  child: child!,
                ),
              ),
            );
          },
        );
        if (time != null) {
          setState(() {
            selectedHour = int.parse("${time.hour}${time.minute}");
          });
        }
      },
      child: selectedHour != null
          ? Text(intSelectedTimeToString(selectedHour!))
          : Text('Seleccionar hora...'),
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
