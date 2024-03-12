import 'hier_level_model.dart';

/// ID : 14
/// userID : 1240469574
/// points : 880.7
/// level : {"ID":9,"level":"head","title":"Huyền Thoại","point":0,"commGrade":0,"commRate":1,"teaser":"Trùm cuối.","image":"https://appay-rc.cloudcms.vn/assets/mfast-new_model/images/rank/huyenthoai.png"}
/// tmpPoints : 55
/// tmpLevel : {"ID":2,"level":"earning_user","title":"Tân Thủ","point":1,"commGrade":1,"commRate":3,"teaser":"Khởi đầu mới, tư duy mới, mục tiêu mới, kết quả mới.","image":"https://appay-rc.cloudcms.vn/assets/mfast-new_model/images/rank/tanthu.png"}
/// createdDate : "2022-09-29 10:25:26"
/// totalUserPoint : 10
/// growPoint : 865.7
/// tmpTotalUserPoint : 10
/// tmpGrowPoint : 40
/// totalUserEKycPoint : 5
/// tmpTotalUserEKycPoint : 5
/// bonusUserInsPoint : 0
/// bonusUserNonInsPoint : 14
/// finAmtPoint : 811.7
/// insAmtPoint : 0
/// daaPoint : 40
/// mtradePoint : 0
/// bonusPoint : 0
/// tmpBonusUserInsPoint : 0
/// tmpBonusUserNonInsPoint : 2
/// tmpFinAmtPoint : 0
/// tmpInsAmtPoint : 0
/// tmpDaaPoint : 38
/// tmpMTradePoint : 0
/// tmpBonusPoint : 0
/// userCreatedDate : "2020-03-18 15:58:50"
/// point : 880.7
/// tmpPoint : 55
/// nextLevel : {"ID":3,"level":"VAR_RSA","title":"Cao Thủ 1","point":300,"commGrade":1,"commRate":8,"teaser":"Nghị lực và bền bỉ giúp bạn vươn lên một tầm cao mới.","image":null}

class HierRankModel {
  HierRankModel({
    this.id,
    this.userID,
    this.points,
    this.level,
    this.tmpPoints,
    this.tmpLevel,
    this.createdDate,
    this.totalUserPoint,
    this.growPoint,
    this.tmpTotalUserPoint,
    this.tmpGrowPoint,
    this.totalUserEKycPoint,
    this.tmpTotalUserEKycPoint,
    this.bonusUserInsPoint,
    this.bonusUserNonInsPoint,
    this.finAmtPoint,
    this.insAmtPoint,
    this.daaPoint,
    this.mtradePoint,
    this.bonusPoint,
    this.tmpBonusUserInsPoint,
    this.tmpBonusUserNonInsPoint,
    this.tmpFinAmtPoint,
    this.tmpInsAmtPoint,
    this.tmpDaaPoint,
    this.tmpMTradePoint,
    this.tmpBonusPoint,
    this.userCreatedDate,
    this.point,
    this.tmpPoint,
    this.nextLevel,
  });

