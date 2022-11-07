import 'package:boilerplate/ui/home/home.dart';
import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/ui/splash/splash.dart';
import 'package:boilerplate/ui/my_trips/my_trips.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String my_trips = '/my_trips';
  static const String new_trip = '/new_trip';
  static const String my_wallet = '/my_wallet';
  static const String chats = '/chats';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    my_trips: (BuildContext context) => MyTripsScreen()
  };
}



