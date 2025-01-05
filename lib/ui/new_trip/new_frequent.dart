import 'package:ecotrip/utils/routes/routes.dart';
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class NewFrequentScreen extends StatefulWidget {
  @override
  _NewFrequentScreenState createState() => _NewFrequentScreenState();
}

class _NewFrequentScreenState extends State<NewFrequentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'new_frequent_title'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildTripJoinFrequent(Routes.join_frequent_trip),
          _buildTripCreateFrequent(Routes.create_frequent_trip_map)
        ],
      ),
    );
  }

  Widget _buildTripJoinFrequent(route) {
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
                onPressed: () => {Navigator.of(context).pushNamed(route)},
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Unirme a un viaje',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.lime),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTripCreateFrequent(route) {
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
                onPressed: () => {Navigator.of(context).pushNamed(route)},
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Crear un nuevo viaje',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.lime),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
