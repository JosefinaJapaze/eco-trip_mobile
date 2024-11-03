import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:ecotrip/constants/app_theme.dart';
import 'package:ecotrip/constants/strings.dart';
import 'package:ecotrip/data/network/apis/auth/auth_api.dart';
import 'package:ecotrip/data/repository.dart';
import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/stores/language/language_store.dart';
import 'package:ecotrip/stores/trip/trip_store.dart';
import 'package:ecotrip/stores/theme/theme_store.dart';
import 'package:ecotrip/ui/login/store/login_store.dart';
import 'package:ecotrip/ui/home/home.dart';
import 'package:ecotrip/ui/login/login.dart';
import 'package:ecotrip/ui/register/validate_data_step_one.dart';
import 'package:ecotrip/utils/locale/app_localization.dart';
import 'package:ecotrip/utils/routes/routes.dart';
import 'package:ecotrip/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final TripStore _tripStore = TripStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<Repository>(), getIt<AuthApi>());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<TripStore>(create: (_) => _tripStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<UserStore>(create: (_) => _userStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode
                ? AppThemeData.darkThemeData
                : AppThemeData.lightThemeData,
            routes: Routes.routes,
            locale: Locale(_languageStore.locale),
            supportedLocales: _languageStore.supportedLanguages
                .map((language) => Locale(language.locale!, language.code))
                .toList(),
            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            home: _userStore.isLoggedIn
                ? CheckUserValidatedWidget()
                : LoginScreen(),
          );
        },
      ),
    );
  }
}

class CheckUserValidatedWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CheckUserValidatedWidgetState();
  }
}

class _CheckUserValidatedWidgetState extends State<CheckUserValidatedWidget> {
  final Repository _repository = getIt<Repository>();
  bool isUserValidated = false;
  bool tokenLoaded = false;

  @override
  void initState() {
    super.initState();
    checkUserValidated();
  }

  void checkUserValidated() async {
    final token = await _repository.authToken;
    if (token != null) {
      final decoded = JWT.decode(token);
      isUserValidated = decoded.payload['validated'] as bool;
    } else {
      isUserValidated = false;
    }
    setState(() {
      tokenLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return tokenLoaded
          ? isUserValidated
              ? HomeScreen()
              : ValidateDataStepOne()
          : CustomProgressIndicatorWidget();
    });
  }
}
