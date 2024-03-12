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
      apiKey: 'AIzaSyDmTlpPNXdgOwDJdul-0uYq2I04iXAxalY',
      appId: '1:74119051137:web:d2628c8720f0ea4fa09a80',
      messagingSenderId: '74119051137',
      projectId: 'mfast-staging-baa47',
      authDomain: 'mfast-staging-baa47.firebaseapp.com',
      databaseURL: 'https://mfast-staging-baa47.firebaseio.com',
      storageBucket: 'mfast-staging-baa47.appspot.com',
      measurementId: 'G-RX8B9E0L9Q',
    ),
  );

  EnvConfig.instance.init(
    baseUrl: "https://appay-staging.cloudcms.vn",
    firebaseFunctionUrl: 'https://us-central1-mfast-staging-baa47.cloudfunctions.net',
    apiUserName: "dgtapp",
    apiPassword: "xuka1997",
  );

  GeneralConfig.init();

  runApp(const AppView());
}
