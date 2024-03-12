import 'package:legend_mfast/common/utils/text_util.dart';

class CollaboratorModel {
  CollaboratorModel({
      this.userID, 
      this.totalAmount, 
      this.refLevel, 
      this.fullName, 
      this.sex, 
      this.avatarImage, 
      this.mobilePhone, 
      this.createdDate, 
      this.isPoint, 
      this.rankImage, 
      this.level, 
      this.levelCode,});

  CollaboratorModel.fromJson(dynamic json) {
    userID = json['userID']?.toString();
    totalAmount = TextUtils.parseDouble(json['totalAmount']);
    refLevel = json['refLevel'];
    fullName = json['fullName'];
    sex = json['sex'];
    avatarImage = json['avatarImage'];
    mobilePhone = json['mobilePhone'];
    createdDate = json['createdDate'];
    isPoint = json['isPoint'] == "1";
    rankImage = json['rankImage'];
    level = json['level'];
    levelCode = json['level_code'];
  }
  String? userID;
  double? totalAmount;
  String? refLevel;
  String? fullName;
  String? sex;
  String? avatarImage;
  String? mobilePhone;
  String? createdDate;
  bool? isPoint;
  String? rankImage;
  String? level;
  String? levelCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userID'] = userID;
    map['totalAmount'] = totalAmount;
    map['refLevel'] = refLevel;
    map['fullName'] = fullName;
    map['sex'] = sex;
    map['avatarImage'] = avatarImage;
    map['mobilePhone'] = mobilePhone;
    map['createdDate'] = createdDate;
    map['isPoint'] = isPoint == true ? "1" : "0";
    map['rankImage'] = rankImage;
    map['level'] = level;
    map['level_code'] = levelCode;
    return map;
  }

}