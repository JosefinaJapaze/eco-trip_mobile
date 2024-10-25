import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class JoinRequestScreen extends StatefulWidget {
  @override
  _JoinRequestScreenState createState() => _JoinRequestScreenState();
}

class _JoinRequestScreenState extends State<JoinRequestScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'join_frecuent_trip_title'),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------Widget _buildBody() {
  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.check_circle, color: Colors.lime),
          Text(
            'Tu solicitud de viaje',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'se envió exitosamente',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lime,
            ),
            child: TextButton(
                onPressed: () => {Navigator.of(context).pushNamed("/home")},
                child: Text(
                  'ACEPTAR',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