  HierRankModel.fromJson(dynamic json) {
    id = json['ID'];
    userID = json['userID'];
    points = json['points'];
    level = json['level'] != null ? HierLevelModel.fromJson(json['level']) : null;
    tmpPoints = json['tmpPoints'];
    tmpLevel = json['tmpLevel'] != null ? HierLevelModel.fromJson(json['tmpLevel']) : null;
    createdDate = json['createdDate'];
    totalUserPoint = json['totalUserPoint'];
    growPoint = json['growPoint'];
    tmpTotalUserPoint = json['tmpTotalUserPoint'];
    tmpGrowPoint = json['tmpGrowPoint'];
    totalUserEKycPoint = json['totalUserEKycPoint'];
    tmpTotalUserEKycPoint = json['tmpTotalUserEKycPoint'];
    bonusUserInsPoint = json['bonusUserInsPoint'];
    bonusUserNonInsPoint = json['bonusUserNonInsPoint'];
    finAmtPoint = json['finAmtPoint'];
    insAmtPoint = json['insAmtPoint'];
    daaPoint = json['daaPoint'];
    mtradePoint = json['mtradePoint'];
    bonusPoint = json['bonusPoint'];
    tmpBonusUserInsPoint = json['tmpBonusUserInsPoint'];
    tmpBonusUserNonInsPoint = json['tmpBonusUserNonInsPoint'];
    tmpFinAmtPoint = json['tmpFinAmtPoint'];
    tmpInsAmtPoint = json['tmpInsAmtPoint'];
    tmpDaaPoint = json['tmpDaaPoint'];
    tmpMTradePoint = json['tmpMTradePoint'];
    tmpBonusPoint = json['tmpBonusPoint'];
    userCreatedDate = json['userCreatedDate'];
    point = json['point'];
    tmpPoint = json['tmpPoint'];
    nextLevel = json['nextLevel'] != null ? HierLevelModel.fromJson(json['nextLevel']) : null;
  }

  num? id;
  num? userID;
  num? points;
  HierLevelModel? level;
  num? tmpPoints;
  HierLevelModel? tmpLevel;
  String? createdDate;
  num? totalUserPoint;
  num? growPoint;
  num? tmpTotalUserPoint;
  num? tmpGrowPoint;
  num? totalUserEKycPoint;
  num? tmpTotalUserEKycPoint;
  num? bonusUserInsPoint;
  num? bonusUserNonInsPoint;
  num? finAmtPoint;
  num? insAmtPoint;
  num? daaPoint;
  num? mtradePoint;
  num? bonusPoint;
  num? tmpBonusUserInsPoint;
  num? tmpBonusUserNonInsPoint;
  num? tmpFinAmtPoint;
  num? tmpInsAmtPoint;
  num? tmpDaaPoint;
  num? tmpMTradePoint;
  num? tmpBonusPoint;
  String? userCreatedDate;
  num? point;
  num? tmpPoint;
  HierLevelModel? nextLevel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['userID'] = userID;
    map['points'] = points;
    if (level != null) {
      map['level'] = level?.toJson();
    }
    map['tmpPoints'] = tmpPoints;
    if (tmpLevel != null) {
      map['tmpLevel'] = tmpLevel?.toJson();
    }
    map['createdDate'] = createdDate;
    map['totalUserPoint'] = totalUserPoint;
    map['growPoint'] = growPoint;
    map['tmpTotalUserPoint'] = tmpTotalUserPoint;
    map['tmpGrowPoint'] = tmpGrowPoint;
    map['totalUserEKycPoint'] = totalUserEKycPoint;
    map['tmpTotalUserEKycPoint'] = tmpTotalUserEKycPoint;
    map['bonusUserInsPoint'] = bonusUserInsPoint;
    map['bonusUserNonInsPoint'] = bonusUserNonInsPoint;
    map['finAmtPoint'] = finAmtPoint;
    map['insAmtPoint'] = insAmtPoint;
    map['daaPoint'] = daaPoint;
    map['mtradePoint'] = mtradePoint;
    map['bonusPoint'] = bonusPoint;
    map['tmpBonusUserInsPoint'] = tmpBonusUserInsPoint;
    map['tmpBonusUserNonInsPoint'] = tmpBonusUserNonInsPoint;
    map['tmpFinAmtPoint'] = tmpFinAmtPoint;
    map['tmpInsAmtPoint'] = tmpInsAmtPoint;
    map['tmpDaaPoint'] = tmpDaaPoint;
    map['tmpMTradePoint'] = tmpMTradePoint;
    map['tmpBonusPoint'] = tmpBonusPoint;
    map['userCreatedDate'] = userCreatedDate;
    map['point'] = point;
    map['tmpPoint'] = tmpPoint;
    if (nextLevel != null) {
      map['nextLevel'] = nextLevel?.toJson();
    }
    return map;
  }
}
