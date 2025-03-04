import 'dart:async';

import 'package:domo_sms/controllers/fatal_error_handler.dart';
import 'package:domo_sms/controllers/multi_providers_handler.dart';
import 'package:domo_sms/routes.dart';
import 'package:domo_sms/screens/pin_page.dart';
import 'package:domo_sms/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    //
    runApp(const DomoSmsApp());
  }, (error, stackTrace) async {
    WidgetsFlutterBinding.ensureInitialized();
    FatalErrorHandler fatalErrorHandler = FatalErrorHandler();
    fatalErrorHandler.fatalError(
        error, stackTrace, null, "Errore main", "", "");

    throw error;
  });
}

class DomoSmsApp extends StatelessWidget {
  const DomoSmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MultiProvidersHandler multiProvidersHandler = MultiProvidersHandler();

    return MultiProvider(
      providers: [...multiProvidersHandler.getProvidersList()],
      child: MaterialApp(
        title: 'DomoSMS',
        theme: Styles.themeData(false, context),
        darkTheme: Styles.themeData(false, context),
        themeMode: ThemeMode.system,
        routes: RoutesHandler.routes,
        home: const LoginPage(),
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('it', 'IT'),
        supportedLocales: const [
          Locale('it', 'IT'),
        ],
      ),
    );
  }
}
