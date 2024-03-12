import 'package:legend_mfast/common/utils/text_util.dart';

/// fullName : "nhapnhap6969"
/// avatarImage : "https://firebasestorage.googleapis.com:443/v0/b/mfast-dev-623d0.appspot.com/o/images/profile_avatar/1240469574_1694578561.jpg?alt=media&token=55d3bad1-ca6e-4fdc-aedc-e90ebd5319b3"
/// sex : "male"
/// mobilePhone : "0122222222"

class HierUserModel {
  HierUserModel({
    this.userID,
    this.fullName,
    this.avatarImage,
    this.sex,
    this.mobilePhone,
    this.code,
    this.userReferral,
    this.refLevel,
    this.title,
    this.path,
  });

  HierUserModel.fromJson(dynamic json) {
    userID = json['userID'];
    fullName = json['fullName'];
    avatarImage = json['avatarImage'];
    sex = json['sex'];
    mobilePhone = json['mobilePhone'];
    code = json['code'];
    userReferral = json['userReferral'];
    refLevel = TextUtils.parseInt(json['refLevel']);
    title = json['title'];
    path = json['path'];
  }

  String? userID;
  String? fullName;
  String? avatarImage;
  String? sex;
  String? mobilePhone;

  ///
  String? code;
  String? userReferral;
  int? refLevel;
  String? title;
  String? path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userID'] = userID;
    map['fullName'] = fullName;
    map['avatarImage'] = avatarImage;
    map['sex'] = sex;
    map['mobilePhone'] = mobilePhone;
    map['code'] = code;
    map['userReferral'] = userReferral;
    map['refLevel'] = refLevel;
    map['title'] = title;
    map['path'] = path;
    return map;
  }
}
