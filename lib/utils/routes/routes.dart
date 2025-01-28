import 'package:ecotrip/ui/chats/chats.dart';
import 'package:ecotrip/ui/home/home.dart';
import 'package:ecotrip/ui/login/login.dart';
import 'package:ecotrip/ui/new_trip/new_scheduled.dart';
import 'package:ecotrip/ui/register/register.dart';
import 'package:ecotrip/ui/my_trips/trip_route.dart';
import 'package:ecotrip/ui/my_wallet/my_wallet.dart';
import 'package:ecotrip/ui/my_wallet/pay_request.dart';
import 'package:ecotrip/ui/my_wallet/pay_trips.dart';
import 'package:ecotrip/ui/new_trip/create_frequent_calendar.dart';
import 'package:ecotrip/ui/new_trip/create_frequent_map.dart';
import 'package:ecotrip/ui/new_trip/create_scheduled_calendar.dart';
import 'package:ecotrip/ui/new_trip/create_scheduled_map.dart';
import 'package:ecotrip/ui/new_trip/create_request.dart';
import 'package:ecotrip/ui/join_trip/join_frequent_calendar.dart';
import 'package:ecotrip/ui/join_trip/join_frequent_map.dart';
import 'package:ecotrip/ui/join_trip/join_scheduled.dart';
import 'package:ecotrip/ui/join_trip/join_scheduled_calendar.dart';
import 'package:ecotrip/ui/join_trip/join_scheduled_map.dart';
import 'package:ecotrip/ui/join_trip/join_scheduled_matchs.dart';
import 'package:ecotrip/ui/join_trip/join_request.dart';
import 'package:ecotrip/ui/new_trip/new_trip.dart';
import 'package:ecotrip/ui/new_trip/new_frequent.dart';
import 'package:ecotrip/ui/join_trip/join_frequent.dart';
import 'package:ecotrip/ui/join_trip/join_frequent_matchs.dart';
import 'package:ecotrip/ui/register/register_success.dart';
import 'package:ecotrip/ui/register/validate_data_step_four.dart';
import 'package:ecotrip/ui/register/validate_data_step_one.dart';
import 'package:ecotrip/ui/register/validate_data_step_three.dart';
import 'package:ecotrip/ui/register/validate_data_step_two.dart';
import 'package:ecotrip/ui/splash/splash.dart';
import 'package:ecotrip/ui/my_trips/my_trips.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String validate_data_step_one = '/validate_data_step_one';
  static const String validate_data_step_two = '/validate_data_step_two';
  static const String validate_data_step_three = '/validate_data_step_three';
  static const String validate_data_step_four = '/validate_data_step_four';
  static const String register_success = '/register_success';
  static const String home = '/home';
  static const String my_trips = '/my_trips';
  static const String new_trip = '/new_trip';
  static const String my_wallet = '/my_wallet';
  static const String chats = '/chats';
  static const String new_frequent = '/new_frequent';
  static const String join_frequent_trip = '/join_frequent_trip';
  static const String join_frequent_trip_map = '/join_frequent_trip_map';
  static const String join_frequent_trip_calendar =
      '/join_frequent_trip_calendar';
  static const String join_frequent_trip_matchs = '/join_frequent_trip_matchs';
  static const String create_frequent_trip_map = '/create_frequent_trip_map';
  static const String create_frequent_trip_calendar =
      '/create_frequent_trip_calendar';
  static const String join_request = '/join_request';
  static const String create_request = '/create_request';
  static const String new_scheduled = '/new_scheduled';
  static const String join_scheduled_trip = '/join_scheduled_trip';
  static const String join_scheduled_trip_map = '/join_scheduled_trip_map';
  static const String join_scheduled_trip_calendar =
      '/join_scheduled_trip_calendar';
  static const String join_scheduled_trip_matchs =
      '/join_scheduled_trip_matchs';
  static const String create_scheduled_trip_map = '/create_scheduled_trip_map';
  static const String create_scheduled_trip_calendar =
      '/create_scheduled_trip_calendar';
  static const String pay_request = '/pay_request';
  static const String pay_trip = '/pay_trip';
  static const String trip_route = '/trip_route';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    register: (BuildContext context) => RegisterScreen(),
    validate_data_step_one: (BuildContext context) => ValidateDataStepOne(),
    validate_data_step_two: (BuildContext context) => ValidateDataStepTwo(),
    validate_data_step_three: (BuildContext context) => ValidateDataStepThree(),
    validate_data_step_four: (BuildContext context) => ValidateDataStepFour(),
    register_success: (BuildContext context) => RegisterSuccessScreen(),
    home: (BuildContext context) => HomeScreen(),
    my_trips: (BuildContext context) => MyTripsScreen(),
    new_trip: (BuildContext context) => NewTripScreen(),
    my_wallet: (BuildContext context) => MyWalletScreen(),
    chats: (BuildContext context) => ChatsScreen(),
    new_frequent: (BuildContext context) => NewFrequentScreen(),
    join_frequent_trip: (BuildContext context) => JoinFrequentScreen(),
    join_frequent_trip_map: (BuildContext context) => JoinFrequentMapScreen(),
    join_frequent_trip_calendar: (BuildContext context) =>
        JoinFrequentCalendarScreen(),
    join_frequent_trip_matchs: (BuildContext context) =>
        JoinFrequentMatchsScreen(),
    create_frequent_trip_map: (BuildContext context) =>
        CreateFrequentMapScreen(),
    create_frequent_trip_calendar: (BuildContext context) =>
        CreateFrequentCalendarScreen(),
    new_scheduled: (BuildContext context) => NewScheduledScreen(),
    join_scheduled_trip: (BuildContext context) => JoinScheduledScreen(),
    join_scheduled_trip_map: (BuildContext context) => JoinScheduledMapScreen(),
    join_scheduled_trip_calendar: (BuildContext context) =>
        JoinScheduledCalendarScreen(),
    join_scheduled_trip_matchs: (BuildContext context) =>
        JoinScheduledMatchsScreen(),
    create_scheduled_trip_map: (BuildContext context) =>
        CreateScheduledMapScreen(),
    create_scheduled_trip_calendar: (BuildContext context) =>
        CreateScheduledCalendarScreen(),
    join_request: (BuildContext context) => JoinRequestScreen(),
    pay_request: (BuildContext context) => PayRequestScreen(),
    create_request: (BuildContext context) => CreateRequestScreen(),
    pay_trip: (BuildContext context) => PayTripScreen(),
    trip_route: (BuildContext context) => TripRouteScreen()
  };
}
