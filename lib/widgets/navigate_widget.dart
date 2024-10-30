import 'package:flutter/material.dart';

class NavigateWidget extends StatelessWidget {
  final String routeName;

  NavigateWidget(this.routeName);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamed(routeName);
    });
    return Container();
  }
}
