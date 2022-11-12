import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/trip/trip_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;
  late TripStore _tripStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _tripStore = Provider.of<TripStore>(context);

    if (!_tripStore.loading) {
      _tripStore.getTrips();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar:
      BottomNavigationBar(
        backgroundColor: Colors.black,
          unselectedItemColor: Colors.black,
        fixedColor: Colors.black,
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
        BottomNavigationBarItem(icon: Icon(Icons.currency_exchange), label: "Solicitudes de pago"),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: "Notificaciones"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Mi cuenta"),
      ]),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(AppLocalizations.of(context).translate('home_title')),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return false //TODO set when api is ready
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildListView());
      },
    );
  }

  Widget _buildListView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: Text("¡Hola, Usuario!"),
          ),
          Wrap(direction: Axis.horizontal, children: [
            _buildMainMenuButton("Mis viajes", "/my_trips"),
            _buildMainMenuButton("Nuevo viaje", "/new_trip"),
            _buildMainMenuButton("Mi billetera", "/my_wallet"),
            _buildMainMenuButton("Chats", "/chats"),
          ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainMenuButton(String text, String route) {
    double vw = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
          onPressed: () => {
            Navigator.of(context).pushNamed(route)
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
            fixedSize: MaterialStateProperty.all(Size.square(vw/2.5)),
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => Colors.black),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        return SizedBox.shrink();
      },
    );
  }

}
