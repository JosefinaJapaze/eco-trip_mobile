import 'package:ecotrip/data/repository.dart';
import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/utils/routes/routes.dart';
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:ecotrip/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NewTripScreen extends StatefulWidget {
  @override
  _NewTripScreenState createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  late Repository _repository;
  String? userType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repository = getIt<Repository>();
    _repository.userType.then((value) => setState(() {
          userType = value ?? "";
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'new_trip_title'),
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
                'Seleccione el tipo de viaje',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'que desea iniciar:',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              _buildTripTypeScheduled(),
                _buildTripTypeFrequent(),
              ],
            ),
        ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: userType == null,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
    );
  }

  Widget _buildTripTypeScheduled() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        height: 60,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => {
                print(userType),
                if (userType == "passenger") {
                  Navigator.of(context).pushNamed(Routes.join_scheduled_trip)
                } else {
                  Navigator.of(context).pushNamed(Routes.new_scheduled)
                }
                },
              child: Text(
                'Viajes programados',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripTypeFrequent() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        height: 60,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => {
                if (userType == "passenger") {
                  Navigator.of(context).pushNamed(Routes.join_frequent_trip)
                } else {
                  Navigator.of(context).pushNamed(Routes.new_frequent)
                }
                },
              child: Text(
                'Viajes frecuentes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
