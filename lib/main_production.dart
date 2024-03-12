import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'env_config.dart';
import 'features/app_view.dart';
import 'general_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDbJmfYGL8pKAABpz7LJ_ZsvcT0RguporE',
      appId: '1:55730646681:web:e373c77ea051fb9b441208',
      messagingSenderId: '55730646681',
      projectId: 'mfast-prod-c6839',
      authDomain: 'mfast-prod-c6839.firebaseapp.com',
      databaseURL: 'https://mfast-prod-c6839.firebaseio.com',
      storageBucket: 'mfast-prod-c6839.appspot.com',
      measurementId: 'G-BKD5KJFLYK',
    ),
  );

  EnvConfig.instance.init(
    baseUrl: "https://appay.cloudcms.vn",
    firebaseFunctionUrl: 'https://us-central1-mfast-prod-c6839.cloudfunctions.net',
    apiUserName: "dgtapp",
    apiPassword: "xuka1997",
    showLog: false,
  );

  GeneralConfig.init();

  runApp(const AppView());
}
