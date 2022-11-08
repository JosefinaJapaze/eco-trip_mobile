import 'package:boilerplate/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class NewTripScreen extends StatefulWidget {
  @override
  _NewTripScreenState createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'new_trip_title'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
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
          _buildTripTypeProgrammed(),
          _buildTripTypeFrecuent()
        ],
      ),
    );
  }

  Widget _buildTripTypeProgrammed() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        height: 60,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
              onPressed: () => {},
              child: Text(
                'Viajes programados',
                style:
                TextStyle(
                  color: Colors.white,
                ),
              )),
    ]
    )
    ));
  }
  Widget _buildTripTypeFrecuent() {
    return Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
            height: 60,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                  onPressed: () => {},
                  child: Text(
                    'Viajes frecuentes',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ]
            )
        ));
  }
}
