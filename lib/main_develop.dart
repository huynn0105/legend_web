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
      apiKey: 'AIzaSyC3h8_txxt8fPsOxcrm_3_czP3wnyYZ6gQ',
      appId: '1:903499824003:web:6583a14b1ee8f25f4314b6',
      messagingSenderId: '903499824003',
      projectId: 'mfast-dev-623d0',
      authDomain: 'mfast-dev-623d0.firebaseapp.com',
      databaseURL: 'https://mfast-dev-623d0.firebaseio.com',
      storageBucket: 'mfast-dev-623d0.appspot.com',
      measurementId: 'G-80THCZXL0Z',
    ),
  );

  EnvConfig.instance.init(
    baseUrl: "https://appay-rc.cloudcms.vn",
    firebaseFunctionUrl: 'https://us-central1-mfast-dev-623d0.cloudfunctions.net',
    apiUserName: "dgtapp",
    apiPassword: "xuka1997",
  );

  GeneralConfig.init();

  runApp(const AppView());
}
