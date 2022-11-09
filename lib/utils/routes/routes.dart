import 'package:boilerplate/ui/chats/chats.dart';
import 'package:boilerplate/ui/home/home.dart';
import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/ui/my_wallet/my_wallet.dart';
import 'package:boilerplate/ui/new_trip/new_trip.dart';
import 'package:boilerplate/ui/new_trip/new_frecuent.dart';
import 'package:boilerplate/ui/new_trip/new_programmed.dart';
import 'package:boilerplate/ui/new_trip/join_frecuent.dart';
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
  static const String new_frecuent = '/new_frecuent';
  static const String join_frecuent_trip = '/join_frecuent_trip';
  static const String new_programmed = '/new_programmed';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    my_trips: (BuildContext context) => MyTripsScreen(),
    new_trip: (BuildContext context) => NewTripScreen(),
    my_wallet: (BuildContext context) => MyWalletScreen(),
    chats: (BuildContext context) => ChatsScreen(),
    new_frecuent: (BuildContext context) => NewFrecuentScreen(),
    join_frecuent_trip: (BuildContext context) => JoinFrecuentScreen(),
    new_programmed: (BuildContext context) => NewProgrammedScreen(),
  };
}



