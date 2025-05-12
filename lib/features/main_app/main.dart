import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../core/routes/route.dart';
import '../../generated/l10n.dart';

class CarOnSaleApp extends StatelessWidget {
  const CarOnSaleApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Setup MaterialApp & Route configration
    return MaterialApp.router(
      routerConfig: applicationRouter,
      title: 'CarOnSale App',
      theme: ThemeData(primarySwatch: Colors.blue),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
