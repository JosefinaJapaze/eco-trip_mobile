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
      body: Container(),
    );
  }
}
