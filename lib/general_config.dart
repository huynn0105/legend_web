import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'app_data.dart';
import 'di/get_it.dart';
import 'features/app_cubit.dart';

EventBus eventBus = EventBus();

class GeneralConfig {
  GeneralConfig._();

  static void init({bool existHomePage = true}) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    configureDependencies();
    // if (kIsWeb) {
    //   PlatformRegistry().hideSplashScreen();
    // }
    AppData.instance.init();
    getItInstance.get<AppCubit>().init();
  }

  static Future<void> dataConfig(Map<String, dynamic> args) async {
    await initHiveForFlutter();
  }
}
