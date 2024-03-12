import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart';

import '../../models/user/user_info_model.dart';

class LocalDataHelper {
  LocalDataHelper._();

  static final instance = LocalDataHelper._();
}
