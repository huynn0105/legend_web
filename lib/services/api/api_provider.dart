import 'package:legend_mfast/services/api/user/user_api.dart';

import 'config/config_api.dart';
import 'legendary/legendary_api.dart';

class ApiProvider {
  ApiProvider._();

  static final ApiProvider instance = ApiProvider._();

  ConfigApi get config => ConfigApiImpl();

  LegendaryApi get legend => LegendaryApiImpl();

  UserApi get user => UserApiImpl();
}
