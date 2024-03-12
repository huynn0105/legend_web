/// mobileApp : "mfast"
/// os : "android"
/// appVersion : "3.0.1"
/// accessToken : "0123456789"

class DefaultParamModel {
  DefaultParamModel({
    this.mobileApp,
    this.os,
    this.appVersion,
    this.accessToken,
  });

  DefaultParamModel.fromJson(dynamic json) {
    mobileApp = json['mobileApp'];
    os = json['os'];
    appVersion = json['appVersion'];
    accessToken = json['accessToken'];
  }

  String? mobileApp;
  String? os;
  String? appVersion;
  String? accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobileApp'] = mobileApp;
    map['os'] = os;
    map['appVersion'] = appVersion;
    map['accessToken'] = accessToken;
    return map;
  }

  Map<String, dynamic> toJsonWithoutToken() {
    final map = <String, dynamic>{};
    map['mobileApp'] = mobileApp;
    map['os'] = os;
    map['appVersion'] = appVersion;
    return map;
  }
}
