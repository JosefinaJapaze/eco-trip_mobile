import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateFrecuentMapScreen extends StatefulWidget {
  @override
  _CreateFrecuentMapScreenState createState() => _CreateFrecuentMapScreenState();
}

class _CreateFrecuentMapScreenState extends State<CreateFrecuentMapScreen> {
  //stores:---------------------------------------------------------------------
  late PostStore _postStore;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

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
          _buildTextButtonFind(),
          _buildMap(),
          _buildTextButtonNext("/join_frecuent_trip_calendar")
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("android/app/src/main/res/drawable/map.jpg"),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildTextButtonFind() {
    return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white70,
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                  onPressed: () => {
                  },
                  child:
                  Container(
                    child:
                      Row(children: [
                      Icon(Icons.my_location_outlined, color: Colors.lime),
                      SizedBox(width: 10),
                      Text(
                        'Origen',
                        style:
                        TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Container(child: Icon(Icons.arrow_drop_down, color: Colors.black54)),
                      SizedBox(width: 10),
                      Text(
                        'Destino',
                        style:
                        TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

              ),
        )
            ]
        )));
  }

  Widget _buildTextButtonNext(route) {
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
                    'SIGUIENTE',
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