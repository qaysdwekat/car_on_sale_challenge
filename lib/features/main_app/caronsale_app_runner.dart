import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../environments/config/config.dart';
import 'main.dart';
import '../../core/core_injector.dart' as di;

Future<void> carOnSaleAppRunner(config) async {
  WidgetsFlutterBinding.ensureInitialized();
  // init App Config 
  Config.setConfig(config);
  //initialize dependency injection
  await di.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) => runApp(CarOnSaleApp()));
}
