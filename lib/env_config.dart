import 'models/default/default_param_model.dart';

class EnvConfig {
  EnvConfig._();

  static final instance = EnvConfig._();

  // late Map<String, dynamic> arguments;
  late bool showLog;
  late String baseUrl;
  late String firebaseFunctionUrl;
  late String apiUserName;
  late String apiPassword;
  late DefaultParamModel defaultParam;
  String? package;

  init({
    required String baseUrl,
    required String firebaseFunctionUrl,
    required String apiUserName,
    required String apiPassword,
    String? package,
    bool? showLog,
  }) {
    this.showLog = showLog ?? true;
    this.baseUrl = baseUrl;
    this.firebaseFunctionUrl = firebaseFunctionUrl;
    this.apiUserName = apiUserName;
    this.apiPassword = apiPassword;
    this.package = package;
    defaultParam = DefaultParamModel(mobileApp: 'mfast', os: 'web_portal', appVersion: '1.0.0');
  }
}
