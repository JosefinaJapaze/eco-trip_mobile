import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateFrecuentCalendarScreen extends StatefulWidget {
  @override
  _CreateFrecuentCalendarScreenState createState() => _CreateFrecuentCalendarScreenState();
}

class _CreateFrecuentCalendarScreenState extends State<CreateFrecuentCalendarScreen> {
  //stores:---------------------------------------------------------------------
  late PostStore _postStore;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  final List<String> items = [
    '06:00hs',
    '12:00hs',
    '18:00hs',
    '00:00hs',
  ];
  String? selectedValue;

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
    _postStore = Provider.of<PostStore>(context);

    // check to see if already called api
    if (!_postStore.loading) {
      _postStore.getPosts();
    }
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
          Text(
            'Seleccione los días del recorrido',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Seleccione la hora',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildDropDownButton(),
          Text(
            'Ingrese lugares disponibles:',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Colors.black), //<-- SEE HERE
              ),
            ),
          ),
          Text(
            'Ingrese costo o canje:',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Colors.black), //<-- SEE HERE
              ),
            ),
          ),
          _buildTextButtonFindTrips("/create_request"),
        ],
      ),
    );
  }

  Widget _buildDropDownButton() {
    return DecoratedBox(
      decoration: BoxDecoration(
          color:Colors.white, //background color of dropdown button
          border: Border.all(color: Colors.black, width:3), //border of dropdown button
          boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                blurRadius: 5) //blur radius of shadow
          ]
      ),
      child: Padding(
        padding: EdgeInsets.only(left:30, right:30),
        child: DropdownButton(
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme
                  .of(context)
                  .hintColor,
            ),
          ),
          items: items
              .map((item) =>
              DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
              .toList(),
          value: selectedValue,

          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },

        ),
      ),
    );
  }

  Widget _buildTextButtonFindTrips(route) {
    return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lime,
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                  onPressed: () => {
                    Navigator.of(context).pushNamed(route)
                  },
                  child: Text(
                    'CONFIRMAR',
                    style:
                    TextStyle(
                      color: Colors.black,
                    ),
                  )),
            ]
            )
        ));
  }
}