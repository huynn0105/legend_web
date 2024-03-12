import '../../common/utils/text_util.dart';
import 'hier_rank_model.dart';
import 'hier_user_model.dart';

/// point : 55
/// commission : 1285036
/// collaborator : 58
/// user : {"fullName":"nhapnhap6969","avatarImage":"https://firebasestorage.googleapis.com:443/v0/b/mfast-dev-623d0.appspot.com/o/images/profile_avatar/1240469574_1694578561.jpg?alt=media&token=55d3bad1-ca6e-4fdc-aedc-e90ebd5319b3","sex":"male","mobilePhone":"0122222222"}
/// rank : {"ID":14,"userID":1240469574,"points":880.7,"level":{"ID":9,"level":"head","title":"Huyền Thoại","point":0,"commGrade":0,"commRate":1,"teaser":"Trùm cuối.","image":"https://appay-rc.cloudcms.vn/assets/mfast-new_model/images/rank/huyenthoai.png"},"tmpPoints":55,"tmpLevel":{"ID":2,"level":"earning_user","title":"Tân Thủ","point":1,"commGrade":1,"commRate":3,"teaser":"Khởi đầu mới, tư duy mới, mục tiêu mới, kết quả mới.","image":"https://appay-rc.cloudcms.vn/assets/mfast-new_model/images/rank/tanthu.png"},"createdDate":"2022-09-29 10:25:26","totalUserPoint":10,"growPoint":865.7,"tmpTotalUserPoint":10,"tmpGrowPoint":40,"totalUserEKycPoint":5,"tmpTotalUserEKycPoint":5,"bonusUserInsPoint":0,"bonusUserNonInsPoint":14,"finAmtPoint":811.7,"insAmtPoint":0,"daaPoint":40,"mtradePoint":0,"bonusPoint":0,"tmpBonusUserInsPoint":0,"tmpBonusUserNonInsPoint":2,"tmpFinAmtPoint":0,"tmpInsAmtPoint":0,"tmpDaaPoint":38,"tmpMTradePoint":0,"tmpBonusPoint":0,"userCreatedDate":"2020-03-18 15:58:50","point":880.7,"tmpPoint":55,"nextLevel":{"ID":3,"level":"VAR_RSA","title":"Cao Thủ 1","point":300,"commGrade":1,"commRate":8,"teaser":"Nghị lực và bền bỉ giúp bạn vươn lên một tầm cao mới.","image":null}}
/// line : []
/// initLevel : 0
/// requestDelete : false
/// requestDeleteDate : null
/// requestReason : null

class LegendaryHierUserInfoModel {
  LegendaryHierUserInfoModel({
    this.point,
    this.commission,
    this.collaborator,
    this.user,
    this.rank,
    this.line,
    this.initLevel,
    this.requestDelete,
    this.requestDeleteDate,
    this.requestReason,
  });

  LegendaryHierUserInfoModel.fromJson(dynamic json) {
    point = TextUtils.parseDouble(json['point']);
    commission = TextUtils.parseDouble(json['commission']);
    collaborator = TextUtils.parseInt(json['collaborator']);
    user = json['user'] != null ? HierUserModel.fromJson(json['user']) : null;
    rank = json['rank'] != null ? HierRankModel.fromJson(json['rank']) : null;
    if (json['line'] != null) {
      line = [];
      json['line'].forEach((v) {
        line?.add(HierUserModel.fromJson(v));
      });
    }
    initLevel = TextUtils.parseInt(json['initLevel']);
    requestDelete = json['requestDelete'];
    requestDeleteDate = json['requestDeleteDate'];
    requestReason = json['requestReason'];
  }

  double? point;
  double? commission;
  int? collaborator;
  HierUserModel? user;
  HierRankModel? rank;
  List<HierUserModel>? line;
  int? initLevel;
  bool? requestDelete;
  String? requestDeleteDate;
  String? requestReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['point'] = point;
    map['commission'] = commission;
    map['collaborator'] = collaborator;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (rank != null) {
      map['rank'] = rank?.toJson();
    }
    if (line != null) {
      map['line'] = line?.map((v) => v.toJson()).toList();
    }
    map['initLevel'] = initLevel;
    map['requestDelete'] = requestDelete;
    map['requestDeleteDate'] = requestDeleteDate;
    map['requestReason'] = requestReason;
    return map;
  }
}
