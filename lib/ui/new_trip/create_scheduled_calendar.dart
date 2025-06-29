import 'package:another_flushbar/flushbar_helper.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:ecotrip/data/network/apis/trip/trip_api.dart';
import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/models/trip/trip.dart';
import 'package:ecotrip/ui/new_trip/store/new_trip_store.dart';
import 'package:ecotrip/utils/routes/routes.dart';
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:ecotrip/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class CreateScheduledCalendarScreen extends StatefulWidget {
  @override
  _CreateScheduledCalendarScreenState createState() =>
      _CreateScheduledCalendarScreenState();
}

class _CreateScheduledCalendarScreenState
    extends State<CreateScheduledCalendarScreen> {
  late NewTripStore _store;

  final TextEditingController _totalSeatsController = TextEditingController();
  String _totalSeatsError = "";
  int? availableSeats;
  final TextEditingController _costController = TextEditingController();
  String _costError = "";
  double? cost;
  GeoPoint? geoPointOrigin;
  GeoPoint? geoPointDestination;
  DateTime? startDate;
  int? selectedHour;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = getIt<NewTripStore>();
  }

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
    return startDate != null && 
           selectedHour != null && 
           _totalSeatsController.text.isNotEmpty && 
           _costController.text.isNotEmpty;
  }

  void showValidationError() {
    if (startDate == null) {
      _showErrorMessage("Seleccione un dia de inicio");
      return;
    }
    if (selectedHour == null) {
      _showErrorMessage("Seleccione una hora");
      return;
    }
    if (_totalSeatsController.text.isEmpty) {
      _showErrorMessage("Ingrese el numero de asientos");
      return;
    }
    if (_costController.text.isEmpty) {
      _showErrorMessage("Ingrese el costo");
      return;
    }
  }

  void insertTrip() {
    if (!canInsertTrip()) {
      showValidationError();
      return;
    }

    try {
      cost = double.parse(_costController.value.text);
    } catch (e) {
      _costError = "Ingrese un costo valido";
      return;
    }

    try {
      availableSeats = int.parse(_totalSeatsController.value.text);
    } catch (e) {
      _totalSeatsError = "Ingrese un numero valido";
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
        totalSeats: availableSeats!,
        cost: cost!,
        type: 'scheduled',
        scheduledTripParams: ScheduledTripParams(
          startDate: startDate,
          startTime: intSelectedTimeToString(selectedHour!),
        ),
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
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Seleccione el dia de viaje',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.single,
                    firstDate: DateTime.now().add(Duration(days: 1)),
                    lastDate: DateTime.now().add(Duration(days: 120)),
                    currentDate: DateTime.now(),
                  ),
                  value: [startDate],
                  onValueChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        startDate = value[0];
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              selectedHour == null ? Container() : Text('Hora seleccionada'),
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
                  controller: _totalSeatsController,
                  decoration: InputDecoration(
                    errorText:
                        _totalSeatsError.isEmpty ? null : _totalSeatsError,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.red),
                    ),
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
                    errorText: _costError.isEmpty ? null : _costError,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.red),
                    ),
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
        ),
        Observer(
          builder: (context) {
            return _store.success
                ? navigate(context)
                : _showErrorMessage(_store.errorStore.errorMessage);
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _store.isLoading,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
    );
  }

  Widget _buildTextButtonFindTrips(route) {
    bool isValid = canInsertTrip();
    
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isValid ? Colors.lime : Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: isValid ? () => {insertTrip()} : null,
              child: Text(
                'CONFIRMAR',
                style: TextStyle(
                  color: isValid ? Colors.black : Colors.white,
                ),
              ),
            ),
          ],
        ),
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

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).popAndPushNamed(Routes.home);
    });
    return Container();
  }

  Widget _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: "Error",
            duration: Duration(seconds: 3),
          ).show(context);
        }
      });
    }
    return SizedBox.shrink();
  }
}
