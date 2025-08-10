import 'package:another_flushbar/flushbar_helper.dart';
import 'package:ecotrip/data/network/apis/trip/trip_api.dart';
import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/models/trip/trip.dart';
import 'package:ecotrip/ui/new_trip/store/new_trip_store.dart';
import 'package:ecotrip/utils/routes/routes.dart';
import 'package:ecotrip/utils/time/time_utils.dart' as time_utils;
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:ecotrip/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class CreateFrequentCalendarScreen extends StatefulWidget {
  @override
  _CreateFrequentCalendarScreenState createState() =>
      _CreateFrequentCalendarScreenState();
}

class _CreateFrequentCalendarScreenState
    extends State<CreateFrequentCalendarScreen> {
  late NewTripStore _store;

  final TextEditingController _totalSeatsController = TextEditingController();
  String _totalSeatsError = "";
  final TextEditingController _costController = TextEditingController();
  String _costError = "";
  double? cost;
  GeoPoint? geoPointOrigin;
  GeoPoint? geoPointDestination;
  DayOfWeek? selectedDay;
  int? selectedHour;
  int totalSeats = 0;



  bool canInsertTrip() {
    return selectedDay != null && 
           selectedHour != null && 
           _totalSeatsController.text.isNotEmpty && 
           _costController.text.isNotEmpty;
  }

  void showValidationError() {
    if (selectedDay == null) {
      _showErrorMessage("Seleccione un dia");
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
      showValidationError();
      return;
    }
    setState(() {
      _costError = "";
      _totalSeatsError = "";
    });

    try {
      cost = double.parse(_costController.value.text);
    } catch (e) {
      setState(() {
        _costError = "Ingrese un costo valido";
      });
      return;
    }
    try {
      totalSeats = int.parse(_totalSeatsController.value.text);
    } catch (e) {
      setState(() {
        _totalSeatsError = "Ingrese un numero valido";
      });
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
        totalSeats: totalSeats,
        cost: cost!,
        type: 'frequent',
        frequentTripParams: FrequentTripParams(
          dayOfWeek: selectedDay!,
          startTime: selectedHour!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    geoPointOrigin = args['origin'];
    geoPointDestination = args['destination'];
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'join_frequent_trip_title'),
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
                          textStyle: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
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
                          textStyle: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
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
                          textStyle: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
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
                          textStyle: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
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
                          textStyle: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
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
                          textStyle: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
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
                          textStyle: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
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
                  onChanged: (value) {
                    setState(() {
                      _totalSeatsError = "";
                    });
                  },
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
                  onChanged: (value) {
                    setState(() {
                      _costError = "";
                    });
                  },
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
            selectedHour = time_utils.parseTimeOfDay("${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}");
          });
        }
      },
      child: selectedHour != null
          ? Text(time_utils.intSelectedTimeToString(selectedHour!))
          : Text('Seleccionar hora...'),
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
