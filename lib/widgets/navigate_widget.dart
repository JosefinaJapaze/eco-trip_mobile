import 'package:ecotrip/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class NavigateWidget extends StatelessWidget {
  final String routeName;
  final bool replace;

  NavigateWidget(this.routeName, {this.replace = false});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (replace) {
        Navigator.of(context).popAndPushNamed(Routes.login);
        Navigator.of(context).pushNamed(routeName);
        return;
      }
      Navigator.of(context).pushNamed(routeName);
    });
    return Container();
  }
}
